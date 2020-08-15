import { LightningElement,wire, track } from 'lwc';
import getAllOpportunities from '@salesforce/apex/AllOpportunities.getAllOpportunities'

const columns = [
    { label: 'Opportunity Name', fieldName: 'Name', 
    typeAttributes: {label: { fieldName: 'Name' },target: '_blank'}},
    { label: 'Stage', fieldName: 'StageName', type: 'text' },
    { label: 'Close Date', fieldName: 'CloseDate', type: 'date' }
    
];


export default class OpportunityView extends LightningElement {
    @track data = [];
    @track columns = columns;
    @wire(getAllOpportunities)
    wiredOpps({
        data,error
    }) {
        if (data) {
            this.data = data;
            console.log(data);
            console.log(JSON.stringify(data, null, '\t'));
        } else if (error) {
            this.error = error;
        }
    }

    

        
    }