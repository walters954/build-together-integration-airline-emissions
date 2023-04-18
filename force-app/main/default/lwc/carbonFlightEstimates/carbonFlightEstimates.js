import { LightningElement, wire } from 'lwc';
import getFlightEstimateRequest from '@salesforce/apex/CarbonCallout.getFlightEstimateRequest';

export default class CarbonFlightEstimates extends LightningElement {
    flightEstimatesWrapperData;

    @wire(getFlightEstimateRequest)
    wiredFlightEstimatesWrapperData({ error, data }) {
        console.log('data has this value: ' + data);
        if (data) {
            this.flightEstimatesWrapperData = data;
        } else if (error) {
            console.error(error);
        }
    }
}
