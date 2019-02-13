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
        $I->see('Test Site');
        $I->see('horrid little site');
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
        $I->amOnPage('/products/to-slay-mockingbird');
        $I->see('To Slay a Mockingbird');
        $I->see('$12.99');
        $I->see('Buy Now');
    }
}
