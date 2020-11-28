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

        // no ID after saving, so we need to re-fetch on UID for some reason
        $schema = $graphQlService->getSchemaByUid('29c10875-8ed7-44a4-a35b-08bf257ec5a5');

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
}
