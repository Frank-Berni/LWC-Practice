// This is used when in the JS of our LWC 
// import queryAccounts from '@salesforce/apex/AccountListControllerLwc.queryAccounts;
public with sharing class AccountListControllerLwc {
    
    // Takes in number of employees typed in and returns a list of Accounts with greater than or equal
    // number of employees
    @AuraEnabled(cacheable=true)
    public static List<Account> queryAccountsByEmployeeNumber(Integer numberOfEmployees) {
        return [ // Return whatever the component needs
            SELECT Name
            FROM Account
            WHERE NumberOfEmployees >= :numberOfEmployees
        ];
    }

    // Takes in annualRevenue typed in and returns a list of Accounts with greater than or equal
    // AnnualRevenue
    @AuraEnabled(cacheable=true)
    public static List<Account> queryAccountsByRevenue(Decimal annualRevenue) {
        return [ // Return whatever the component needs
            SELECT Name
            FROM Account
            WHERE AnnualRevenue >= :annualRevenue
        ];
    }
}