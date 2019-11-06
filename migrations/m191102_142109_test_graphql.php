<?php

namespace craft\contentmigrations;

use Craft;
use craft\db\Migration;
use craft\models\GqlSchema;

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
        $testSchema = new GqlSchema();

        $testSchema->name = 'Test Schema';
        $testSchema->enabled = true;
        $testSchema->expiryDate = null;
        $testSchema->accessToken = 'SUPERSECRETTESTTOKEN';
        $testSchema->scope = $this->_getSchemaScope();

        Craft::$app->getGql()->saveSchema($testSchema);

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
