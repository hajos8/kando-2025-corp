import { LightningElement, api } from 'lwc';
import GreaterHungary from '@salesforce/resourceUrl/GreaterHungary';
import customConvertLead from '@salesforce/apex/LeadConversionService.customConvertLead';

export default class LeadConverterLwc extends LightningElement {
    GreaterHungary = GreaterHungary;

    isLoading = false;

    _recordId;
    @api get recordId() {
        return this._recordId;
    };
    async handleRecordIdSet(event) {
        console.log('Record ID set to: ' + event.detail.value);
    }
    isRecordIdSet() {
        return this._recordId !== undefined && this._recordId !== null;
    }
    set recordId(value) {
        this._recordId = value;
        this.handleRecordIdSet(value).catch(console.warn);
    }

    displayInfo = {
        primaryField: 'Name',
        additionalFields: ['Company', 'Email']
    }

    handleConvertLead() {
        if (this.isRecordIdSet()) {
            this.isLoading = true;
            // Logic to convert lead goes here
            console.log('Converting lead with ID: ' + this.recordId);
            customConvertLead({ leadId: this.recordId })
                .then(result => {
                    console.log('Lead converted successfully: ' + JSON.stringify(result));
                    const parsedResult = JSON.parse(result);
                    location.href = '/' + parsedResult.contactId;
                })
                .catch(error => {
                    console.error('Error converting lead: ' + error);
                })
                .finally(() => {
                    this.isLoading = false;
                });
        } else {
            console.warn('Record ID is not set. Cannot convert lead.');
        }
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