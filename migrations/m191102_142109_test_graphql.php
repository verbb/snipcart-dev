<?php

namespace craft\contentmigrations;

use Craft;
use craft\db\Migration;
use craft\models\GqlSchema;
use craft\models\GqlToken;

/**
 * m191102_142109_test_graphql migration.
 */
class m191102_142109_test_graphql extends Migration
{
    /**
     * @inheritdoc
     */
    public function safeUp()
    {
        $graphQlService = Craft::$app->getGql();

        // create schema + scope
        $schema = new GqlSchema();

        $schema->name = 'Test Schema';
        $schema->scope = $this->_getSchemaScope();

        $graphQlService->saveSchema($schema);

        // create token
        $token = new GqlToken();

        $token->name = 'Test Token';
        $token->accessToken = 'SUPERSECRETTESTTOKEN';
        $token->enabled = true;
        $token->expiryDate = null;
        $token->schemaId = $schema->id;

        $graphQlService->saveToken($token);

        // for GraphQL feature
        Craft::$app->setEdition(Craft::Pro);
    }

    /**
     * @inheritdoc
     */
    public function safeDown()
    {
        echo "m191102_142109_test_graphql cannot be reverted.\n";
        return false;
    }

    private function _getSchemaScope(): array
    {
        $allPermissions = Craft::$app->getGql()->getAllPermissions();
        $scope = [];

        foreach ($allPermissions as $category => $permission)
        {
            foreach ($permission as $key => $details)
            {
                $scope[] = $key;

                if (isset($details['nested']))
                {
                    foreach ($details['nested'] as $nestedKey => $nestedDetails)
                    {
                        $scope[] = $nestedKey;
                    }
                }
            }
        }

        return $scope;
    }

}
