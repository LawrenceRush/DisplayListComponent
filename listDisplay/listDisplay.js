import { LightningElement, wire } from 'lwc';
import { CurrentPageReference } from 'lightning/navigation';
import buildList from '@salesforce/apex/ListDisplayController.buildList';

export default class ListDisplay extends LightningElement {
    columns = [
        { label: 'First Name', fieldName: 'firstName' },
        { label: 'Last Name', fieldName: 'lastName' },
        { label: 'Phone Number', fieldName: 'phoneNumber', type: 'phone' }
    ];

    data;
    people;
    error;

    recordId;

    // Get the current page reference and pull query params from it
    @wire(CurrentPageReference)
    getStateParameters(currentPageReference) {
        if (currentPageReference) {
            this.recordId = currentPageReference.state?.id;
            if (this.recordId) {
                this.loadList();
            }
        }
    }

    loadList() {
        buildList({ recordId: this.recordId })
            .then(result => {
                console.log('List data received:', JSON.stringify(result));
                console.log('List data received:', JSON.stringify(result.people));
                this.data = result;
                this.people = result.people;
                console.log('People data:', this.people);
                this.error = undefined;
            })
            .catch(error => {
                this.error = error;
                this.data = undefined;
            });
    }
}
