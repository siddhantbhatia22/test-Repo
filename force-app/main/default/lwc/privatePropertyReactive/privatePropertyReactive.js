import { LightningElement,track } from 'lwc';
import {getBMI} from 'c/bmi';
export default class PrivatePropertyReactive extends LightningElement {
    // Private Non-reactive property
    cardTitles='Bmi Calculators';
   // Private variable- 
    weight;
    height;
    // Private reactive property
    @track bmi;
   // parseFloat convert string to float. event,target.value is used to get the string value  
    onWeightChange(event){
    this.weight=parseFloat(event.target.value);

    }
    onHeightChange(event){
    this.height=parseFloat(event.target.value);
     }
    
     // Sharing Javascript code from 
        calculateBMI(){
            this.bmi = getBMI(this.weight, this.height);
        }
     
  // get property
     get bmiValue(){
         if(this.bmi === undefined){
             return "";
         }
         return `Your BMI is: ${this.bmi}`;
     }
}