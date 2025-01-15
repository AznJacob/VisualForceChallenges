public with sharing class AccountSearchController {

    public String query {get;set;}
    public List<Account> accs {get;set;}
    public List<Contact> cons {get;set;}

    ApexPages.StandardSetController sscAcc{
        get{
            String q = String.escapeSingleQuotes(query);
            q = '%' + q + '%';
            sscAcc = new ApexPages.StandardSetController([SELECT Id, Name, AnnualRevenue, Industry FROM Account WHERE Name LIKE :q]);

            return sscAcc;
        }
        set;
    }

    ApexPages.StandardSetController sscCon{
        get{
            Set<Id> accIds = new Set<Id>();
            for(Account acc: accs){
                accIds.add(acc.Id);
            }

            sscCon = new ApexPages.StandardSetController([SELECT LastName FROM Contact WHERE AccountId IN :accIds]);

            return sscCon;
        }
        set;
    }

    public AccountSearchController() {
        
    }

    public void fetchRecords() {
        this.accs = sscAcc.getRecords();
        this.cons = sscCon.getRecords();
    }

    public void save(){
        try{
            Database.update(accs);
            Database.update(cons);
        }catch (Exception e){
            ApexPages.addMessages(e);
        }
    }
    
}
