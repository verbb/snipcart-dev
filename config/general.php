<?php

return [
    '*' => [
        'defaultWeekStartDay'  => 0,
        'enableCsrfProtection' => true,
        'omitScriptNameInUrls' => true,
        'cpTrigger'            => 'admin',
        'securityKey'          => getenv('SECURITY_KEY'),
    ],

    'dev' => [
        'siteUrl' => getenv('SITE_URL'),
        'devMode' => true,
    ],

    'test' => [
        'siteUrl' => getenv('SITE_URL'),
        'devMode' => true,
    ],
];
