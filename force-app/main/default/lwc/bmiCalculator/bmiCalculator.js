import { LightningElement } from 'lwc';

export default class BmiCalculator extends LightningElement {
    // Private property non-reactive.
    cardTitle = 'BMI Calculator';

    changePrivatePropertyHandler(){

        this.cardTitle='Changed Value';
        console.log('Value:',this.cardTitle);


    }

}