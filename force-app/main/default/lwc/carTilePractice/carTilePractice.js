import { LightningElement, api } from 'lwc';

export default class CarTilePractice extends LightningElement {
 @api car;

 @api carSelectedId;
// created an event and passed the selected id to parent component. To show blue border
handleCarSelect(event){
    event.preventDefault();
// carid  and event created to pass to parent  
    const carId = this.car.Id;

    const carSelect = new CustomEvent('carselect', {detail:carId});
    this.dispatchEvent(carSelect);
}
    get isCarSelected(){
    if(this.car.Id === this.carSelectedId){
        return "tile selected";
    }
    return "tile";
}
}