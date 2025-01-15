public with sharing class AccountController {

    private Account acc {get;set;}
    public Boolean isRendered;

    public AccountController() {

    }

    public Account getAcc(){
        return this.acc;
    }

    public void displayGeeting(){
        isRendered = true;
    }
}