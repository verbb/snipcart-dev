<?php

namespace craft\contentmigrations;

use Craft;
use craft\db\Migration;
use craft\elements\Entry;
use craft\models\FieldLayout;
use craft\models\Section;
use craft\models\Section_SiteSettings;
use craft\fields\Number;
use craft\fields\PlainText;
use craft\fields\Lightswitch;
use craft\fields\Dropdown;
use craft\models\FieldGroup;
use craft\models\EntryType;
use craft\models\FieldLayoutTab;
use workingconcept\snipcart\fields\ProductDetails;
use workingconcept\snipcart\models\ProductDetails as ProductDetailsModel;

/**
 * m190212_225156_test_products migration.
 */
class m190212_225156_test_products extends Migration
{
    /**
     * @inheritdoc
     */
    public function safeUp()
    {
        $this->_createSchema();
        $this->_seedProducts();

        // TODO: add Books Entry Type that uses Product Details field
        // TODO: add Songs Entry Type that uses product fields
        // TODO: populate demo Books
        // TODO: populate demo Songs
    }

    /**
     * @inheritdoc
     */
    public function safeDown()
    {
        echo "m190212_225156_test_products cannot be reverted.\n";
        return false;
    }

    private function _createSchema()
    {
        /**
         * Add new field group
         */
        $productFieldGroup = new FieldGroup();
        $productFieldGroup->name = 'Product Fields';

        if (! Craft::$app->getFields()->saveGroup($productFieldGroup, false))
        {
            Craft::dd($productFieldGroup->getErrors());
        }

        /**
         * Product Details
         */
        $productDetailsField = new ProductDetails();
        $productDetailsField->groupId = $productFieldGroup->id;
        $productDetailsField->name = 'Product Details';
        $productDetailsField->handle = 'productDetails';
        $productDetailsField->required = true;
        $productDetailsField->defaultWeightUnit = ProductDetailsModel::WEIGHT_UNIT_POUNDS;
        $productDetailsField->defaultDimensionsUnit = ProductDetailsModel::DIMENSIONS_UNIT_INCHES;
        $productDetailsField->defaultTaxable = false;
        $productDetailsField->defaultShippable = true;

        Craft::$app->getFields()->saveField($productDetailsField);

        /**
         * Products Channel
         */
        $products = new Section();

        $products->name = 'Products';
        $products->handle = 'products';
        $products->type = Section::TYPE_CHANNEL;
        $products->enableVersioning = true;
        $products->propagateEntries = true;

        $products->setSiteSettings([
            1 => new Section_SiteSettings([
                'siteId'           => 1,
                'hasUrls'          => true,
                'enabledByDefault' => true,
                'uriFormat'        => 'products/{slug}',
                'template'         => 'products/_entry',
            ])
        ]);

        if ( ! Craft::$app->getSections()->saveSection($products))
        {
            Craft::dd($products->getErrors());
        }

        /**
         * Default Entry Type with Product Details Field
         */
        $productEntryTypes  = $products->getEntryTypes();
        $defaultEntryType   = $productEntryTypes[0];
        $defaultFieldLayout = $defaultEntryType->getFieldLayout();

        $defaultFieldLayout->setTabs([
            new FieldLayoutTab([
                'name' => 'Content',
                'sortOrder' => 1,
                'fields' => [
                    $productDetailsField,
                ]
            ]),
        ]);

        $defaultEntryType->setFieldLayout($defaultFieldLayout);

        if (! Craft::$app->getSections()->saveEntryType($defaultEntryType))
        {
            Craft::dd($defaultEntryType->getErrors());
        }


        $products->setEntryTypes([ $defaultEntryType ]);

        if ( ! Craft::$app->getSections()->saveSection($products))
        {
            Craft::dd($products->getErrors());
        }
    }

    private function _seedProducts()
    {
        $productSection = Craft::$app->getSections()->getSectionByHandle('products');
        $entryTypes = $productSection->getEntryTypes();
        $entryType = $entryTypes[0];

        $testBook = new Entry();
        $testBook->sectionId = $productSection->id;
        $testBook->typeId = $entryType->id;
        $testBook->title = 'To Slay a Mockingbird';
        $testBook->slug = 'to-slay-mockingbird';
        $testBook->setFieldValues([
            'productDetails' => [
                'sku' => 'to-slay-a-mockingbird',
                'price' => 12.99,
                'taxable' => true,
                'shippable' => true,
                'weight' => 3,
                'weightUnit' => ProductDetailsModel::WEIGHT_UNIT_POUNDS,
                'length' => 8,
                'width' => 5,
                'height' => 1,
                'dimensionsUnit' => ProductDetailsModel::DIMENSIONS_UNIT_INCHES
            ]
        ]);


        if (! Craft::$app->getElements()->saveElement($testBook))
        {
            Craft::dd($testBook->getErrors());
        }

        $testBookTwo = new Entry();
        $testBookTwo->sectionId = $productSection->id;
        $testBookTwo->typeId = $entryType->id;
        $testBookTwo->title = 'How To Win Fries and Influence Purple';
        $testBookTwo->slug = 'win-fries-influence-purple';
        $testBookTwo->setFieldValues([
            'productDetails' => [
                'sku' => 'win-fries-influence-purple',
                'price' => 8.99,
                'taxable' => true,
                'shippable' => true,
                'weight' => 454,
                'weightUnit' => ProductDetailsModel::WEIGHT_UNIT_GRAMS,
                'length' => 7,
                'width' => 5,
                'height' => 1,
                'dimensionsUnit' => ProductDetailsModel::DIMENSIONS_UNIT_CENTIMETERS
            ]
        ]);


        if (! Craft::$app->getElements()->saveElement($testBookTwo))
        {
            Craft::dd($testBookTwo->getErrors());
        }

        $testSong = new Entry();
        $testSong->sectionId = $productSection->id;
        $testSong->typeId = $entryType->id;
        $testSong->title = 'My Hearth Will Go On (Download)';
        $testSong->slug = 'hearth-will-go-on-download';
        $testSong->setFieldValues([
            'productDetails' => [
                'sku' => 'hearth-will-go-on-download',
                'price' => 1.99,
                'taxable' => false,
                'shippable' => false,
            ]
        ]);

        if (! Craft::$app->getElements()->saveElement($testSong))
        {
            Craft::dd($testSong->getErrors());
        }

        $testSongTwo = new Entry();
        $testSongTwo->sectionId = $productSection->id;
        $testSongTwo->typeId = $entryType->id;
        $testSongTwo->title = 'My Hearth Will Go On (Single)';
        $testSongTwo->slug = 'hearth-will-go-on-single';
        $testSongTwo->setFieldValues([
            'productDetails' => [
                'sku' => 'hearth-will-go-on-single',
                'price' => 6.99,
                'taxable' => true,
                'shippable' => true,
                'weight' => 16,
                'weightUnit' => ProductDetailsModel::WEIGHT_UNIT_GRAMS,
                'length' => 6,
                'width' => 5,
                'height' => 1,
                'dimensionsUnit' => ProductDetailsModel::DIMENSIONS_UNIT_INCHES
            ]
        ]);

        if (! Craft::$app->getElements()->saveElement($testSongTwo))
        {
            Craft::dd($testSongTwo->getErrors());
        }
    }
}
