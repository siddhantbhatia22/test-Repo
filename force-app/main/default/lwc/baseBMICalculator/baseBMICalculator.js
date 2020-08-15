import { LightningElement,track} from 'lwc';

export default class BaseBMICalculator extends LightningElement {

     
     weight;
     height;
     @track bmi;
    onWeightChange(event) {

        this.weight = parseFloat(event.target.value);
    }

    onHeightChange(event) {
        this.height = parseFloat(event.target.value);
    }

    calaculateBMI(){
        try{
        this.bmi = this.weight/(this.height*this.height);
        } catch(error){
            this.bmi=undefined;
        }
  }
}