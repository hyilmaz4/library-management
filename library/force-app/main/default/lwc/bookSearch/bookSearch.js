import { LightningElement, track, api } from 'lwc';
import getBook from '@salesforce/apex/BookSearch.getBook';

const columns = [
    { label: 'Book Name', fieldName: 'BookURL', type: 'url', typeAttributes: { label: { fieldName: 'Name__c' } } },
    { label: 'Author', fieldName: 'Author__c', type: 'text' },
    { label: 'Member Name', fieldName: 'MemberName__c', type: 'text' },
    { label: 'PublishedBy', fieldName: 'Published_By__c', type: 'text' },
    { label: 'Page', fieldName: 'Pages__c', type: 'text' },
    { label: 'Price', fieldName: 'Price__c', type: 'text' },
    { label: 'Genre', fieldName: 'Genre__c', type: 'text' },
    { label: 'Status', fieldName: 'Status__c', type: 'text' },
    { label: 'Total_Issued', fieldName: 'Total_Issued__c', type: 'text' },
    { label: 'Total_Returned', fieldName: 'Total_Returned__c', type: 'text' }
  
];

export default class BookSearch extends LightningElement {
    @track searchText = '';
    @track bookList = [];
    @track isNoRecordFound = false;

    columns = columns;
    @api title;

    handleSearch(event) {
        this.searchText = event.target.value;
        this.loadBooks();
    }

    loadBooks() {
        getBook({ textkey: this.searchText })
            .then(result => {
                if (result && result.length > 0) {
                    this.bookList = result.map(book => {
                        const { Name__c, Published_By__c,Pages__c,Price__c,Genre__c,Total_Issued__c,Total_Returned__c, Books_Tracking__r } = book;
                        if (!Books_Tracking__r || Books_Tracking__r.length === 0) {
                            return {
                                Name__c,
                                Published_By__c,
                                Pages__c,
                                Price__c,
                                Genre__c,
                                Total_Issued__c,
                                Total_Returned__c,
                                MemberName__c: null,
                                Author__c: null,
                                Status__c: null,
                                BookURL: '/lightning/r/Books_c/' + book.Id + '/view'
                                
                            };
                        } else {
                            return {
                                Name__c,
                                Published_By__c,
                                Pages__c,
                                Price__c,
                                Genre__c,
                                Total_Issued__c,
                                Total_Returned__c,
                                ...Books_Tracking__r[0],
                                BookURL: '/lightning/r/Books_c/' + book.Id + '/view'
                            };
                        }
                    });
                    this.isNoRecordFound = false;
                } else {
                    this.bookList = [];
                    this.isNoRecordFound = true;
                }
            })
            .catch(error => {
                this.isNoRecordFound = true;
                console.error(error);
            });
    }
}
