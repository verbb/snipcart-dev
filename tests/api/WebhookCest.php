<?php 

use workingconcept\snipcart\controllers\WebhooksController;
use workingconcept\snipcart\models\Customer;
use workingconcept\snipcart\models\Order;
use workingconcept\snipcart\models\Subscription;
use workingconcept\snipcart\models\Item;
use workingconcept\snipcart\services\Webhooks;
use craft\elements\Entry;
use GuzzleHttp\Client;
use Codeception\Util\HttpCode;

class WebhookCest
{
    // Public Vars
    // =========================================================================

    // Private Vars
    // =========================================================================

    /**
     * @var string Local endpoint we'll use for webhook testing.
     */
    private $_webhookEndpoint = 'actions/snipcart/webhooks/handle';

    /**
     * @var string Local GraphQL endpoint.
     */
    private $_gqlEndpoint = 'api';


    // Public Methods
    // =========================================================================

    public function _before(\ApiTester $I)
    {
    }

    /**
     * Supply a webhook post with an invalid eventName.
     * @param ApiTester $I
     */
    public function testInvalidEvent(\ApiTester $I)
    {
        $I->haveHttpHeader('Content-Type', 'application/json');
        $I->sendPOST($this->_webhookEndpoint, [
            'eventName' => 'foo', // not real
            'mode'      => Webhooks::WEBHOOK_MODE_TEST,
            'createdOn' => date('c'),
            'content'   => $this->_getSnipcartOrder()
        ]);
        $I->seeResponseIsJson();
        $I->seeResponseCodeIs(\Codeception\Util\HttpCode::BAD_REQUEST);
        $I->seeResponseContains('{"success":false,"errors":{"reason":"Invalid event."}}');
    }

    /**
     * Supply a webhook post with an invalid mode.
     * @param ApiTester $I
     */
    public function testInvalidMode(\ApiTester $I)
    {
        $I->haveHttpHeader('Content-Type', 'application/json');
        $I->sendPOST($this->_webhookEndpoint, [
            'eventName' => WebhooksController::WEBHOOK_ORDER_COMPLETED,
            'mode'      => 'Special', // not 'Live' or 'Test'
            'createdOn' => date('c'),
            'content'   => $this->_getSnipcartOrder()
        ]);
        $I->seeResponseIsJson();
        $I->seeResponseCodeIs(\Codeception\Util\HttpCode::BAD_REQUEST);
        $I->seeResponseContains('{"success":false,"errors":{"reason":"Invalid mode."}}');
    }

    /**
     * Supply a webhook post with a missing mode.
     * @param ApiTester $I
     */
    public function testMissingMode(\ApiTester $I)
    {
        $I->haveHttpHeader('Content-Type', 'application/json');
        $I->sendPOST($this->_webhookEndpoint, [
            'eventName' => WebhooksController::WEBHOOK_ORDER_COMPLETED,
            // 'mode'      => Webhooks::WEBHOOK_MODE_TEST,
            // ^ deliberately left out
            'createdOn' => date('c'),
            'content'   => $this->_getSnipcartOrder()
        ]);
        $I->seeResponseIsJson();
        $I->seeResponseCodeIs(\Codeception\Util\HttpCode::BAD_REQUEST);
        $I->seeResponseContains('{"success":false,"errors":{"reason":"Request missing mode."}}');
    }

    /**
     * Missing content.
     * @param ApiTester $I
     */
    public function testEmptyContent(\ApiTester $I)
    {
        $I->haveHttpHeader('Content-Type', 'application/json');
        $I->sendPOST($this->_webhookEndpoint, [
            'eventName' => WebhooksController::WEBHOOK_ORDER_COMPLETED,
            'mode'      => Webhooks::WEBHOOK_MODE_TEST,
            'createdOn' => date('c'),
            'content'   => null
        ]);
        $I->seeResponseIsJson();
        $I->seeResponseCodeIs(\Codeception\Util\HttpCode::BAD_REQUEST);
        $I->seeResponseContains('{"success":false,"errors":{"reason":"Request missing content."}}');
    }

    /**
     * Bad token is rejected even in devMode.
     *
     * WARNING: will fail without API credentials since Snipcart API must be
     * used to validate the token.
     * @param ApiTester $I
     */
    public function testBadToken(\ApiTester $I)
    {
        $I->haveHttpHeader('Content-Type', 'application/json');
        $I->haveHttpHeader('x-snipcart-requesttoken', 'foobar');
        $I->sendPOST($this->_webhookEndpoint, [
            'eventName' => WebhooksController::WEBHOOK_ORDER_COMPLETED,
            'mode'      => Webhooks::WEBHOOK_MODE_TEST,
            'createdOn' => date('c'),
            'content'   => $this->_getSnipcartOrder(),
        ]);
        $I->seeResponseIsJson();
        $I->seeResponseCodeIs(\Codeception\Util\HttpCode::BAD_REQUEST);
        $I->seeResponseContains('{"success":false,"errors":{"reason":"Could not validate webhook request. Are you Snipcart?"}}');
    }

    /**
     * Non-string token is rejected even in devMode.
     *
     * WARNING: will fail without API credentials since Snipcart API must be
     * used to validate the token.
     * @param ApiTester $I
     */
    public function testNonStringToken(\ApiTester $I)
    {
        $I->haveHttpHeader('Content-Type', 'application/json');
        $I->haveHttpHeader('x-snipcart-requesttoken', '[ 1, 2, 3 ]');
        $I->sendPOST($this->_webhookEndpoint, [
            'eventName' => WebhooksController::WEBHOOK_ORDER_COMPLETED,
            'mode'      => Webhooks::WEBHOOK_MODE_TEST,
            'createdOn' => date('c'),
            'content'   => $this->_getSnipcartOrder(),
        ]);
        $I->seeResponseIsJson();
        $I->seeResponseCodeIs(\Codeception\Util\HttpCode::BAD_REQUEST);
        // can't figure out how to actually pass an array, so failure is good enough for now
        $I->seeResponseContains('{"success":false,"errors":{"reason":');
    }

    /**
     * Test `shippingrates.fetch` for a valid order in progress.
     * @param ApiTester $I
     */
    public function testFetchRates(\ApiTester $I)
    {
        $I->haveHttpHeader('Content-Type', 'application/json');
        $I->sendPOST($this->_webhookEndpoint, [
            'eventName' => WebhooksController::WEBHOOK_SHIPPINGRATES_FETCH,
            'mode'      => Webhooks::WEBHOOK_MODE_TEST,
            'createdOn' => date('c'),
            'content'   => $this->_getSnipcartOrder(),
        ]);
        $I->seeResponseIsJson();
        $I->seeResponseCodeIs(\Codeception\Util\HttpCode::OK);
        $I->seeResponseContains('"rates":');
    }

    /**
     * Attempt to fetch rates for an order that doesn't have shippable items.
     * @param ApiTester $I
     */
    public function testUnshippableOrder(\ApiTester $I)
    {
        $order = $this->_getSnipcartOrder();

        foreach ($order['items'] as &$item)
        {
            $item['shippable'] = false;
        }

        $I->haveHttpHeader('Content-Type', 'application/json');
        $I->sendPOST($this->_webhookEndpoint, [
            'eventName' => WebhooksController::WEBHOOK_SHIPPINGRATES_FETCH,
            'mode'      => Webhooks::WEBHOOK_MODE_TEST,
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
     * WARNING: Iffy test; depends on store configuration!
     *
     * @param ApiTester $I
     */
    public function testInvalidCountryRates(\ApiTester $I)
    {
        $person = $this->_getTestPerson();
        $person->billingAddressCountry = 'CA';
        $person->shippingAddressCountry = 'CA';
        $person->billingAddressPostalCode = 'A1A 1A1';
        $person->shippingAddressPostalCode = 'A1A 1A1';

        $I->haveHttpHeader('Content-Type', 'application/json');
        $I->sendPOST($this->_webhookEndpoint, [
            'eventName' => WebhooksController::WEBHOOK_SHIPPINGRATES_FETCH,
            'mode'      => Webhooks::WEBHOOK_MODE_TEST,
            'createdOn' => date('c'), // "2018-12-05T18:43:22.2419667Z"
            'content'   => $this->_getSnipcartOrder($person)
        ]);
        $I->seeResponseIsJson();
        $I->seeResponseCodeIs(\Codeception\Util\HttpCode::OK); // 200
        $I->seeResponseContains('"rates":[]');
    }

    // TODO: test quantity adjustment per configuration

//    public function testMatrixQuantityDecrement(\ApiTester $I) {}
//    public function testQuantityDecrement(\ApiTester $I) {}


    /**
     * Test the `order.completed` webhook, which should result in success and
     * give us back a ShipStation order ID.
     *
     * WARNING: will fail without ShipStation API credentials.
     * WARNING: will fail if admin email notifications are off.
     *
     * @param ApiTester $I
     */
    public function testOrderCompletion(\ApiTester $I)
    {
        $order = $this->_getSnipcartOrder();

        $I->haveHttpHeader('Content-Type', 'application/json');
        $I->sendPOST($this->_webhookEndpoint, [
            'eventName' => WebhooksController::WEBHOOK_ORDER_COMPLETED,
            'mode'      => Webhooks::WEBHOOK_MODE_TEST,
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

    /**
     * Test the `order.completed` webhook with Product Details on a Matrix field,
     * which should result in success and give us back a ShipStation order ID.
     *
     * WARNING: will fail without ShipStation API credentials.
     * WARNING: will fail if admin email notifications are off.
     *
     * @param ApiTester $I
     */
    public function testMatrixProductOrderCompletion(\ApiTester $I)
    {
        $person = $this->_getTestPerson();
        $items = [ $this->_getMatrixTestItem() ];

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
            'shippingMethod' => 'UPS Ground',
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

        $orderArray = $order->toArray([], $order->extraFields(), true);

        if (isset($orderArray['cpUrl']))
        {
            /**
             * Remove read-only property that would throw an exception
             * if we tried to set it.
             */
            unset($orderArray['cpUrl']);
        }

        $I->haveHttpHeader('Content-Type', 'application/json');
        $I->sendPOST($this->_webhookEndpoint, [
            'eventName' => WebhooksController::WEBHOOK_ORDER_COMPLETED,
            'mode'      => Webhooks::WEBHOOK_MODE_TEST,
            'createdOn' => date('c'), // "2018-12-05T18:43:22.2419667Z"
            'content'   => $orderArray
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


    /**
     * Send an order payload with expected properties on the root order and a
     * nested order item. The property should be discarded when the model is
     * populated instead of throwing an exception.
     * @param ApiTester $I
     */
    public function testUnknownPayloadProperties(\ApiTester $I)
    {
        $order = $this->_getSnipcartOrder();

        $order['nonExistentOrderProperty'] = 'foo!';
        $order['nonExistentOrderPropertyTwo'] = 'foo!';
        $order['items'][0]['nonExistentItemProperty'] = 'foo!';

        $I->haveHttpHeader('Content-Type', 'application/json');
        $I->sendPOST($this->_webhookEndpoint, [
            'eventName' => WebhooksController::WEBHOOK_ORDER_COMPLETED,
            'mode'      => Webhooks::WEBHOOK_MODE_TEST,
            'createdOn' => date('c'), // "2018-12-05T18:43:22.2419667Z"
            'content'   => $order
        ]);
        $I->seeResponseIsJson();
        $I->seeResponseCodeIs(\Codeception\Util\HttpCode::OK);
    }

    /**
     * Test `order.status.changed` webhook.
     * @param ApiTester $I
     */
    public function testOrderStatusChanged(\ApiTester $I)
    {
        $order = $this->_getSnipcartOrder();

        $I->haveHttpHeader('Content-Type', 'application/json');
        $I->sendPOST($this->_webhookEndpoint, [
            'from'      => 'Disputed',
            'to'        => 'Shipped',
            'eventName' => WebhooksController::WEBHOOK_ORDER_STATUS_CHANGED,
            'mode'      => Webhooks::WEBHOOK_MODE_TEST,
            'createdOn' => date('c'), // "2018-12-05T18:43:22.2419667Z"
            'content'   => $order
        ]);
        $I->seeResponseIsJson();
        $I->seeResponseCodeIs(\Codeception\Util\HttpCode::OK);
    }

    /**
     * Test `order.paymentStatus.changed` webhook.
     * @param ApiTester $I
     */
    public function testOrderPaymentStatusChanged(\ApiTester $I)
    {
        $order = $this->_getSnipcartOrder();

        $I->haveHttpHeader('Content-Type', 'application/json');
        $I->sendPOST($this->_webhookEndpoint, [
            'from'      => 'Authorized',
            'to'        => 'Paid',
            'eventName' => WebhooksController::WEBHOOK_ORDER_PAYMENT_STATUS_CHANGED,
            'mode'      => Webhooks::WEBHOOK_MODE_TEST,
            'createdOn' => date('c'), // "2018-12-05T18:43:22.2419667Z"
            'content'   => $order
        ]);
        $I->seeResponseIsJson();
        $I->seeResponseCodeIs(\Codeception\Util\HttpCode::OK);
    }

    /**
     * Test `order.trackingNumber.changed` webhook.
     * @param ApiTester $I
     */
    public function testOrderTrackingNumberChanged(\ApiTester $I)
    {
        $order = $this->_getSnipcartOrder();

        $I->haveHttpHeader('Content-Type', 'application/json');
        $I->sendPOST($this->_webhookEndpoint, [
            'trackingNumber' => '123',
            'trackingUrl'    => 'http://fedex.com',
            'eventName'      => WebhooksController::WEBHOOK_ORDER_TRACKING_NUMBER_CHANGED,
            'mode'           => Webhooks::WEBHOOK_MODE_TEST,
            'createdOn'      => date('c'), // "2018-12-05T18:43:22.2419667Z"
            'content'        => $order
        ]);
        $I->seeResponseIsJson();
        $I->seeResponseCodeIs(\Codeception\Util\HttpCode::OK);
    }

    /**
     * Test `subscription.created` webhook.
     * @param ApiTester $I
     */
    public function testSubscriptionCreated(\ApiTester $I)
    {
        $subscription = $this->_getSnipcartSubscription();

        $I->haveHttpHeader('Content-Type', 'application/json');
        $I->sendPOST($this->_webhookEndpoint, [
            'eventName'      => WebhooksController::WEBHOOK_SUBSCRIPTION_CREATED,
            'mode'           => Webhooks::WEBHOOK_MODE_TEST,
            'createdOn'      => date('c'), // "2018-12-05T18:43:22.2419667Z"
            'content'        => $subscription
        ]);
        $I->seeResponseIsJson();
        $I->seeResponseCodeIs(\Codeception\Util\HttpCode::OK);
    }

    /**
     * Test `subscription.cancelled` webhook.
     * @param ApiTester $I
     */
    public function testSubscriptionCancelled(\ApiTester $I)
    {
        $subscription = $this->_getSnipcartSubscription();

        $I->haveHttpHeader('Content-Type', 'application/json');
        $I->sendPOST($this->_webhookEndpoint, [
            'eventName'      => WebhooksController::WEBHOOK_SUBSCRIPTION_CANCELLED,
            'mode'           => Webhooks::WEBHOOK_MODE_TEST,
            'createdOn'      => date('c'), // "2018-12-05T18:43:22.2419667Z"
            'content'        => $subscription
        ]);
        $I->seeResponseIsJson();
        $I->seeResponseCodeIs(\Codeception\Util\HttpCode::OK);
    }

    /**
     * Test `subscription.paused` webhook.
     * @param ApiTester $I
     */
    public function testSubscriptionPaused(\ApiTester $I)
    {
        $subscription = $this->_getSnipcartSubscription();

        $I->haveHttpHeader('Content-Type', 'application/json');
        $I->sendPOST($this->_webhookEndpoint, [
            'eventName'      => WebhooksController::WEBHOOK_SUBSCRIPTION_PAUSED,
            'mode'           => Webhooks::WEBHOOK_MODE_TEST,
            'createdOn'      => date('c'), // "2018-12-05T18:43:22.2419667Z"
            'content'        => $subscription
        ]);
        $I->seeResponseIsJson();
        $I->seeResponseCodeIs(\Codeception\Util\HttpCode::OK);
    }

    /**
     * Test `subscription.resumed` webhook.
     * @param ApiTester $I
     */
    public function testSubscriptionResumed(\ApiTester $I)
    {
        $subscription = $this->_getSnipcartSubscription();

        $I->haveHttpHeader('Content-Type', 'application/json');
        $I->sendPOST($this->_webhookEndpoint, [
            'eventName'      => WebhooksController::WEBHOOK_SUBSCRIPTION_RESUMED,
            'mode'           => Webhooks::WEBHOOK_MODE_TEST,
            'createdOn'      => date('c'), // "2018-12-05T18:43:22.2419667Z"
            'content'        => $subscription
        ]);
        $I->seeResponseIsJson();
        $I->seeResponseCodeIs(\Codeception\Util\HttpCode::OK);
    }

    /**
     * Test `subscription.invoice.created` webhook.
     * @param ApiTester $I
     */
    public function testSubscriptionInvoiceCreated(\ApiTester $I)
    {
        $subscription = $this->_getSnipcartSubscription();

        $I->haveHttpHeader('Content-Type', 'application/json');
        $I->sendPOST($this->_webhookEndpoint, [
            'eventName'      => WebhooksController::WEBHOOK_SUBSCRIPTION_INVOICE_CREATED,
            'mode'           => Webhooks::WEBHOOK_MODE_TEST,
            'createdOn'      => date('c'), // "2018-12-05T18:43:22.2419667Z"
            'content'        => $subscription
        ]);
        $I->seeResponseIsJson();
        $I->seeResponseCodeIs(\Codeception\Util\HttpCode::OK);
    }

    /**
     * Test `taxes.calculate` webhook.
     * @param ApiTester $I
     */
    public function testTaxesCalculate(\ApiTester $I)
    {
        $order = $this->_getSnipcartOrder();

        $I->haveHttpHeader('Content-Type', 'application/json');
        $I->sendPOST($this->_webhookEndpoint, [
            'eventName'      => WebhooksController::WEBHOOK_TAXES_CALCULATE,
            'mode'           => Webhooks::WEBHOOK_MODE_TEST,
            'createdOn'      => date('c'), // "2018-12-05T18:43:22.2419667Z"
            'content'        => $order
        ]);
        $I->seeResponseIsJson();
        $I->seeResponseCodeIs(\Codeception\Util\HttpCode::OK);
        $I->seeResponseContains('{"taxes":[]}');
    }

    /**
     * Test `customauth:customer_updated` webhook.
     * @param ApiTester $I
     */
    public function testCustomerUpdated(\ApiTester $I)
    {
        $customer = $this->_getTestPerson();

        $I->haveHttpHeader('Content-Type', 'application/json');
        $I->sendPOST($this->_webhookEndpoint, [
            'eventName'      => WebhooksController::WEBHOOK_CUSTOMER_UPDATED,
            'mode'           => Webhooks::WEBHOOK_MODE_TEST,
            'createdOn'      => date('c'), // "2018-12-05T18:43:22.2419667Z"
            'content'        => $customer
        ]);
        $I->seeResponseIsJson();
        $I->seeResponseCodeIs(\Codeception\Util\HttpCode::OK);
    }

    public function testGraphqlQuery(\ApiTester $I)
    {
        $I->haveHttpHeader('Authorization', 'Bearer SUPERSECRETTESTTOKEN');
        $I->haveHttpHeader('Content-Type', 'application/json');
        $I->sendPOST($this->_gqlEndpoint, [
            'query' => '
                {
                  entries(section: "products", slug: "infinity-gauntlet") {
                    ... on products_products_Entry {
                      productDetails {
                        sku
                        price
                        shippable
                        taxable
                        weight
                        weightUnit
                        length
                        width
                        height
                        inventory
                        dimensionsUnit
                      }
                    }
                  }
                }'
        ]);

        $I->seeResponseIsJson();
        $I->seeResponseCodeIs(HttpCode::OK);

        $I->seeResponseContains('"sku":"infinity-gauntlet"');
        $I->seeResponseContains('"price":499.98');
        $I->seeResponseContains('"shippable":true');
        $I->seeResponseContains('"taxable":true');
        $I->seeResponseContains('"weight":3');
        $I->seeResponseContains('"weightUnit":"pounds"');
        $I->seeResponseContains('"length":14');
        $I->seeResponseContains('"width":8');
        $I->seeResponseContains('"height":8');
        $I->seeResponseContains('"inventory":1');
        $I->seeResponseContains('"dimensionsUnit":"inches"');
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
    private function _getSnipcartOrder($person = true, $items = true, $asArray = true)
    {
        if ($person === true)
        {
            $person = $this->_getTestPerson();
        }

        if ($items === true)
        {
            $items = $this->_getTestItems(3);
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
            'shippingMethod' => 'UPS Ground',
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

        $orderArray = $order->toArray([], $order->extraFields(), true);

        if (isset($orderArray['cpUrl']))
        {
            /**
             * Remove read-only property that would throw an exception
             * if we tried to set it.
             */
            unset($orderArray['cpUrl']);
        }

        return $orderArray;
    }

    /**
     * Get a fake subscription record.
     *
     * @return array Subscription as array
     */
    public function _getSnipcartSubscription()
    {
        $subscription = new Subscription([
            'user' => $this->_getTestPerson(),
            'initialOrderToken' => '1912e4c1-d008-4c15-ab12-fe21a76d30d4',
            'firstInvoiceReceivedOn' => date('c'),
            'schedule' => [
                'interval' => 'Day',
                'intervalCount' => 1,
                'trialPeriodInDays' => null,
                'startsOn' => '2017-10-04T00:00:00Z'
            ],
            'itemId' => 'eb52e6e3-d8fa-4db4-b0a9-83c238ae1542',
            'id' => '2df76eb5-410e-48ac-a130-163ab9377112',
            'name' => 'A Test Subscription Plan',
            'creationDate' => date('c'),
            'modificationDate' => date('c'),
            'cancelledOn' => null,
            'amount' => 30,
            'quantity' => 1,
            'userDefinedId' => 'TEST_SUBSCRIPTION_PLAN',
            'totalSpent' => 30,
            'status' => 'Paid',
            'gatewayId' => null,
            'metadata' => null,
            'cartId' => null,
            'recurringShipping' => '',
            'shippingCharged' => false,
            'nextBillingDate' => '',
            'upcomingPayments' => '',
            'invoiceNumber' => 'SNIP-0000',
        ]);

        $subscriptionArray = $subscription->toArray([], $subscription->extraFields(), true);

        if (isset($subscriptionArray['cpUrl']))
        {
            /**
             * Remove read-only property that would throw an exception
             * if we tried to set it.
             */
            unset($subscriptionArray['cpUrl']);
        }

        return $subscriptionArray;
    }

    /**
     * Get a test person.
     *
     * @return Customer
     */
    private function _getTestPerson()
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

    private function _getMatrixTestItem()
    {
        $entry = Entry::find()
            ->section(['products'])
            ->type('complexProducts')
            ->one();

        foreach ($entry->pageBlocks->all() as $pageBlock)
        {
            // TODO: don't use hardcoded field values

            if (isset($pageBlock->productInfo))
            {
                $item = new Item([
                    'token'        => 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx',
                    'name'         => $pageBlock->productName ?? 'Unnamed Item',
                    'price'        => $pageBlock->productInfo->price,
                    'quantity'     => 1,
                    'url'          => $entry->url,
                    'id'           => $pageBlock->productInfo->sku,
                    'shippable'    => $pageBlock->productInfo->shippable,
                    'taxable'      => $pageBlock->productInfo->taxable,
                    'weight'       => $pageBlock->productInfo->weight,
                    'totalWeight'  => $pageBlock->productInfo->weight,
                    'uniqueId'     => $pageBlock->productInfo->sku,
                    'customFields' => [
                        [
                            'name'         => 'customOption',
                            'displayValue' => 'Custom Option',
                            'type'         => 'dropdown',
                            'value'        => 'Option A',
                        ],
                    ],
                    'unitPrice' => $pageBlock->productInfo->price,
                ]);

                return $item;
            }
        }

        return null;
    }

    /**
     * Get test order items.
     *
     * @param int    $numberOfItems Number of items to return.
     * @param string $type          Entry type (`products` or `complexProducts`)
     *
     * @return Item[]
     */
    private function _getTestItems($numberOfItems = 3, $type = 'products')
    {
        $entries = Entry::find()
            ->section(['products'])
            ->limit($numberOfItems)
            ->type($type)
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
            'base_uri' => 'http://snipcart-test.ddev.site:8025/'
        ]);

        $response = $client->get('/api/v2/messages');
        $responseData = json_decode($response->getBody(), false);
        $messages = $responseData->items;

        return $messages[0] ?? null;
    }

    private function _generateRandomString($length = 10): string
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

    private function _getTestGqlQuery(): string
    {
        return '
            { 
                entries(section: "products") {
                    title
                    ... on products_products_Entry {
                        productDetails {
                            sku
                            price
                            shippable
                            taxable
                            weight
                            weightUnit
                            length
                            width
                            height
                            dimensionsUnit
                            inventory
                        }
                    }
                    ... on products_complexProducts_Entry {
                        pageBlocks {
                            ... on pageBlocks_product_BlockType {
                                productInfo {
                                    sku
                                    price
                                    shippable
                                    taxable
                                    weight
                                    weightUnit
                                    length
                                    width
                                    height
                                    dimensionsUnit
                                    inventory
                                }
                            }
                        }
                    }
                }  
            }
        ';
    }

}