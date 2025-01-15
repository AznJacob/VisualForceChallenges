public with sharing class AccountFilterController {
    public String filterValue {get; set;}
    public AccountFilterController() {

    }

    public PageReference sendFilter(){
        PageReference pageRef = new PageReference('/apex/Challenge9');
        pageRef.getParameters().put('filterValue',filterValue);
        return pageRef;
    }
}