import { LightningElement,track } from 'lwc';

export default class HelloWorldDynamic extends LightningElement {
 
    @track dynamicGreeting = 'India';
    greetingHandler(event){
        
        this.dynamicGreeting= event.target.value;
    }

}