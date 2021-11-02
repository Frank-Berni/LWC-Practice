public class AccountTriggerHandler {
    
    public static void beforeInsertMethod(List<Account> newList){
        
    }

    public static void afterInsertMethod(List<Account> newList){
        mergeCaptureForm(newList);
    }

    public static void beforeUpdateMethod(List<Account> newList, Map<Id, Account> oldMap){
        
    }

    public static void afterUpdateMethod(List<Account> newList, Map<Id, Account> oldMap){
        
    }

    // Helper Methods

    // This method takes new records created from the Client Capture Form, compares the emails for a matching existing Account 
    // and updates that Account while deleting the new record 
    private static void mergeCaptureForm (List<Account> newList) {
        
        // New list to store the Account records we receive from the client capture form
        List<Account> accsToUpdate = new List<Account>();
        
        // Pulling all Account records
        List<Account> allAccounts = [
            SELECT Id, Name, Client_1_Email__c
            FROM Account
        ];

        // Double loop through the newlist and account records
        for (Account formAcc : newList) {
            for (Account acc : allAccounts ) {

                // Making sure that we have a match between Emails and no match between Account Ids
                if (formAcc.Client_1_Email__c == acc.Client_1_Email__c && formAcc.Id != acc.Id) {

                    // New Account that we assign Id and Name of the existing Account and every other field from the Form Account
                    Account newAcc = new Account();
                    newAcc.Id = acc.Id;
                    newAcc.Name = acc.Name;
                    newAcc.Client_1_Cell_Phone__c = formAcc.Client_1_Cell_Phone__c; 
                    newAcc.Client_1_Company_Name__c = formAcc.Client_1_Company_Name__c;
                    newAcc.Client_1_DOB__c = formAcc.Client_1_DOB__c; 
                    newAcc.Client_1_Email__c = formAcc.Client_1_Email__c; 
                    newAcc.Client_1_Employment_Status__c = formAcc.Client_1_Employment_Status__c;
                    newAcc.Client_1_First_Name__c = formAcc.Client_1_First_Name__c; 
                    newAcc.Client_1_Home_Phone__c = formAcc.Client_1_Home_Phone__c; 
                    newAcc.Client_1_Last_Name__c = formAcc.Client_1_Last_Name__c;
                    newAcc.Client_1_Location__c = formAcc.Client_1_Location__c; 
                    newAcc.Client_1_SSN__c = formAcc.Client_1_SSN__c; 
                    newAcc.Client_2_Cell_Phone__c = formAcc.Client_2_Cell_Phone__c;
                    newAcc.Client_2_Company_Name__c = formAcc.Client_2_Company_Name__c; 
                    newAcc.Client_2_DOB__c = formAcc.Client_2_DOB__c; 
                    newAcc.Client_2_Email__c = formAcc.Client_2_Email__c;
                    newAcc.Client_2_Employment_Status__c = formAcc.Client_2_Employment_Status__c; 
                    newAcc.Client_2_First_Name__c = formAcc.Client_2_First_Name__c; 
                    newAcc.Client_2_Home_Phone__c = formAcc.Client_2_Home_Phone__c;
                    newAcc.Client_2_Last_Name__c = formAcc.Client_2_Last_Name__c; 
                    newAcc.Client_2_Location__c = formAcc.Client_2_Location__c; 
                    newAcc.Client_2_SSN__c = formAcc.Client_2_SSN__c; 
                    newAcc.Other_City__c = formAcc.Other_City__c;
                    newAcc.Other_Country__c = formAcc.Other_Country__c; 
                    newAcc.Other_Country__c = formAcc.Other_Country__c; 
                    newAcc.Other_Street__c = formAcc.Other_Street__c; 
                    newAcc.Other_Zip__c = formAcc.Other_Zip__c;
                    newAcc.Primary_City__c = formAcc.Primary_City__c; 
                    newAcc.Primary_Country__c = formAcc.Primary_Country__c; 
                    newAcc.Primary_State__c = formAcc.Primary_State__c; 
                    newAcc.Primary_Street__c = formAcc.Primary_Street__c;
                    newAcc.Primary_Zip__c = formAcc.Primary_Zip__c; 
                    accsToUpdate.add(newAcc);
                }
            }
        }
        
        // Updating the existing Account with matching Email and Deleting the Record created from Client Capture Form
        if (!accsToUpdate.isEmpty()) {
            update accsToUpdate;
            delete [SELECT Id FROM Account WHERE Id IN :Trigger.new];
        }
    }
}
