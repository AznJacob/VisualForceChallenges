public with sharing class AccountController {

    private Account acc;

    public AccountController() {
        this.acc = (Account)[SELECT Name FROM Account WHERE Name = 'TEST'];
    }

    public Account getAcc(){
        return acc;
    }
}