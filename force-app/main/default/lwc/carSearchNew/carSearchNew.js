import { LightningElement,track } from 'lwc';

export default class CarSearchNew extends LightningElement {
// used to store the value from child component carSearchForm carTypeId
@track carTypeId = '';
carTypeSelectHandler(event){
    this.carTypeId = event.detail;
}
}