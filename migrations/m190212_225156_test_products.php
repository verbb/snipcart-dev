<?php

namespace craft\contentmigrations;

use Craft;
use craft\db\Migration;
use craft\elements\Entry;
use craft\models\Section;
use craft\models\Section_SiteSettings;
use craft\fields\PlainText;
use craft\fields\Table;
use craft\models\FieldGroup;
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
        $productDetailsField->instructions = "Add critical store details here.";
        $productDetailsField->required = true;
        $productDetailsField->defaultWeightUnit = ProductDetailsModel::WEIGHT_UNIT_POUNDS;
        $productDetailsField->defaultDimensionsUnit = ProductDetailsModel::DIMENSIONS_UNIT_INCHES;
        $productDetailsField->defaultTaxable = false;
        $productDetailsField->defaultShippable = true;

        Craft::$app->getFields()->saveField($productDetailsField);

        /**
         * Product Description
         */
        $productDescriptionField = new PlainText();
        $productDescriptionField->groupId = $productFieldGroup->id;
        $productDescriptionField->name = 'Product Description';
        $productDescriptionField->handle = 'productDescription';
        $productDescriptionField->instructions = "Describe the product so customers can fully appreciate what they're not buying.";
        $productDescriptionField->required = false;
        $productDescriptionField->multiline = true;
        $productDescriptionField->initialRows = 2;

        Craft::$app->getFields()->saveField($productDescriptionField);

        /**
         * Product Options
         */
        $productOptionsField = new Table();
        $productOptionsField->groupId = $productFieldGroup->id;
        $productOptionsField->name = 'Product Options';
        $productOptionsField->handle = 'productOptions';
        $productOptionsField->instructions = "Optionally add product options and the how each should impact the base price (if at all).";
        $productOptionsField->required = false;
        $productOptionsField->columns = [
            [
                'heading' => 'Name',
                'handle' => 'name',
                'width' => '',
                'type' => 'singleline',
            ],
            [
                'heading' => 'Price +/-',
                'handle' => 'price',
                'width' => '15%',
                'type' => 'number',
            ],
        ];

        Craft::$app->getFields()->saveField($productOptionsField);

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
                    $productDescriptionField,
                    $productOptionsField,
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

    /**
     * Add some entertaining fake store products.
     * @return void
     */
    private function _seedProducts()
    {
        $productSection = Craft::$app->getSections()->getSectionByHandle('products');
        $entryTypes     = $productSection->getEntryTypes();
        $entryType      = $entryTypes[0];

        $item = new Entry();
        $item->sectionId = $productSection->id;
        $item->typeId = $entryType->id;
        $item->title = 'Infinity Gauntlet';
        $item->slug = 'infinity-gauntlet';
        $item->setFieldValues([
            'productDescription' => "**Not sold as a pair!** Get them talking and show off your gems as you embody death throughout the universe with swagger.",
            'productDetails' => [
                'sku' => 'infinity-gauntlet',
                'price' => 499.98,
                'taxable' => true,
                'shippable' => true,
                'weight' => 3,
                'weightUnit' => ProductDetailsModel::WEIGHT_UNIT_POUNDS,
                'length' => 14,
                'width' => 8,
                'height' => 8,
                'inventory' => 1,
                'dimensionsUnit' => ProductDetailsModel::DIMENSIONS_UNIT_INCHES
            ]
        ]);

        Craft::$app->getElements()->saveElement($item);

        $item = new Entry();
        $item->sectionId = $productSection->id;
        $item->typeId = $entryType->id;
        $item->title = 'Lembas Bread';
        $item->slug = 'lembas-bread';
        $item->setFieldValues([
            'productDescription' => "Very filling and packs well for a long hike.",
            'productDetails' => [
                'sku' => 'lembas-bread',
                'price' => 8.99,
                'taxable' => false,
                'shippable' => true,
                'weight' => 1,
                'weightUnit' => ProductDetailsModel::WEIGHT_UNIT_POUNDS,
                'length' => 6,
                'width' => 6,
                'height' => 2,
                'inventory' => 200,
                'dimensionsUnit' => ProductDetailsModel::DIMENSIONS_UNIT_INCHES
            ]
        ]);

        Craft::$app->getElements()->saveElement($item);

        $item = new Entry();
        $item->sectionId = $productSection->id;
        $item->typeId = $entryType->id;
        $item->title = 'Dragon Egg';
        $item->slug = 'dragon-egg';
        $item->setFieldValues([
            'productDescription' => "Makes a great wedding gift that'll definitely get you noticed. Store in fireplace or similar location for maximum fun.",
            'productDetails' => [
                'sku' => 'dragon-egg',
                'price' => 9999.99,
                'taxable' => true,
                'shippable' => true,
                'weight' => 1,
                'weightUnit' => ProductDetailsModel::WEIGHT_UNIT_POUNDS,
                'length' => 6,
                'width' => 6,
                'height' => 2,
                'inventory' => 3,
                'dimensionsUnit' => ProductDetailsModel::DIMENSIONS_UNIT_INCHES
            ]
        ]);

        Craft::$app->getElements()->saveElement($item);

        $item = new Entry();
        $item->sectionId = $productSection->id;
        $item->typeId = $entryType->id;
        $item->title = 'Dark Matter';
        $item->slug = 'dark-matter';
        $item->setFieldValues([
            'productDescription' => "Always in demand. **Customer must arrange for own shipping and storage.**",
            'productDetails' => [
                'sku' => 'dark-matter',
                'price' => 99999.98,
                'taxable' => true,
                'shippable' => false,
                'weight' => 99999999999,
                'weightUnit' => ProductDetailsModel::WEIGHT_UNIT_POUNDS,
                'length' => 1,
                'width' => 1,
                'height' => 1,
                'inventory' => 6,
                'dimensionsUnit' => ProductDetailsModel::DIMENSIONS_UNIT_INCHES
            ]
        ]);

        Craft::$app->getElements()->saveElement($item);

        $item = new Entry();
        $item->sectionId = $productSection->id;
        $item->typeId = $entryType->id;
        $item->title = 'Oathkeeper';
        $item->slug = 'oathkeeper';
        $item->setFieldValues([
            'productDescription' => "Training and well-developed core strength strongly recommended. Product is not a toy.",
            'productDetails' => [
                'sku' => 'oathkeeper',
                'price' => 2899.98,
                'taxable' => true,
                'shippable' => true,
                'weight' => 12,
                'weightUnit' => ProductDetailsModel::WEIGHT_UNIT_POUNDS,
                'length' => 1,
                'width' => 1,
                'height' => 1,
                'inventory' => 3,
                'dimensionsUnit' => ProductDetailsModel::DIMENSIONS_UNIT_INCHES
            ]
        ]);

        Craft::$app->getElements()->saveElement($item);

        $item = new Entry();
        $item->sectionId = $productSection->id;
        $item->typeId = $entryType->id;
        $item->title = 'Hand of the King Brooch';
        $item->slug = 'hand-of-king-brooch';
        $item->setFieldValues([
            'productDescription' => "Looks great and cleans easily. Great for re-gifting.",
            'productDetails' => [
                'sku' => 'hand-of-king-brooch',
                'price' => 14.99,
                'taxable' => true,
                'shippable' => true,
                'weight' => 1,
                'weightUnit' => ProductDetailsModel::WEIGHT_UNIT_POUNDS,
                'length' => 5,
                'width' => 1,
                'height' => 1,
                'inventory' => 100,
                'dimensionsUnit' => ProductDetailsModel::DIMENSIONS_UNIT_INCHES
            ]
        ]);

        Craft::$app->getElements()->saveElement($item);

        $item = new Entry();
        $item->sectionId = $productSection->id;
        $item->typeId = $entryType->id;
        $item->title = 'Laser Sword';
        $item->slug = 'laser-sword';
        $item->setFieldValues([
            'productDescription' => 'Stand out in a world of blasters with this ancient future weapon. Check back, new models added all the time!',
            'productOptions' => [
                [ 'Red', 0 ],
                [ 'Green', 0 ],
                [ 'Double Bladed', 50 ],
            ],
            'productDetails' => [
                'sku' => 'laser-sword',
                'price' => 499.99,
                'taxable' => true,
                'shippable' => true,
                'weight' => 2,
                'weightUnit' => ProductDetailsModel::WEIGHT_UNIT_POUNDS,
                'length' => 11,
                'width' => 2,
                'height' => 2,
                'inventory' => 1,
                'dimensionsUnit' => ProductDetailsModel::DIMENSIONS_UNIT_INCHES
            ]
        ]);

        Craft::$app->getElements()->saveElement($item);

        $item = new Entry();
        $item->sectionId = $productSection->id;
        $item->typeId = $entryType->id;
        $item->title = 'Elemental Stones';
        $item->slug = 'elemental-stone';
        $item->setFieldValues([
            'productDescription' => "All the fun delivered to your door; no multipass required!",
            'productOptions' => [
                [ 'Water', 0 ],
                [ 'Fire', 0 ],
                [ 'Wind', 0 ],
                [ 'Earth', 0 ],
            ],
            'productDetails' => [
                'sku' => 'elemental-stone',
                'price' => 89.99,
                'taxable' => true,
                'shippable' => true,
                'weight' => 6,
                'weightUnit' => ProductDetailsModel::WEIGHT_UNIT_POUNDS,
                'length' => 12,
                'width' => 5,
                'height' => 5,
                'inventory' => 60,
                'dimensionsUnit' => ProductDetailsModel::DIMENSIONS_UNIT_INCHES
            ]
        ]);

        Craft::$app->getElements()->saveElement($item);

        $item = new Entry();
        $item->sectionId = $productSection->id;
        $item->typeId = $entryType->id;
        $item->title = 'Glow Pole Umbrella';
        $item->slug = 'glow-pole-umbrella';
        $item->setFieldValues([
            'productDescription' => "No teardrops in the rain with this stylish umbrella! Stay dry and well-lit. Batteries not included, requires four AA or Nexus 6 Thunderbolt port.",
            'productDetails' => [
                'sku' => 'glow-pole-umbrella',
                'price' => 34.99,
                'taxable' => true,
                'shippable' => true,
                'weight' => 1,
                'weightUnit' => ProductDetailsModel::WEIGHT_UNIT_POUNDS,
                'length' => 36,
                'width' => 3,
                'height' => 3,
                'inventory' => 100,
                'dimensionsUnit' => ProductDetailsModel::DIMENSIONS_UNIT_INCHES
            ]
        ]);

        Craft::$app->getElements()->saveElement($item);
    }
}
