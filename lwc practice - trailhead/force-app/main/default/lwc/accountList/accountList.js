// Importing wire which is used to where we call our apex method
import { LightningElement, wire } from 'lwc';

// Importing the fields from our Account object
import NAME_FIELD from '@salesforce/schema/Account.Name';
import REVENUE_FIELD from '@salesforce/schema/Account.AnnualRevenue';
import INDUSTRY_FIELD from '@salesforce/schema/Account.Industry';

// Where we import Apex method
import getAccounts from '@salesforce/apex/AccountController.getAccounts';

// We import reduceErrors function from the ldsUtils.js from the LWC recipes GitHub
import { reduceErrors } from 'c/ldsUtils';

// We create our columns using a list of maps
const COLUMNS = [
    { label: 'Account Name', fieldName: NAME_FIELD.fieldApiName, type: 'text' },
    { label: 'Annual Revenue', fieldName: REVENUE_FIELD.fieldApiName, type: 'currency' },
    { label: 'Industry', fieldName: INDUSTRY_FIELD.fieldApiName, type: 'text' }
];

// in our class we reassign the columns we defined, wire in our getAccounts method 
export default class AccountList extends LightningElement {
    columns = COLUMNS;
    // We wire our getAccounts method which returns
    // the Name Title Email and Phone for the accountId we feed the method
    @wire(getAccounts)
    accounts;

    // Using reduceErrors here
    get errors() {
        return (this.accounts.error) ?
            reduceErrors(this.accounts.error) : [];
    }
}