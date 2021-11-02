import { LightningElement } from 'lwc';

export default class Augmentor extends LightningElement {
    
    startCounter = 0;

    handleStartChange(event) {
      this.startCounter = parseInt(event.target.value);
    }
    
    // Taking the maximum value (1 million) from child component numerator
    handleMaximizeCounter() {
        this.template.querySelector('c-numerator').maximizeCounter();
      }

}