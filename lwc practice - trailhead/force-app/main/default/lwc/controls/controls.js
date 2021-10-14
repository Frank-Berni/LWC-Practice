import { LightningElement } from 'lwc';

export default class Controls extends LightningElement {
   
    // These factors are the amount of values we want to create buttons for 
    factors = [0,2,3,4,5,6];
    
    // For the add button
    handleAdd() {
        this.dispatchEvent(new CustomEvent('add'));
    }

    // For the subtract button
    handleSubtract() {
        this.dispatchEvent(new CustomEvent('subtract'));
    }

    // When a multiply button gets clicked
    handleMultiply(event) {
        const factor = event.target.dataset.factor;
        this.dispatchEvent(new CustomEvent('multiply', {
            detail: factor
        }));
    }  
}