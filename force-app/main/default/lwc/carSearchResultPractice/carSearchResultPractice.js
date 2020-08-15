import { LightningElement,api,wire,track } from 'lwc';
import getCars from '@salesforce/apex/CarSearchResultController.getCars'
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class CarSearchResultPractice extends LightningElement {

     @api carTypeId
    // array of cars used to store the all cars to display
     // used to the blue box on selected component
     @track selectedCarId;
     
     @track cars;
    //passed the apex method and apex class parameters
     @wire(getCars, {carTypeId : '$carTypeId'})
     wiredCars({data,error}){
         if(data){
             this.cars = data;
         } else if(error){
            this.showToast ('ERROR',error.body.message,'error');
        }
    }
        showToast(title,message,variant){
            const evt = new ShowToastEvent({
                title:title,
                message:message,
                variant:variant,
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