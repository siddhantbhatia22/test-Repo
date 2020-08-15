import { LightningElement,track } from 'lwc';
import { generateRecordInputForCreate } from 'lightning/uiRecordApi';

export default class ConditionalRenderingPractice extends LightningElement {

    @track displayInfo = false;

    @track colours = ['Yellow','Blue','Green'];
    @track newcolours = ['Red','black','grey'];
    showInfoHandler(event){
        this.displayInfo = event.target.checked;
    }



}