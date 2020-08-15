import { LightningElement, api, wire, track } from 'lwc';
import getCars from '@salesforce/apex/CarSearchResultController.getCars';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';


export default class CarSearchResult extends LightningElement {
   
   // passed from parent component carSearch.
    @api carTypeId;
   // array of cars property used in markup carSearchResult used to store the result
    @track cars;
   // used to the blue box on selected component
    @track selectedCarId;
   // used to get the details from server i.e apex.carSearchController
    @wire(getCars, {carTypeId : '$carTypeId'})
    wiredCars({data, error}){
        if(data){
            this.cars = data;
        } else if(error){
            this.showToast('ERROR', error.body.message, 'error');
        }
    }

    showToast(title, message, variant) {
        const evt = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant,
        });
        this.dispatchEvent(evt);
    }

    carSelectHandler(event){
        const carId = event.detail;
        this.selectedCarId = carId;
    }

    get carsFound(){
        if(this.cars){
            return true;
        }
        return false;
    }
}