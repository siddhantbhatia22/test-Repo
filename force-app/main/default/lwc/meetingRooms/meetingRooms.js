import { LightningElement } from 'lwc';

export default class MeetingRooms extends LightningElement {
// Parent property
    meetingRoomsInfo = [
        {roomName:'A-01',roomCapacity:'18'},
        {roomName:'A-02',roomCapacity:'06'},
        {roomName:'A-03',roomCapacity:'14'},
        {roomName:'A-04',roomCapacity:'07'},
        {roomName:'B-01',roomCapacity:'14'}       
    ];
}