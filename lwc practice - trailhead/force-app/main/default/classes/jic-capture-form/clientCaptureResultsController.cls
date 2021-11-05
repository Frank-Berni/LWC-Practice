public class clientCaptureResultsController {

    // the Account to being created on the Capture Form
	private final Account acct;

	// holds the Account that was searched from search page
	public List<Account> accs {get; set;}

	// Public attachment file used in file upload method
	public Attachment myfile;
	// Keeps track of the files already uploaded by the user and gives feedback to the user on the page
	public Integer filesUploaded = 0; 
	public Integer getfilesUploaded() {
		return filesUploaded;
	}

	// Custom Validation rule to prevent mistyped Emails
	public String message = 'Emails do not match';
	public String getMessage() {
		return message;
	}
	public Boolean misMatchEmail {get; set;}

    // Constructor - extracts account* parameters from the URL and
	// Retrieves the associated Person Account record
    public clientCaptureResultsController(ApexPages.StandardController stdController) {

		// Setting the custom validation rule message as false initially
		misMatchEmail = false;

		// Grabs the new Account being created from the page
		this.acct = (Account)stdController.getRecord();

		// Works with transferring information from the search page
        List<Id> ids = new List<Id>();
		Integer idx = 1;
		String accStr;
		
		// Extract indexed parameters from the URL, stopping when null is retrieved
		do 
		{
			accStr = ApexPages.currentPage().getParameters().get('account' + idx);
			if (accStr != null)
			{
				ids.add(accStr);
			}
			idx++;
		}
		
        while (null != accStr);
		
		// if parameters were present, extract the associated accounts
		if (ids.size() > 0) {

			accs = [
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
                WHERE Id IN :ids
            ];
		}
    }

	// Assigns a new attachment to myfile
    Public Attachment getmyfile() {
        myfile = new Attachment();
        return myfile;
    }

	Public Pagereference Savedoc() {
        // String accid = System.currentPagereference().getParameters().get('id');

		// New attachment where it is stored on the existing Account for Search page
        Attachment a = new Attachment(parentId = accs[0].Id, name=myfile.name, body = myfile.body);
         
        // insert the attachment 
         insert a;

		//  increment the filesUploaded variable each time they click Upload
		 filesUploaded++;
        return NULL;
    }   

    // Saves the account records and redirects to the accounts tab
	// Also redirects to another page that thanks the user for submitting their information
	public PageReference insertAccounts() {

		if (acct.Client_1_Email__c == accs[0].Client_1_Email__c) {
			misMatchEmail = false;
			PageReference pr = Page.clientCaptureConfirmation;
			insert acct;
			return pr;
		} else {
			misMatchEmail = true;
			return null;
		}
		

	}
}
