<?php
namespace modules;

use fostercommerce\snipcart\services\Orders;
use fostercommerce\snipcart\services\Products;
use fostercommerce\snipcart\services\Shipments;
use fostercommerce\snipcart\events\OrderEvent;
use fostercommerce\snipcart\events\InventoryEvent;
use fostercommerce\snipcart\events\ShippingRateEvent;
use fostercommerce\snipcart\helpers\FieldHelper;
use Craft;
use craft\mail\Message;
use yii\base\Event;

class StoreModule extends \yii\base\Module
{
    // Properties
    // =========================================================================

    protected $settings;


    // Public Methods
    // =========================================================================

    /**
     * Initializes the module.
     */
    public function init()
    {
        // Set a @modules alias pointed to the modules/ directory
        Craft::setAlias('@modules', __DIR__);

        // Set the controllerNamespace based on whether this is a console or web request
        if (Craft::$app->getRequest()->getIsConsoleRequest()) 
        {
            $this->controllerNamespace = 'modules\\console\\controllers';
        } 
        else 
        {
            $this->controllerNamespace = 'modules\\controllers';
        }

        /*
        Event::on(
            Products::class,
            Products::EVENT_PRODUCT_INVENTORY_CHANGE,
            function(InventoryEvent $event) {

                // fetch product detail info regardless of the field handle
                $productDetails = FieldHelper::getProductInfo($event->entry);
                
                // adjusted inventory = current + delta
                $newQuantity = $productDetails->inventory + $event->quantity;

                // send
                if ($newQuantity < 10) {
                    $message = new Message();
                    $message->setTo('mrmanager@suddenvalley.biz');
                    $message->setSubject($event->entry->title . ' stock is low!');
                    $message->setHtmlBody("<p>Re-stock soon! There are {$newQuantity} units left.</p>");

                    Craft::$app->mailer->send($message);
                }
            }
        );
        */

        /*
        Event::on(
            Shipments::class,
            Shipments::EVENT_BEFORE_RETURN_SHIPPING_RATES,
            function(ShippingRateEvent $event) {

                // respond with custom rates
                $event->rates = [
                    [
                        'cost' => 10,
                        'description' => '10$ shipping',
                    ],
                    [
                        'cost' => 20,
                        'description' => '20$ shipping',
                        'guaranteedDaysToDelivery' => 5,
                    ],
                ];

                // OR (comment one or the other)

                // respond with an error
                $event->isValid = false;
                $event->errors = [
                    [
                        'key' => 'invalid_postal_code',
                        'message' => 'The postal code is invalid.',
                    ],
                ];

            }
        );
        */

        parent::init();
    }

}
