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
		'resourceBasePath' => dirname(__DIR__) . '/web/cpresources',
		'aliases' => [
			'@webroot' => getenv('PRIMARY_SITE_URL')
		],
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
