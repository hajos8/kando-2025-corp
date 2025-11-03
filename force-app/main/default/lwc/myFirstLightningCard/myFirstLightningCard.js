import { LightningElement, api } from 'lwc';

export default class MyFirstLightningCard extends LightningElement {
    @api recordId;

    connectedCallback() {
        console.log('Record Id: ' + this.recordId);
    }

    
}