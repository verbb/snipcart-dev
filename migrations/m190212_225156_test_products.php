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
         * Product SKU
         */
        $skuField = new PlainText();
        $skuField->groupId = $productFieldGroup->id;
        $skuField->name = 'SKU';
        $skuField->handle = 'productSku';
        $skuField->required = true;
        $skuField->multiline = false;

        Craft::$app->getFields()->saveField($skuField);

        /**
         * Product Price
         */
        $priceField = new Number();
        $priceField->groupId = $productFieldGroup->id;
        $priceField->name = 'Price';
        $priceField->handle = 'productPrice';
        $priceField->required = true;
        $priceField->decimals = 2;
        $priceField->min = 0;

        Craft::$app->getFields()->saveField($priceField);

        /**
         * Product Weight
         */
        $weightField = new Number();
        $weightField->groupId = $productFieldGroup->id;
        $weightField->name = 'Weight';
        $weightField->handle = 'productWeight';
        $weightField->decimals = 0;
        $weightField->min = 0;

        Craft::$app->getFields()->saveField($weightField);

        /**
         * Product Weight Unit
         */
        $weightUnitField = new Dropdown();
        $weightUnitField->groupId = $productFieldGroup->id;
        $weightUnitField->name = 'Weight Unit';
        $weightUnitField->handle = 'productWeightUnit';
        $weightUnitField->options = [
            'grams'  => 'Grams',
            'ounces' => 'Ounces',
            'pounds' => 'Pounds',
        ];

        Craft::$app->getFields()->saveField($weightUnitField);

        /**
         * Product Length
         */
        $lengthField = new Number();
        $lengthField->groupId = $productFieldGroup->id;
        $lengthField->name = 'Length';
        $lengthField->handle = 'productLength';
        $lengthField->decimals = 0;
        $lengthField->min = 0;
        $lengthField->size = 4;

        Craft::$app->getFields()->saveField($lengthField);

        /**
         * Product Width
         */
        $widthField = new Number();
        $widthField->groupId = $productFieldGroup->id;
        $widthField->name = 'Width';
        $widthField->handle = 'productWidth';
        $widthField->decimals = 0;
        $widthField->min = 0;
        $widthField->size = 4;

        Craft::$app->getFields()->saveField($widthField);

        /**
         * Product Height
         */
        $heightField = new Number();
        $heightField->groupId = $productFieldGroup->id;
        $heightField->name = 'Height';
        $heightField->handle = 'productHeight';
        $heightField->decimals = 0;
        $heightField->min = 0;
        $heightField->size = 4;

        Craft::$app->getFields()->saveField($heightField);

        /**
         * Product Dimensions Unit
         */
        $dimensionsUnitField = new Dropdown();
        $dimensionsUnitField->groupId = $productFieldGroup->id;
        $dimensionsUnitField->name = 'Dimensions Unit';
        $dimensionsUnitField->handle = 'productDimensionsUnit';
        $dimensionsUnitField->options = [
            'inches'      => 'Inches',
            'centimeters' => 'Centimeters',
        ];

        Craft::$app->getFields()->saveField($dimensionsUnitField);

        /**
         * Product Shippable
         */
        $shippableField = new Lightswitch();
        $shippableField->groupId = $productFieldGroup->id;
        $shippableField->name = 'Shippable?';
        $shippableField->handle = 'productShippable';
        $shippableField->instructions = 'Switch on if this item can be shipped.';
        $shippableField->default = false;

        Craft::$app->getFields()->saveField($shippableField);

        /**
         * Product Taxable
         */
        $taxableField = new Lightswitch();
        $taxableField->groupId = $productFieldGroup->id;
        $taxableField->name = 'Taxable?';
        $taxableField->handle = 'productTaxable';
        $taxableField->instructions = 'Switch on if this item should be taxed.';
        $taxableField->default = false;

        Craft::$app->getFields()->saveField($taxableField);

        /**
         * Product Inventory
         */
        $inventoryField = new Number();
        $inventoryField->groupId = $productFieldGroup->id;
        $inventoryField->name = 'Inventory';
        $inventoryField->handle = 'productInventory';
        $inventoryField->decimals = 0;
        $inventoryField->min = 0;
        $inventoryField->size = 6;

        Craft::$app->getFields()->saveField($inventoryField);

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

        $defaultEntryType->name = 'Book';
        $defaultEntryType->handle = 'book';
        $defaultEntryType->setFieldLayout($defaultFieldLayout);

        if (! Craft::$app->getSections()->saveEntryType($defaultEntryType))
        {
            Craft::dd($defaultEntryType->getErrors());
        }

        $alternateEntryType = new EntryType();
        $alternateEntryType->sectionId = $products->id;
        $alternateEntryType->name = 'Song';
        $alternateEntryType->handle = 'song';

        $alternateFieldLayout = new FieldLayout();

        $alternateFieldLayout->setTabs([
            new FieldLayoutTab([
                'name' => 'Content',
                'sortOrder' => 1,
                'fields' => [
                    $skuField,
                    $priceField,
                    $weightField,
                    $weightUnitField,
                    $lengthField,
                    $widthField,
                    $heightField,
                    $dimensionsUnitField,
                    $shippableField,
                    $taxableField,
                    $inventoryField,
                ]
            ]),
        ]);

        $alternateEntryType->setFieldLayout($alternateFieldLayout);

        if (! Craft::$app->getSections()->saveEntryType($alternateEntryType))
        {
            Craft::dd($alternateEntryType->getErrors());
        }

        $products->setEntryTypes([
            $defaultEntryType,
            $alternateEntryType
        ]);

        if ( ! Craft::$app->getSections()->saveSection($products))
        {
            Craft::dd($products->getErrors());
        }
    }

    private function _seedProducts()
    {
        $productSection = Craft::$app->getSections()->getSectionByHandle('products');
        $bookTypes = Craft::$app->getSections()->getEntryTypesByHandle('book');
        $bookType = $bookTypes[0];
        $songTypes = Craft::$app->getSections()->getEntryTypesByHandle('song');
        $songType = $songTypes[0];

        $testBook = new Entry();
        $testBook->sectionId = $productSection->id;
        $testBook->typeId = $bookType->id;
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
        $testBookTwo->typeId = $bookType->id;
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
        $testSong->typeId = $songType->id;
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
        $testSongTwo->typeId = $songType->id;
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
