<?php 

use workingconcept\snipcart\models\Order;
use workingconcept\snipcart\models\Customer;
use workingconcept\snipcart\models\CustomField;
use craft\elements\Entry;
use workingconcept\snipcart\models\Item;
use workingconcept\snipcart\models\shipstation\Order as ShipStationOrder;
use WebhookCest;

class ShipStationOrderTest extends \Codeception\Test\Unit
{
    /**
     * @var \UnitTester
     */
    protected $tester;

    protected function _before()
    {
    }

    protected function _after()
    {
    }

    /**
     * Switch Craft's email driver to use our local Mailhog instance.
     */
    private function setMailhog()
    {
        $settings = Craft::$app->getSystemSettings()->getEmailSettings();
        $settings->transportType = 'craft\mail\transportadapters\Smtp';
        $settings->transportSettings = [
            'host' => 'localhost',
            'useAuthentication' => false,
            'port' => '1025',
        ];

        Craft::$app->getSystemSettings()->saveSettings('email', $settings->toArray());
    }

    private function _getLastEmail()
    {
        $client = new Client([
            'base_uri' => 'http://snipcart-test.ddev.local:8025/'
        ]);

        $response = $client->get('/api/v2/messages');
        $responseData = json_decode($response->getBody(), false);
        $messages = $responseData->items;

        return $messages[0];
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