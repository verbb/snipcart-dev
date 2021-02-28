<?php

return [
    'modules' => [
        'store-module' => \modules\StoreModule::class,
    ],
    'bootstrap' => ['store-module'],
    'components' => [
        'mailer' => function() {
            if (\fostercommerce\snipcart\helpers\VersionHelper::isCraft31())
            {
                $settings = \craft\helpers\App::mailSettings();
            }
            else
            {
                $settings = Craft::$app->getSystemSettings()->getEmailSettings();
            }

            $settings->transportType = \craft\mail\transportadapters\Smtp::class;
            $settings->transportSettings = [
                'host' => 'localhost',
                'useAuthentication' => false,
                'port' => '1025',
            ];

            $config = \craft\helpers\App::mailerConfig($settings);
            return Craft::createObject($config);
        },
    ],
];
