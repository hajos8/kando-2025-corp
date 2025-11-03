import { LightningElement, api } from 'lwc';

export default class MyFirstLightningCard extends LightningElement {
    _recordId;
    @api get recordId(){
        console.log('Record Id get: ' + this._recordId);
        return this._recordId;
    }

    set recordId(value){
        this._recordId = value;
        console.log('Record Id set: ' + this._recordId);
    }

    connectedCallback() {
        console.log('Record Id: ' + this.recordId);
    }

    renderedCallback() {
        console.log('Record Id rendered: ' + this.recordId);
    }

    disconnectedCallback() {
        console.log('Record Id disconnected: ' + this.recordId);
    }   
}