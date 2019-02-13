<?php 

use Codeception\Util\Locator;

class CpCest
{
    private static $adminUsername = 'supersecret';
    private static $adminPassword = 'supersecret';

    public function _before(AcceptanceTester $I)
    {
    }

    /**
     * Craft admin login page is working, which would appear differently
     * for different reasons including application errors, config errors, pending migrations, etc.
     *
     * @param AcceptanceTester $I
     * @return void
     */
    public function craftLoginWorks(AcceptanceTester $I)
    {
        $I->amOnPage('/admin/login');
        $I->see('Keep me logged in');
        
    }

    // TODO: log in and make sure control panel views work

}
