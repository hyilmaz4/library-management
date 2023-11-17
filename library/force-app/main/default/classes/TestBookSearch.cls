@isTest
public class TestBookSearch{
    @testSetup
    static void setupTestData() {
        // Create test data for Authors__c (assuming this is the object where Authors are stored)
        List<Author__c> authors = new List<Author__c>();
        for (Integer i = 0; i < 5; i++) {
            Author__c author = new Author__c(
                Name__c = 'Author ' + i,
                Surname__c = 'Surname ' + i
            );
            authors.add(author);
        }
        insert authors;

        // Create test data for Books__c
        List<Books__c> books = new List<Books__c>();
        for (Integer i = 0; i < 5; i++) {
            Books__c book = new Books__c(
                Name__c = 'Book ' + i + ' Name',
                Volume__c = (Decimal) i,
                Author__c = authors[i].Id, // Use the Id of the corresponding Author
                Price__c = (Decimal) (i * 10)
            );
            books.add(book);
        }
        insert books;

        // Create test data for Borrowers__c (assuming this is the object where Borrowers are stored)
        List<Member__c> borrowers = new List<Member__c>();
        for (Integer i = 0; i < 5; i++) {
            Member__c borrower = new Member__c(
                Name__c = 'Borrower ' + i,
                Surname__c = 'Surname ' + i,
                Email__c= 'hy@hy.hy'
            );
            borrowers.add(borrower);
        }
        insert borrowers;

        // Create related Book_Tracking__c records
        List<Book_Tracking__c> trackingRecords = new List<Book_Tracking__c>();
        for (Books__c book : books) {
            for (Integer j = 0; j < 2; j++) {
                Book_Tracking__c tracking = new Book_Tracking__c(
                    Book_Name__c = book.Id,
                    Borrowed_By__c = borrowers[j].Id, // Use the Id of the corresponding Borrower
                    Status__c = 'Issued',
                    Issue_Date__c=date.today()
                );
                trackingRecords.add(tracking);
            }
        }
        insert trackingRecords;
    }

    @isTest
    static void testGetBook() {
        // Test querying books based on search key
        Test.startTest();
        List<Books__c> result = BookSearch.getBook('Book 1');
        Test.stopTest();

        // Verify results
        System.assertEquals(1, result.size());
        System.assertEquals('Book 1 Name', result[0].Name__c);
        System.assertEquals(1.0, result[0].Volume__c); // Volume__c is of type Decimal

        System.assertEquals(2, result[0].Books_Tracking__r.size());
    }

    @isTest
    static void testExceptionHandling() {
        Test.startTest();
        try {
            List<Books__c> result = BookSearch.getBook(null);
        } catch (AuraHandledException e) {
            System.assert(e.getMessage() != null);
        }
        Test.stopTest();
    }
}