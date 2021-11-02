public class clientCaptureController {

    // the search text
	public String email {get; set;}

    // the matching accounts
	public List<Account> accounts {get; set;}

    // indicator that a search has taken place
	public Boolean searched {get; set;}
    public Boolean noMatch {get; set;}
    
    public clientCaptureController() {

        searched = false;
	
		// extract the email parameter from the URL
		String emailStr = ApexPages.currentPage().getParameters().get('email');
		
		// if it is present, execute the search
		if (null != emailStr)
		{
			email = emailStr;
			executeSearch();
		}

    }

    // action method to search for accounts whose name contains the entered
	// text
	public PageReference executeSearch() {
		
        searched = true;
        noMatch = false;
		String searchStr = email;

        // Pulling necessary fields for capture form
		accounts = [
            SELECT Id, Name, Parent.Name, Client_1_Cell_Phone__c, Client_1_Company_Name__c,
            Client_1_DOB__c, Client_1_Email__c, Client_1_Employment_Status__c,
            Client_1_First_Name__c, Client_1_Home_Phone__c, Client_1_Last_Name__c,
            Client_1_Location__c, Client_1_SSN__c, Client_2_Cell_Phone__c,
            Client_2_Company_Name__c, Client_2_DOB__c, Client_2_Email__c,
            Client_2_Employment_Status__c, Client_2_First_Name__c, Client_2_Home_Phone__c,
            Client_2_Last_Name__c, Client_2_Location__c, Client_2_SSN__c, Other_City__c,
            Other_Country__c, Other_State__c, Other_Street__c, Other_Zip__c,
            Primary_City__c, Primary_Country__c, Primary_State__c, Primary_Street__c,
            Primary_Zip__c 
            FROM Account 
            WHERE Client_1_Email__c = :searchStr
            LIMIT 1
        ];

        // In case the user enters an email that doesn't match our records
        if (accounts.isEmpty()) {
            searched = false;
            noMatch = true;
        }
		
		return null;
	}

    // action method to allow editing of the matching accounts - redirects the user to the
	// clientCapture page and passes the account ids as parameters on the URL
	public PageReference edit()
	{
        
		PageReference pr = Page.clientCapture;
		
		// iterate the accounts and add a parameter containing the ID to the target URL
		Integer idx=1;
		for (Account acc : accounts)
		{
			pr.getParameters().put('account' + idx, acc.id);
			idx++;
		}
		
		return pr;
        
	}
}
