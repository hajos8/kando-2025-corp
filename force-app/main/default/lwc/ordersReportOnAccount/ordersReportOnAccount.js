import { LightningElement, api } from 'lwc';
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import { CloseActionScreenEvent } from "lightning/actions";

export default class OrdersReportOnAccountPreview extends LightningElement {
    @api recordId;

    showSpinner = false;

    cdlId;
    urlToCD;

    fillPreviewTableData() {

    }

    handleCreateFile() {


        this.showSpinner = false;

        const toastEvent = new ShowToastEvent({
            title: 'Success',
            message: `XLSX file created! ContentDocument Id: ${this.cdlId}`,
            messageData: {
                url: this.urlToCD,
                label: 'This is a clickable link to the new Excel file ...',
                target: '_blank'
            },
            variant: 'success',
            mode: 'dismissable'
        });

    }

    handleShowTable() {

    }

    handleCloseWindow() {
        this.dispatchEvent(new CloseActionScreenEvent());
    }
}