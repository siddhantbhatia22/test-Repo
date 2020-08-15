import { LightningElement,track } from 'lwc';

export default class NewInputTest extends LightningElement {
   @track results
    firstName;
    lastName;

    changeHandler(event){
        const inputName = event.target.name;
        if (inputName === 'firstName') {
            this.firstName=event.target.value;
            }else if (inputName === 'lastName') {
                this.lastName=event.target.value;
              }
           }


}