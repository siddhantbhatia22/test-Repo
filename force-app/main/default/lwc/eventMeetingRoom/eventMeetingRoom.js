import { LightningElement, api, wire } from 'lwc';
import {fireEvent} from 'c/pubsub';
import {CurrentPageReference} from 'lightning/navigation';

export default class MeetingRoom extends LightningElement {
    @api meetingRoomInfo = {roomName:'A-01', roomCapacity:'12'}

    @api showRoomInfo = false;

    @wire(CurrentPageReference) CurrentPageReference;

    tileClickHandler(){
        // constructor and event created; variable declared tileclick, payload added meetingRoomInfo
        const tileClicked = new CustomEvent('tileclick', {detail : this.meetingRoomInfo, bubbles :true});
       // event fired with dispatchevent
        this.dispatchEvent(tileClicked);
        // fireEvent is used from pubsub library.
        fireEvent(this.CurrentPageReference,'pubsubtileclick',this.meetingRoomInfo)
    }
}