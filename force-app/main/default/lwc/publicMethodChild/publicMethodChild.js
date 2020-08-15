import { LightningElement, track, api } from 'lwc';

export default class PublicMethodChild extends LightningElement {
    // Lightning Checkbox group component.
    // Defualt value.
    @track value = ['red'];

    options = [
        { label: 'Red Marker', value: 'red' },
        { label: 'Blue Marker', value: 'blue' },
        { label: 'Green Marker', value: 'green' },
        { label: 'Black Marker', value: 'black' },
    ];

// public method; Should call value from from parent component
    @api
    selectCheckbox(checkboxValue){
        const selectedCheckbox = this.options.find( checkbox =>{
            return checkboxValue === checkbox.value;
        })

        if(selectedCheckbox){
            // only providing value
            this.value = selectedCheckbox.value;
            return "Successfully checked";
        } 
        return "No checkbox found";
        
    }

}