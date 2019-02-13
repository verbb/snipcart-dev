<?php
namespace modules;

use Craft;

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

        parent::init();
    }

}
