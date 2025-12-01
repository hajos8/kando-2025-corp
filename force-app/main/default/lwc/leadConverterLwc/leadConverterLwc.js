import { LightningElement, api } from 'lwc';

export default class LeadConverterLwc extends LightningElement {
    _recordId;
    @api get recordId() {
        return this._recordId;
    };
    async handleRecordIdSet(event) {
        console.log('Record ID set to: ' + event.detail.value);
    }
    set recordId(value) {
        this._recordId = value;
    }

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