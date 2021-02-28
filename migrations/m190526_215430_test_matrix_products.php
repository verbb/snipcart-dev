<?php

namespace craft\contentmigrations;

use Craft;
use craft\db\Migration;
use craft\errors\MigrationException;
use craft\fields\Matrix;
use craft\models\MatrixBlockType;
use craft\helpers\StringHelper;
use craft\fields\PlainText;
use fostercommerce\snipcart\fields\ProductDetails;
use fostercommerce\snipcart\models\ProductDetails as ProductDetailsModel;
use craft\models\FieldLayout;
use craft\models\EntryType;
use craft\models\FieldLayoutTab;
use craft\elements\Entry;

/**
 * m190526_215430_test_matrix_products migration.
 */
class m190526_215430_test_matrix_products extends Migration
{
    /**
     * @inheritdoc
     */
    public function safeUp()
    {
        $this->_seedComplexProducts();
    }

    /**
     * @inheritdoc
     */
    public function safeDown()
    {
        echo "m190526_215430_test_matrix_products cannot be reverted.\n";
        return false;
    }

    private function _seedComplexProducts()
    {
        $products = Craft::$app->getSections()->getSectionByHandle('products');
        $entryTypes = $products->getEntryTypes();
        $complexEntryType = $entryTypes[1];

        $item = new Entry();
        $item->sectionId = $products->id;
        $item->typeId = $complexEntryType->id;
        $item->title = 'Spa Packages';
        $item->slug = 'spa-packages';

        $item->setFieldValues([
            'pageBlocks' => [
                'new0' => [
                    'type' => 'heading',
                    'fields' => [
                        'heading' => 'Spa Options'
                    ]
                ],
                'new1' => [
                    'type' => 'product',
                    'fields' => [
                        'productName' => 'Economy',
                        'productInfo' => [
                            'sku' => 'economy',
                            'price' => 100,
                            'taxable' => true,
                            'inventory' => 100,
                        ],
                    ]
                ],
                'new2' => [
                    'type' => 'product',
                    'fields' => [
                        'productName' => 'Deluxe',
                        'productInfo' => [
                            'sku' => 'deluxe',
                            'price' => 849.99,
                            'taxable' => true,
                            'inventory' => 0
                        ],
                    ]
                ],
            ]
        ]);

        Craft::$app->getElements()->saveElement($item);
    }
}
