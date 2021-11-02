public with sharing class AccountController {

    // AuraEnabled to make it accessible to LWC and Aura components
    // When we use cacheable, Data Manipulation Language (DML) operations are not allowed
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts() {

        /*
        // returning the Name Title Email and Phone for the accountId we feed the method
        return [
            SELECT Name, AnnualRevenue, Industry
            FROM Account
            WITH SECURITY_ENFORCED
            ORDER BY Name
        ];
        */
        throw new AuraHandledException('Forced error');
    }
}