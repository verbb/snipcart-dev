<?php 

use Codeception\Util\Locator;

class CartCest
{
    public function _before(AcceptanceTester $I)
    {
    }

    /**
     * Buy Now button adds a thing directly to the cart and shows it.
     *
     * @param AcceptanceTester $I
     * @return void
     */
    public function buyNowWorks(AcceptanceTester $I)
    {
        $I->amOnPage('/products/oathkeeper');
        $I->click(['class' => 'snipcart-add-item']);

        // wait for cart modal
        $I->waitForElement('#snipcart-items', 10);
        $I->see('My cart'); // actual case in element

        $I->see('1', '.snip-quantity-trigger__text');
    }

    /**
     * Order with shippable items gets shipping rates returned.
     *
     * @param AcceptanceTester $I
     * @return void
     */
    public function shippingRatesWork(AcceptanceTester $I)
    {
        $I->amOnPage('/products/oathkeeper');
        $I->click(['class' => 'snipcart-add-item']);

        $I->waitForElement('#snipcart-items', 10);
        $I->see('My cart'); // actual case in element

        $I->click('Next step'); // actual case in element

        // check out as a guest
        $I->waitForElement('#snipcart-guest-checkout', 10);
        $I->click('#snipcart-guest-checkout');

        // $I->fillField('#snipcart_custom_Order-Comments', 'Very excited about this order.');
        // $I->click('Next step');

        $I->waitForElement('#snip-name', 10);

        // billing address
        $I->fillField('#snip-name', 'Tobias Fünke');
        $I->fillField('#snip-address1', '1234 Balboa Towers Circle');
        $I->fillField('#snip-address2', 'Apt 1234');
        $I->fillField('#snip-city', 'Los Angeles');
        $I->selectOption('#snipprovince', 'California');
        $I->fillField('#snip-postalCode', '92706');
        $I->fillField('#snip-phone', '(555) 555-5555');
        $I->fillField('#snip-email', 'tobias@actorpull.biz');

        $I->click('Next step');

        $I->waitForElement('#snipcart-shippings-list', 5);

        // wait for ShipStation to provide responses
        $I->waitForElement('.snip-product--selectable-item', 15);

        $I->see('USPS', '.snip-product--selectable');
        $I->seeElement('.js-selected');
    }
}
