import { LightningElement, api } from 'lwc';

export default class Numerator extends LightningElement {
    
    // @api counter = 0;
    
    // Variables for the current count and prior count
    _currentCount = 0;
    priorCount = 0;
    
    // Using a getter to return the current Count
    @api
    get counter() {
      return this._currentCount;
    }

    // Uses a setter to update the current count
    set counter(value) {
      this.priorCount = this._currentCount;
      this._currentCount = value;
    }
    
    // Button function to add 1 to count
    handleIncrement() {
        this.counter++;
    }
    
    // Button function to subtract 1 to count
    handleDecrement() {
        this.counter--;
    }

    // Button function to multiply by list of numbers
    handleMultiply(event) {
        const factor = event.detail;
        this.counter *= factor;
    }

    // Setting the maximum counter to public for the parent to use
    @api
    maximizeCounter() {
      this.counter += 1000000;
    }
    
}