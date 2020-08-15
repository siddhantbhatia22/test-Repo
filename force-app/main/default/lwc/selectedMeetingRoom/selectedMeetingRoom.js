import { LightningElement, track, wire } from 'lwc';
import {registerListener, unregisterAllListeners} from 'c/pubsub';
import { CurrentPageReference } from 'lightning/navigation';

export default class SelectedMeetingRoom extends LightningElement {
    @track selectedMeetingRoom = {};

    @wire(CurrentPageReference) pageRef;
    
    connectedCallback(){
        registerListener('pubsubtileclick', this.onMeetingRoomSelectHandler, this);
    }

   // is called when component is destroyed.
    disconnectedCallback(){
        unregisterAllListeners(this);
    }
    // this is used to handle the fired event from componentMeetingRoom
    onMeetingRoomSelectHandler(payload){
        this.selectedMeetingRoom = payload;
    }

}