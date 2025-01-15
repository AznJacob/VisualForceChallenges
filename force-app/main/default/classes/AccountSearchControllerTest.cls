/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an org are executed whenever Apex code is deployed
 * to a production org to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production org. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the org size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class AccountSearchControllerTest {

    @TestSetup
    static void setupRecords() {

        Account acc1 = new Account(Name = 'AccountName1');
        Account acc2 = new Account(Name = 'AccountName2');
        List<Account> accList = new List<Account>();
        accList.add(acc1);
        accList.add(acc2);
        Database.insert(accList);

        Contact con1 = new Contact(LastName = 'ContactName1', AccountId=acc1.Id);
        Contact con2 = new Contact(LastName = 'ContactName2', AccountId=acc1.Id);
        Contact con3 = new Contact(LastName = 'ContactName3', AccountId=acc2.Id);
        List<Contact> conList = new List<Contact>();
        conList.add(con1);
        conList.add(con2);
        conList.add(con3);
        Database.insert(conList);
    }

    @isTest
    static void testFetchRecords(){
        AccountSearchController controller = new AccountSearchController();
        controller.query = 'Account';

        Test.startTest();
        controller.fetchRecords();
        Test.stopTest();

        Assert.areEqual(controller.accs[0].Name, 'AccountName1');
        Assert.areEqual(Controller.cons[0].LastName, 'ContactName1');
        Assert.areNotEqual(controller.accs[0].Name, 'NEGATIVE');
        Assert.areNotEqual(controller.cons[0].LastName, 'NEGATIVE');
    }


    @isTest
    static void testUpdateRecords(){
        AccountSearchController controller = new AccountSearchController();
        controller.query = 'Account';

        Test.startTest();
        controller.fetchRecords();
        controller.accs[0].Name = 'NewAccount';
        controller.cons[0].LastName = 'NewContact';
        controller.save();
        Test.stopTest();

        Assert.areEqual(controller.accs[0].Name, 'NewAccount');
        Assert.areEqual(Controller.cons[0].LastName, 'NewContact');
        Assert.areNotEqual(controller.accs[0].Name, 'AccountName1');
        Assert.areNotEqual(controller.cons[0].LastName, 'ContactName1');
    }

}