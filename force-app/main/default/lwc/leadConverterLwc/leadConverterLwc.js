import { LightningElement, api } from 'lwc';
import { navigationMixin } from 'lightning/navigation';

import GreaterHungary from '@salesforce/resourceUrl/GreaterHungary';
import customConvertLead from '@salesforce/apex/LeadConversionService.customConvertLead';

export default class LeadConverterLwc extends LightningElement {
    GreaterHungary = GreaterHungary;

    isLoading = false;

    _recordId;
    @api get recordId() {
        return this._recordId;
    };
    async handleRecordIdSet(value) {
        // When parent sets `recordId` it passes the raw value, not an event.
        console.log('Record ID set to: ' + value);
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

    async handleConvertLead() {
        if (!this.isRecordIdSet()) {
            console.warn('Record ID is not set. Cannot convert lead.');
            return;
        }

        this.isLoading = true;
        try {
            console.log('Converting lead with ID: ' + this.recordId);
            customConvertLead({ leadId: this.recordId })
                .then(result => {
                    console.log('Lead converted successfully: ' + JSON.stringify(result));
                    const parsedResult = JSON.parse(result);

                    const contactId = parsedResult?.contactId;

                    if (contactId) {
                        this[navigationMixin.Navigate]({
                            type: 'standard__recordPage',
                            attributes: {
                                recordId: contactId,
                                objectApiName: 'Contact',
                                actionName: 'view'
                            }
                        });
                    }

                })
                .catch(error => {
                    console.error('Error converting lead: ' + error);
                })
                .finally(() => {
                    this.isLoading = false;
                });
        }
        catch (error) {
            console.warn('Error in handleConvertLead: ' + error);
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