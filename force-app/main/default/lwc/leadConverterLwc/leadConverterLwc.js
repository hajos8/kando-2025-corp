import { LightningElement, api } from 'lwc';

export default class LeadConverterLwc extends LightningElement {
    @api recordId;

    connectedCallback() {
        console.log('Record ID: ' + this.recordId);
    }

    renderedCallback() {
        console.log('Rendered Callback executed');
    }

    disconnectedCallback() {
        console.log('Component disconnected from DOM');
    }

}