import  { LightningElement, wire, api } from 'lwc';
// where we import our apex class
import queryRelatedContacts from '@salesforce/apex/AccountControllerLwc.queryRelatedContacts';

export default class AccountDetails extends LightningElement {
    // api decorator makes the recordId public
    @api recordId;
    // wire passes our method from apex controller
    @wire(queryRelatedContacts, { accountId: '$recordId' })
    contacts;
}