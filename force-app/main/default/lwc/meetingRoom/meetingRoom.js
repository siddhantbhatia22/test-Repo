import { LightningElement, api } from 'lwc';

export default class MeetingRoom extends LightningElement {
    // Public property - should always come from parent component.
  //  @api meetingRoomInfo;//{roomName:'A-01',roomCapacity:'12'}
   // Boolean property
    @api showRoomInfo = false;


}