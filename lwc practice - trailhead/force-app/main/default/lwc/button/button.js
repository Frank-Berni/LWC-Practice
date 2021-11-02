import { LightningElement, api } from 'lwc';

export default class Button extends LightningElement {
  
  // label is made public so the parent can access it and change its value
  @api label;
  @api icon;

    // Event gets dispatched to the parent with bubbles set to true
    handleButton(event) {
      this.dispatchEvent(new CustomEvent('buttonclick',{
        bubbles: true
      }));
    }
}