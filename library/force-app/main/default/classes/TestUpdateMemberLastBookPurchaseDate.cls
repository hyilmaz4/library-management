@isTest
public class TestUpdateMemberLastBookPurchaseDate {
    @isTest
    static void testUpdateLastBookPurchaseDate() {
        // Create a test Member__c record
        Member__c testMember = new Member__c(Name__c = 'mehmet', Surname__c = 'gel', Email__c = 'mhm@gl.tr');
        insert testMember;

        // Create a test Author__c record
        Author__c testAuthor = new Author__c();
        insert testAuthor;

        // Create a test Book__c record
       List<Books__c> books = new List<Books__c>();
        books.add(new Books__c(Name__c = 'Book1', Author__c = testAuthor.Id, Volume__c = 20, Price__c = 50));
        books.add(new Books__c(Name__c = 'Book2', Author__c = testAuthor.Id, Volume__c = 20, Price__c = 50));
        books.add(new Books__c(Name__c = 'Book3', Author__c = testAuthor.Id, Volume__c = 20, Price__c = 50));
        insert books;

        // Create test Book_Tracking__c records associated with the test Member__c record
       Book_Tracking__c book1 = new Book_Tracking__c(Borrowed_By__c = testMember.Id, Book_Name__c= books[0].id, 
                                                     Issue_Date__c = Date.newInstance(2023,12,1), Status__c='Issued');
        insert book1;

        // Introduce a delay (e.g., 2 seconds) before inserting the second Book_Tracking__c record
        Test.startTest();
        Long delayMillis = 2000; // 2 seconds
        Long startTime = System.now().getTime();
        while (System.now().getTime() < startTime + delayMillis) {
            // Wait for the specified delay
        }
       
        Book_Tracking__c book2 = new Book_Tracking__c(Borrowed_By__c = testMember.Id, Book_Name__c= books[1].id, 
                                                      Issue_Date__c = Date.newInstance(2023,12,15),Status__c='Issued');
        insert book2;

        // Introduce a delay (e.g., 2 seconds) before inserting the second Book_Tracking__c record
        
        Long delayMilliss = 2000; // 2 seconds
        Long startTimee = System.now().getTime();
        while (System.now().getTime() < startTime + delayMillis) {
            // Wait for the specified delay
        }
        Test.stopTest();
        
        Book_Tracking__c book3 = new Book_Tracking__c(Borrowed_By__c = testMember.Id,
                                                      Book_Name__c= books[2].id, Issue_Date__c = Date.newInstance(2023,12,30),
                                                      Status__c='Issued');
        insert book3;
        

        
        // Trigger should have updated the Last_Book_Read_Date__c on the Member__c record
        testMember = [SELECT Id, Last_Book_Read_Date__c FROM Member__c WHERE Id = :testMember.Id];
        Date expectedLastBookReadDate = Date.newInstance(2023,12,15);
        System.assertEquals(expectedLastBookReadDate, testMember.Last_Book_Read_Date__c, 'Last_Book_Read_Date__c should be updated');
    }
}


/*@isTest
public class UpdateMemberLastBookReadDateTest {
    @isTest
    static void testUpdateMemberLastBookReadDate() {
        // Create test data - Member__c and related Book_Tracking__c records
                Author__c testAuthor = new Author__c(Name__c = 'George Orwell');
        insert testAuthor;
        
        Member__c testMember = new Member__c(Name__c = 'Test', SurName__c='Member', Email__c='test@test.com');
        insert testMember;
        
        List<Books__c> books = new List<Books__c>();
        books.add(new Books__c(Name__c = 'Book1', Author__c = testAuthor.Id, Volume__c = 20, Price__c = 50));
        books.add(new Books__c(Name__c = 'Book2', Author__c = testAuthor.Id, Volume__c = 20, Price__c = 50));
        books.add(new Books__c(Name__c = 'Book3', Author__c = testAuthor.Id, Volume__c = 20, Price__c = 50));
        insert books;
        
        Book_Tracking__c book1 = new Book_Tracking__c(Borrowed_By__c = testMember.Id, Book_Name__c= books[0].id, 
Issue_Date__c = Date.newInstance(2023, 8, 1), Status__c='Issued');
        insert book1;

        // Introduce a delay (e.g., 2 seconds) before inserting the second Book_Tracking__c record
        Test.startTest();
        Long delayMillis = 2000; // 2 seconds
        Long startTime = System.now().getTime();
        while (System.now().getTime() < startTime + delayMillis) {
            // Wait for the specified delay
        }
       
        Book_Tracking__c book2 = new Book_Tracking__c(Borrowed_By__c = testMember.Id, Book_Name__c= books[1].id, 
Issue_Date__c = Date.newInstance(2023, 8, 15), Status__c='Issued');
        insert book2;

        // Introduce a delay (e.g., 2 seconds) before inserting the second Book_Tracking__c record
        
        Long delayMilliss = 2000; // 2 seconds
        Long startTimee = System.now().getTime();
        while (System.now().getTime() < startTime + delayMillis) {
            // Wait for the specified delay
        }
        Test.stopTest();
        
        Book_Tracking__c book3 = new Book_Tracking__c(Borrowed_By__c = testMember.Id, Book_Name__c= books[2].id, 
Issue_Date__c = Date.newInstance(2023, 8, 30), Status__c='Issued');
        insert book3;
        

        
        // Trigger should have updated the Last_Book_Read_Date__c on the Member__c record
        testMember = [SELECT Id, Last_Book_Read_Date__c FROM Member__c WHERE Id = :testMember.Id];
        Date expectedLastBookReadDate = Date.newInstance(2023, 8, 15);
        System.assertEquals(expectedLastBookReadDate, testMember.Last_Book_Read_Date__c, 'Last_Book_Read_Date__c should be updated');
    }
}*/