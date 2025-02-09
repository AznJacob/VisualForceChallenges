public with sharing class AccountController {

    public transient String accountId;
    public Account acc {get;set;}
    public transient Boolean isRendered {get; set;}

    public AccountController() {
        this.accountId = ApexPages.currentPage().getParameters().get('id');
        this.acc = [SELECT Name FROM Account WHERE Id = :accountId LIMIT 1];
        this.isRendered = false;
    }

    public Account getAcc(){
        return this.acc;
    }

    public void displayGreeting(){
        isRendered = true;
    }
}