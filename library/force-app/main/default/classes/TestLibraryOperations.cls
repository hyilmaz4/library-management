@isTest
public class TestLibraryOperations{
    @isTest
    static void testCheckVisitorMembership() {
        // Create test data: Member__c and Author__c records
        Member__c testMember = new Member__c(Name__c = 'John', Surname__c = 'Doe', Email__c = 'john.doe@example.com');
        insert testMember;
         system.debug(testMember);
        Author__c testAuthor = createTestAuthor();
        insert testAuthor;
           system.debug(testAuthor);
        // Create a test Book__c record
        Books__c testBook = new Books__c(
            Name__c = 'Test Book',
            Author__c = testAuthor.Id,
            Price__c = 50.0,
            Volume__c = 15
        );
        insert testBook;
           system.debug(testBook);
        // Create a test Book_Tracking__c record associated with the test Book__c record
        Book_Tracking__c testBookTracking = new Book_Tracking__c(
            Book_Name__c = testBook.Id,
            Borrowed_By__c = testMember.Id,
            Status__c='Issued',
            Issue_Date__c= date.today()
        );
        insert testBookTracking;
          system.debug(testBookTracking);
        // Test the checkVisitorMembership method
        Test.startTest();
        System.debug('Test Case 1: Existing Member');
        LibraryOperations.checkVisitorMembership('John', 'Doe');
        System.debug('Test Case 2: Non-existing Member');
        LibraryOperations.checkVisitorMembership('Jane', 'Smith');
        Test.stopTest();
    }

    @isTest
    static void testCorrectAuthorName() {
        // Create test data: Author__c record
        Author__c testAuthor = createTestAuthor();
        insert testAuthor;

        // Test the correctAuthorName method
        Test.startTest();
        System.debug('Test Case 1: Correct the author name');
        LibraryOperations.correctAuthorName(testAuthor.Name__c, 'Corrected Author');
        Test.stopTest();

        // Verify that the author's name is updated correctly
        Author__c updatedAuthor = [SELECT Id, Name__c FROM Author__c WHERE Id = :testAuthor.Id];
        System.assertEquals('Corrected Author', updatedAuthor.Name__c);
    }

    // Helper method to create a test Author__c record
    static Author__c createTestAuthor() {
        return new Author__c(Name__c = 'Test Author');
    }
}