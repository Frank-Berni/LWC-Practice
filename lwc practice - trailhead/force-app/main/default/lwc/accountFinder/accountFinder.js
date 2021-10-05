import { LightningElement, wire } from 'lwc';
import queryAccountsByRevenue from '@salesforce/apex/AccountListControllerLwc.queryAccountsByRevenue';


export default class AccountFinder extends LightningElement {
    
    // The default value of annualRevenue
    annualRevenue = null;

    // assigns the annualRevenue to what the user enters in
    handleChange(event) {
        this.annualRevenue = event.detail.value;
    }

    // clears the value entered
    reset() {
        this.annualRevenue = null;
    }

    // Connects to our Apex Controller method, feeds this annualRevenue into the parameter 
    // and returns a list of accounts
    @wire(queryAccountsByRevenue, { annualRevenue: '$annualRevenue' })
    accounts;
}