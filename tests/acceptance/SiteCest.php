<?php 

use Codeception\Util\Locator;

class SiteCest
{
    public function _before(AcceptanceTester $I)
    {
    }

    /**
     * Homepage is responding like we'd expect.
     *
     * @param AcceptanceTester $I
     * @return void
     */
    public function homepageWorks(AcceptanceTester $I)
    {
        $I->amOnPage('/');
        $I->see('Interweb Shoppe');
        $I->see('Welcome to our store!');
        $I->see('Shopping Cart');
    }

    /**
     * Product detail page exists and has a buy button and price.
     * 
     * @param AcceptanceTester $I
     * @return void
     */
    public function productDetailWorks(AcceptanceTester $I)
    {
        $I->amOnPage('/products/oathkeeper');
        $I->see('Oathkeeper');
        $I->see('Product is not a toy.');
        $I->see('Low stock, order now!');
        $I->see('$2,899.98');
        $I->see('Buy Now');
    }
}
