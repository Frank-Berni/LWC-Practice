public with sharing class AccountControllerLwc {

    // receives accountId as an argument, this method is stateless due to AuraEnabled(cacheable=true)
    @AuraEnabled(cacheable=true)
    public static List<Contact> queryRelatedContacts(Id accountId) {
        return [
            SELECT Name, Title, Email, Phone
            FROM Contact
            WHERE AccountId = :accountId
        ];
    }
}