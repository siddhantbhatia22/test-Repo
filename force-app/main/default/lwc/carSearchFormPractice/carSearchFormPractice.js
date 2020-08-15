import { LightningElement,track,wire } from 'lwc';
import getCarTypes from '@salesforce/apex/CarSearchFormController.getCarTypes';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';

export default class CarSearchFormPractice extends NavigationMixin (LightningElement) {
    // Array of an object with label and value as ligntning combobox only accepts label and value.
    @track carTypes;

    @wire(getCarTypes)

    wiredCarType({data,error}){
        if(data){
         this.carTypes = [{value:'', label:'All Types'}];
         data.forEach(element => {
            // added label and value as we are showing label and value in markup.
            // push is used to add element inside an array.
            const carType = {};
            carType.label = element.name;
            carType.value = element.id;
            this.carTypes.push(carType);
            
        });
    } else if(error){
        this.showToast ('ERROR',error.body.message,'error');
    }
 }
 handleCarTypeChange(event){
    // First created the carTypeId then passed it to other component.
    // event is created to tell parent component that child component is selected.
    const carTypeId = event.detail.value;
    // Custom event created.
    const carTypeSelectionChangeEvent = new CustomEvent('cartypeselect', {detail : carTypeId});
    this.dispatchEvent(carTypeSelectionChangeEvent);


}
createNewCarType(){
      
    this[NavigationMixin.Navigate]({
        type:'standard__objectPage',
        attributes:{
            objectApiName : 'Car_Type__c',
            actionName : 'new'
        }
    });

}

 showToast(title,message,variant){
    const evt = new ShowToastEvent({
        title:title,
        message:message,
        variant:variant,
    });
    this.dispatchEvent(evt);
  }


    }