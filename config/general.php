<?php

return [
    '*' => [
        'useEmailAsUsername'   => true,
        'defaultWeekStartDay'  => 0,
        'enableCsrfProtection' => true,
        'omitScriptNameInUrls' => true,
        'cpTrigger'            => 'admin',
        'securityKey'          => getenv('SECURITY_KEY'),
        'allowAdminChanges'    => false,
    ],

    'dev' => [
        'siteUrl'           => getenv('PRIMARY_SITE_URL'),
        'devMode'           => true,
        'allowAdminChanges' => true,
    ],

    'test' => [
        'siteUrl' => getenv('PRIMARY_SITE_URL'),
        'devMode' => true,
    ],
];
