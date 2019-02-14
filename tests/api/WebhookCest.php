<?php 

use workingconcept\snipcart\controllers\WebhooksController;
use workingconcept\snipcart\models\Customer;
use workingconcept\snipcart\models\Order;
use workingconcept\snipcart\models\Item;
use workingconcept\snipcart\fields\ProductDetails;
use craft\elements\Entry;
use workingconcept\snipcart\Snipcart;
use GuzzleHttp\Client;

class WebhookCest
{
    // TODO: simulate an API outage and make sure exceptions are thrown (and notified) as expected

    public $mailhogClient;

    // Public Methods
    // =========================================================================

    public function _before(\ApiTester $I)
    {
    }

    /**
     * Supply a webhook post with an invalid eventName.
     */
    public function testInvalidEvent(\ApiTester $I)
    {
        $I->haveHttpHeader('Content-Type', 'application/json');
        $I->sendPOST('/actions/snipcart/webhooks/handle', [
            'eventName' => 'foo',
            'mode'      => WebhooksController::WEBHOOK_MODE_TEST,
            'createdOn' => date('c'),
            'content'   => $this->getSnipcartOrder()
        ]);
        $I->seeResponseIsJson();
        $I->seeResponseCodeIs(\Codeception\Util\HttpCode::BAD_REQUEST);
        $I->seeResponseContains('{"success":false,"errors":{"reason":"Invalid event."}}');
    }

    /**
     * Supply a webhook post with an invalid mode.
     */
    public function testInvalidMode(\ApiTester $I)
    {
        $I->haveHttpHeader('Content-Type', 'application/json');
        $I->sendPOST('/actions/snipcart/webhooks/handle', [
            'eventName' => WebhooksController::WEBHOOK_ORDER_COMPLETED,
            'mode'      => 'Special',
            'createdOn' => date('c'),
            'content'   => $this->getSnipcartOrder()
        ]);
        $I->seeResponseIsJson();
        $I->seeResponseCodeIs(\Codeception\Util\HttpCode::BAD_REQUEST);
        $I->seeResponseContains('{"success":false,"errors":{"reason":"Invalid mode."}}');
    }

    /**
     * Supply a webhook post with a missing mode.
     */
    public function testMissingMode(\ApiTester $I)
    {
        $I->haveHttpHeader('Content-Type', 'application/json');
        $I->sendPOST('/actions/snipcart/webhooks/handle', [
            'eventName' => WebhooksController::WEBHOOK_ORDER_COMPLETED,
            'createdOn' => date('c'),
            'content'   => $this->getSnipcartOrder()
        ]);
        $I->seeResponseIsJson();
        $I->seeResponseCodeIs(\Codeception\Util\HttpCode::BAD_REQUEST);
        $I->seeResponseContains('{"success":false,"errors":{"reason":"Request missing mode."}}');
    }

    /**
     * Missing content.
     */
    public function testEmptyContent(\ApiTester $I)
    {
        $I->haveHttpHeader('Content-Type', 'application/json');
        $I->sendPOST('/actions/snipcart/webhooks/handle', [
            'eventName' => WebhooksController::WEBHOOK_ORDER_COMPLETED,
            'mode'      => WebhooksController::WEBHOOK_MODE_TEST,
            'createdOn' => date('c'),
            'content'   => null
        ]);
        $I->seeResponseIsJson();
        $I->seeResponseCodeIs(\Codeception\Util\HttpCode::BAD_REQUEST);
        $I->seeResponseContains('{"success":false,"errors":{"reason":"Request missing content."}}');
    }

    /**
     * Bad token is rejected even in devMode.
     */
    public function testBadToken(\ApiTester $I)
    {
        $I->haveHttpHeader('Content-Type', 'application/json');
        $I->haveHttpHeader('x-snipcart-requesttoken', 'foobar');
        $I->sendPOST('/actions/snipcart/webhooks/handle', [
            'eventName' => WebhooksController::WEBHOOK_ORDER_COMPLETED,
            'mode'      => WebhooksController::WEBHOOK_MODE_TEST,
            'createdOn' => date('c'),
            'content'   => $this->getSnipcartOrder(),
        ]);
        $I->seeResponseIsJson();
        $I->seeResponseCodeIs(\Codeception\Util\HttpCode::BAD_REQUEST);
        $I->seeResponseContains('{"success":false,"errors":{"reason":"Could not validate webhook request. Are you Snipcart?"}}');
    }

    /**
     * Non-string token is rejected even in devMode.
     */
    public function testNonStringToken(\ApiTester $I)
    {
        $I->haveHttpHeader('Content-Type', 'application/json');
        $I->haveHttpHeader('x-snipcart-requesttoken', '[ 1, 2, 3 ]');
        $I->sendPOST('/actions/snipcart/webhooks/handle', [
            'eventName' => WebhooksController::WEBHOOK_ORDER_COMPLETED,
            'mode'      => WebhooksController::WEBHOOK_MODE_TEST,
            'createdOn' => date('c'),
            'content'   => $this->getSnipcartOrder(),
        ]);
        $I->seeResponseIsJson();
        $I->seeResponseCodeIs(\Codeception\Util\HttpCode::BAD_REQUEST);
        // can't figure out how to actually pass an array, so failure is good enough for now
        $I->seeResponseContains('{"success":false,"errors":{"reason":');
    }

    /**
     * Fetch shipping rates for a valid order.
     */
    public function testFetchRates(\ApiTester $I)
    {
        $I->haveHttpHeader('Content-Type', 'application/json');
        $I->sendPOST('/actions/snipcart/webhooks/handle', [
            'eventName' => WebhooksController::WEBHOOK_SHIPPINGRATES_FETCH,
            'mode'      => WebhooksController::WEBHOOK_MODE_TEST,
            'createdOn' => date('c'),
            'content'   => $this->getSnipcartOrder(),
        ]);
        $I->seeResponseIsJson();
        $I->seeResponseCodeIs(\Codeception\Util\HttpCode::OK);
        $I->seeResponseContains('"rates":');
    }

    /**
     * Attempt to fetch rates for an order that doesn't have shippable items.
     */
    public function testUnshippableOrder(\ApiTester $I)
    {
        $order = $this->getSnipcartOrder();

        foreach ($order['items'] as &$item)
        {
            $item['shippable'] = false;
        }

        $I->haveHttpHeader('Content-Type', 'application/json');
        $I->sendPOST('/actions/snipcart/webhooks/handle', [
            'eventName' => WebhooksController::WEBHOOK_SHIPPINGRATES_FETCH,
            'mode'      => WebhooksController::WEBHOOK_MODE_TEST,
            'createdOn' => date('c'),
            'content'   => $order,
        ]);
        $I->seeResponseIsJson();
        $I->seeResponseCodeIs(\Codeception\Util\HttpCode::OK);
        $I->cantSeeResponseContains('"rates":');
    }

    /**
     * Attempt to fetch rates to Canada, even though we only ship to the US.
     * 
     * Depends on store configuration!
     */
    public function testInvalidCountryRates(\ApiTester $I)
    {
        $person = $this->getTestPerson();
        $person->billingAddressCountry = 'CA';
        $person->shippingAddressCountry = 'CA';
        $person->billingAddressPostalCode = 'A1A 1A1';
        $person->shippingAddressPostalCode = 'A1A 1A1';

        $I->haveHttpHeader('Content-Type', 'application/json');
        $I->sendPOST('/actions/snipcart/webhooks/handle', [
            'eventName' => WebhooksController::WEBHOOK_SHIPPINGRATES_FETCH,
            'mode'      => WebhooksController::WEBHOOK_MODE_TEST,
            'createdOn' => date('c'), // "2018-12-05T18:43:22.2419667Z"
            'content'   => $this->getSnipcartOrder($person)
        ]);
        $I->seeResponseIsJson();
        $I->seeResponseCodeIs(\Codeception\Util\HttpCode::OK); // 200
        $I->seeResponseContains('"rates":[]');
    }

    /**
     * Test the order completion webhook, which should result in success and
     * give us back a ShipStation order ID.
     *
     * @param ApiTester $I
     */
    public function testOrderCompletion(\ApiTester $I)
    {
        $order = $this->getSnipcartOrder();

        $I->haveHttpHeader('Content-Type', 'application/json');
        $I->sendPOST('/actions/snipcart/webhooks/handle', [
            'eventName' => WebhooksController::WEBHOOK_ORDER_COMPLETED,
            'mode'      => WebhooksController::WEBHOOK_MODE_TEST,
            'createdOn' => date('c'), // "2018-12-05T18:43:22.2419667Z"
            'content'   => $order
        ]);
        $I->seeResponseIsJson();
        $I->seeResponseCodeIs(\Codeception\Util\HttpCode::OK);

        // when devMode = true, order won't actually be sent to ShipStation and we'll get order ID 99999999 in the response
        $I->seeResponseContains('{"success":true,"shipstation_order_id":99999999}');
        
        
        // TODO: make sure notifications are enabled, otherwise this will fail!

        $lastMessage = $this->_getLastEmail();

        $I->assertTrue($lastMessage !== null, 'Fetched last email.');

        $lastMessageBody = $lastMessage->Content->Body;
        $lastMessageDateString = $lastMessage->Content->Headers->Date[0]; // "Wed, 19 Dec 2018 14:32:47 -0800"
        
        $containsInvoiceNumber = strpos((string)$lastMessageBody, $order['invoiceNumber']) !== false;
        $containsShipStationReference = strpos((string)$lastMessageBody, 'ShipStation #') !== false;
        
        $I->assertTrue($containsInvoiceNumber, 'Email contains invoice number.');
        $I->assertTrue($containsShipStationReference, 'Email contains ShipStation ID.');
    }

    // TODO: make sure ShipStation gets correct weight unit
    // TODO: make sure ShipStation gets correct dimension unit
    // TODO: confirm exception or logging when no shipping rates are returned
    // TODO: confirm presence of order note when configured
    // TODO: confirm presence of gift note when configured
    // TODO: confirm correct gift status when configured
    // TODO: test console order recovery
        // correctly identifies orders that didn't make it
        // stops sending notifications after desired amount of time

    // TODO: confirm that best-guess postage retrieval works if completed order shipping amount doesn't match log
    // TODO: use custom module to test every webhook event
    // TODO: test weight conversion
        // TODO: weight goes to Snipcart in grams
        // TODO: weight goes to ShipStation with proper unit specification
    // TODO: test custom email templates
        // TODO: admin
        // TODO: customer
    // TODO: test quantity deprecation per configuration

    // Private Methods
    // =========================================================================

    /**
     * Get Order for testing.
     *
     * @param bool|Customer $person ` true` to autogenerate person, or pass your own
     * @param bool|array    $items   `true` to autogenerate items, or pass your own
     * @param bool          $asArray `true` (default) if the order should be an associative array
     *
     * @return array Order as an array
     */
    private function getSnipcartOrder($person = true, $items = true, $asArray = true)
    {
        if ($person === true)
        {
            $person = $this->getTestPerson();
        }

        if ($items === true)
        {
            $items = $this->getTestItems(3);
        }

        $totalWeight = 0;
        $grandTotal = 0;
        $itemsTotal = 0;

        foreach ($items as $item)
        {
            $totalWeight += $item->totalWeight;
            $grandTotal += $item->price;
            $itemsTotal += $item->quantity;
        }

        $order = new Order([
            'invoiceNumber' => 'SNIP-' . $this->_generateRandomString(6),
            'token' => 'befd6350-1efc-43f3-b605-86bad6fb74aG',
            'creationDate' => date('c'),
            'modificationDate' => date('c'),
            'status' => 'InProgress',
            'email' => $person->email,
            'billingAddressName'       => $person->billingAddressName,
            'billingAddressAddress1'   => $person->billingAddressAddress1,
            'billingAddressAddress2'   => $person->billingAddressAddress2,
            'billingAddressCity'       => $person->billingAddressCity,
            'billingAddressProvince'   => $person->billingAddressProvince,
            'billingAddressPostalCode' => $person->billingAddressPostalCode,
            'billingAddressCountry'    => $person->billingAddressCountry,
            'billingAddressPhone'      => $person->billingAddressPhone,
            'billingAddress'           => [
                'fullName'   => $person->billingAddressName,
                'name'       => $person->billingAddressName,
                'address1'   => $person->billingAddressAddress1,
                'address2'   => $person->billingAddressAddress2,
                'city'       => $person->billingAddressCity,
                'province'   => $person->billingAddressProvince,
                'postalCode' => $person->billingAddressPostalCode,
                'country'    => $person->billingAddressCountry,
                'phone'      => $person->billingAddressPhone,
            ],
            'shippingAddressName'       => $person->shippingAddressName,
            'shippingAddressAddress1'   => $person->shippingAddressAddress1,
            'shippingAddressAddress2'   => $person->shippingAddressAddress2,
            'shippingAddressCity'       => $person->shippingAddressCity,
            'shippingAddressProvince'   => $person->shippingAddressProvince,
            'shippingAddressPostalCode' => $person->shippingAddressPostalCode,
            'shippingAddressCountry'    => $person->shippingAddressCountry,
            'shippingAddressPhone'      => $person->shippingAddressPhone,
            'shippingAddress'           => [
                'fullName'   => $person->shippingAddressName,
                'name'       => $person->shippingAddressName,
                'address1'   => $person->shippingAddressAddress1,
                'address2'   => $person->shippingAddressAddress2,
                'city'       => $person->shippingAddressCity,
                'province'   => $person->shippingAddressProvince,
                'postalCode' => $person->shippingAddressPostalCode,
                'country'    => $person->shippingAddressCountry,
                'phone'      => $person->shippingAddressPhone,
            ],
            'shippingAddressSameAsBilling' => true,
            'creditCardLast4Digits' => null,
            'shippingFees' => 5,
            'taxableTotal' => 0,
            'taxesTotal' => 0,
            'itemsTotal' => $itemsTotal,
            'totalWeight' => $totalWeight,
            'grandTotal' => $grandTotal,
            'finalGrandTotal' => $grandTotal,
            'ipAddress' => '0.0.0.0',
            'userAgent' => 'test',
            'items' => $items,
        ]);

        return $order->toArray([], $order->extraFields(), true);
    }

    /**
     * Get a test person.
     *
     * @return Customer
     */
    private function getTestPerson()
    {
        return new Customer([
            'email'                     => 'tobias@actorpull.biz',
            'billingAddressName'        => 'Tobias Fünke',
            'billingAddressFirstName'   => 'Tobias',
            'billingAddressAddress1'    => '1234 Balboa Towers Circle',
            'billingAddressAddress2'    => 'Apt 1234',
            'billingAddressCity'        => 'Los Angeles',
            'billingAddressProvince'    => 'CA',
            'billingAddressPostalCode'  => '92706',
            'billingAddressPhone'       => '(555) 555-5555',
            'billingAddressCountry'     => 'US',
            'shippingAddressName'       => 'Tobias Fünke',
            'shippingAddressFirstName'  => 'Tobias',
            'shippingAddressAddress1'   => '1234 Balboa Towers Circle',
            'shippingAddressAddress2'   => 'Apt 1234',
            'shippingAddressCity'       => 'Los Angeles',
            'shippingAddressProvince'   => 'CA',
            'shippingAddressPostalCode' => '92706',
            'shippingAddressPhone'      => '(555) 555-5555',
            'shippingAddressCountry'    => 'US',
        ]);
    }

    /**
     * Get test order items.
     *
     * @param int $numberOfItems Number of items to return.
     *
     * @return Item[]
     */
    private function getTestItems($numberOfItems = 3)
    {
        $entries = Entry::find()
            ->section(['products'])
            ->limit($numberOfItems)
            ->orderBy('RAND()')
            ->all();
        
        $items = [];

        foreach ($entries as $entry)
        {
            $detailsHandle = \workingconcept\snipcart\helpers\FieldHelper::getProductInfoFieldHandle($entry);

            $price     = $entry->{$detailsHandle}->price;
            $shippable = $entry->{$detailsHandle}->shippable;
            $taxable   = $entry->{$detailsHandle}->taxable;
            $weight    = $entry->{$detailsHandle}->weight;
            $sku       = $entry->{$detailsHandle}->sku;

            $items[] = new Item([
                'token'        => 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx',
                'name'         => $entry->title,
                'price'        => $price,
                'quantity'     => 1,
                'url'          => $entry->url,
                'id'           => $sku,
                'shippable'    => $shippable,
                'taxable'      => $taxable,
                'weight'       => $weight,
                'totalWeight'  => $weight,
                'uniqueId'     => $sku,
                'customFields' => [
                    [
                        'name'         => 'Grind',
                        'displayValue' => 'Whole Bean',
                        'type'         => 'dropdown',
                        'value'        => 'Whole Bean',
                    ],
                ],
                'unitPrice' => $price,
            ]);
        }

        return $items;
    }

    private function _getLastEmail()
    {
        $client = new Client([
            'base_uri' => 'http://snipcart-test.ddev.local:8025/'
        ]);

        $response = $client->get('/api/v2/messages');
        $responseData = json_decode($response->getBody(), false);
        $messages = $responseData->items;

        return $messages[0] ?? null;
    }

    function _generateRandomString($length = 10) 
    {
        $characters       = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
        $charactersLength = strlen($characters);
        $randomString     = '';
        
        for ($i = 0; $i < $length; $i++) 
        {
            $randomString .= $characters[rand(0, $charactersLength - 1)];
        }

        return $randomString;
    }

}