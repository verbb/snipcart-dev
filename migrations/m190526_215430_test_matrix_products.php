<?php

namespace craft\contentmigrations;

use Craft;
use craft\db\Migration;
use craft\fields\Matrix;
use craft\models\MatrixBlockType;
use craft\helpers\StringHelper;
use craft\fields\PlainText;
use workingconcept\snipcart\fields\ProductDetails;
use workingconcept\snipcart\models\ProductDetails as ProductDetailsModel;
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
        $this->_addComplexEntryType();
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

    private function _addComplexEntryType()
    {
        $fieldGroups = Craft::$app->getFields()->getAllGroups();

        foreach ($fieldGroups as $fieldGroup)
        {
            if ($fieldGroup->name === 'Product Fields')
            {
                $productFieldGroup = $fieldGroup;
                break;
            }
        }

        /**
         * Page Blocks Matrix field
         */
        $pageBlocksField = new Matrix();
        $pageBlocksField->name = 'Page Blocks';
        $pageBlocksField->handle = 'pageBlocks';
        $pageBlocksField->groupId = $productFieldGroup->id;
        $pageBlocksField->instructions = 'Arrange these blocks to build the page.';
        $pageBlocksField->required = false;

        Craft::$app->getFields()->saveField($pageBlocksField);


        /**
         * Page Blocks → Heading block type
         */
        $headingBlock = new MatrixBlockType();
        $headingBlock->fieldId = $pageBlocksField->id;
        $headingBlock->name = 'Heading';
        $headingBlock->handle = 'heading';
        $headingBlock->uid = StringHelper::UUID();

        $heading = new PlainText();
        $heading->name = 'Heading';
        $heading->handle = 'heading';
        $heading->uid = StringHelper::UUID();
        $heading->required = true;
        $heading->multiline = false;

        $headingBlock->setFields([ $heading ]);

        if (! Craft::$app->matrix->saveBlockType($headingBlock))
        {
            Craft::dd($headingBlock->getErrors());
        }


        /**
         * Page Blocks → Product Details block type
         */
        $productDetailsBlock = new MatrixBlockType();
        $productDetailsBlock->fieldId = $pageBlocksField->id;
        $productDetailsBlock->name = 'Product';
        $productDetailsBlock->handle = 'product';
        $productDetailsBlock->uid = StringHelper::UUID();

        $productName = new PlainText();
        $productName->name = 'Product Name';
        $productName->handle = 'productName';
        $productName->uid = StringHelper::UUID();
        $productName->required = false;
        $productName->multiline = false;

        $productDetailsField = new ProductDetails();
        $productDetailsField->name = 'Product Info';
        $productDetailsField->handle = 'productInfo';
        $productDetailsField->uid = StringHelper::UUID();
        $productDetailsField->instructions = 'Add relevant details for a product.';
        $productDetailsField->required = true;
        $productDetailsField->defaultWeightUnit = ProductDetailsModel::WEIGHT_UNIT_POUNDS;
        $productDetailsField->defaultDimensionsUnit = ProductDetailsModel::DIMENSIONS_UNIT_INCHES;
        $productDetailsField->defaultTaxable = true;
        $productDetailsField->defaultShippable = false;
        $productDetailsField->displayInventory = true;
        $productDetailsField->displayTaxableSwitch = true;
        $productDetailsField->displayShippableSwitch = false;

        $productDetailsBlock->setFields([ $productName, $productDetailsField ]);

        if (! Craft::$app->matrix->saveBlockType($productDetailsBlock))
        {
            Craft::dd($productDetailsBlock->getErrors());
        }


        /**
         * Complex Products Entry Type with Page Blocks field
         */
        $products = Craft::$app->getSections()->getSectionByHandle('products');

        $complexEntryType = new EntryType();
        $complexEntryType->name = 'Complex Products';
        $complexEntryType->handle = 'complexProducts';
        $complexEntryType->sectionId = $products->id;
        $complexEntryType->hasTitleField = true;
        $complexEntryType->titleLabel = 'Title';

        $complexEntryFieldLayout = new FieldLayout();
        $complexEntryFieldLayout->type = Entry::class;
        $complexEntryFieldLayout->setTabs([
            new FieldLayoutTab([
                'name' => 'Content',
                'sortOrder' => 1,
                'fields' => [
                    $pageBlocksField,
                ]
            ]),
        ]);

        $complexEntryType->setFieldLayout($complexEntryFieldLayout);

        if (! Craft::$app->getSections()->saveEntryType($complexEntryType))
        {
            Craft::dd($complexEntryType->getErrors());
        }

        // again, for some reason
        Craft::$app->getSections()->saveEntryType($complexEntryType);

        if ( ! Craft::$app->getSections()->saveSection($products))
        {
            Craft::dd($products->getErrors());
        }
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
                            'price' => 129.99,
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
