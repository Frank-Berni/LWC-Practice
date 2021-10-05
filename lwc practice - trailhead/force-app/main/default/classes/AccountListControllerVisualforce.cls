public with sharing class AccountListControllerVisualforce {
    public List<Contact> contacts { get; private set; }
    private ApexPages.StandardController standardController;
    
    // we have this method receive the standardController since the page uses Account Standard controller
    public AccountListControllerVisualforce(ApexPages.StandardController standardController) {
        this.standardController = standardController;
        this.contacts = new List<Contact>();
    }
    public void queryRelatedContacts() {
        // .getId method from the standardController to get the ID of the Account record
        this.contacts = [
            SELECT Name, Title, Email, Phone
            FROM Contact
            WHERE AccountId = :standardController.getId() // (2)
        ];
   }
}