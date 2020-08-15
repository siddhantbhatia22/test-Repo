import { LightningElement, track } from 'lwc';

export default class SimpleCalculator extends LightningElement {
    // to store the current result
    @track currentResult;
    // created to show all the previous results.
    @track previousResults = [];
    // created variables to store the values.
    @track showPreviousResults;

    firstNumber;
    SecondNumber;
 
    numberChangeHandler(event){
    // To get the inputBoxName  
    const inputBoxName = event.target.name;
    if (inputBoxName === 'firstNumber') {
    this.firstNumber=event.target.value;
    }else if (inputBoxName === 'secondNumber') {
        this.secondNumber=event.target.value;
      }
    }
    // push method used to add item in an array.
    addHandler(){
        // parsInt used to convert string to Integer.
        const firstN =  parseInt(this.firstNumber);
        const secondN = parseInt(this.secondNumber);
        // used to add the string
        this.currentResult = `Result of ${firstN}+${secondN} is ${firstN+secondN}`;
        this.previousResults.push(this.currentResult);
    }
    subHandler(){
        const firstN = parseInt(this.firstNumber);
        const secondN = parseInt(this.secondNumber);

        this.currentResult = `Result of ${firstN}-${secondN} is ${firstN-secondN}`;
        this.previousResults.push(this.currentResult);

    }
    multiplyHandler(){
        const firstN = parseInt(this.firstNumber);
        const secondN = parseInt(this.secondNumber);

        this.currentResult = `Result of ${firstN}x${secondN} is ${firstN*secondN}`;
        this.previousResults.push(this.currentResult);

    }
    divisionHandler(){
        const firstN = parseInt(this.firstNumber);
        const secondN = parseInt(this.secondNumber);

        this.currentResult = `Result of ${firstN}/${secondN} is ${firstN/secondN}`;
        this.previousResults.push(this.currentResult);

    }

    showPreviousResultToggle(event){

        this.showPreviousResults=event.target.checked
    }
}