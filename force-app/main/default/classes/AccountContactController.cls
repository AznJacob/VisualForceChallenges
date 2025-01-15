public with sharing class AccountContactController {

    public String filterValue {get; set;}
    public List<AccountWrapper> accountWrappers { get; private set; }

    public AccountContactController() {
        filterValue = ApexPages.currentPage().getParameters().get('filterValue');
        fetchAccountData();
    }


    private void fetchAccountData() {
        accountWrappers = new List<AccountWrapper>();

   
        List<Account> accounts = [
            SELECT Id, Name, (SELECT Name FROM Contacts)
            FROM Account
            WHERE Name LIKE :('%' + filterValue + '%')
        ];

        for (Account acc : accounts) {
            String contactNames = '';
            if (acc.Contacts != null && !acc.Contacts.isEmpty()) {
                List<String> contactNameList = new List<String>();
                for (Contact c : acc.Contacts) {
                    contactNameList.add(c.Name);
                }
                contactNames = String.join(contactNameList, ', ');
            }
            accountWrappers.add(new AccountWrapper(acc.Name, contactNames));
        }
    }

    public class AccountWrapper {
        public String accName { get; set; }
        public String conNames { get; set; }

        public AccountWrapper( String accountName, String contactNames) {
            this.accName = accountName;
            this.conNames = contactNames;
        }
    }
}