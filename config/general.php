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
        'devMode'           => true,
        'allowAdminChanges' => true,
    ],

    'test' => [
        'devMode' => true,
    ],
];
