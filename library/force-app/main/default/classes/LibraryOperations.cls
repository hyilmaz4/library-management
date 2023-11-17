public class LibraryOperations {
    // Step 5: Check if a visitor with the given first name and last name exists
    public static void checkVisitorMembership(String firstName, String lastName) {
        List<Member__c> members = [SELECT Id, Name FROM Member__c WHERE Name__c = :firstName AND Surname__c = :lastName];
        
 
        
        if (!members.isEmpty()) {
        List<Map<String, String>> booksRead = new List<Map<String, String>>();
        List<Book_Tracking__c> bookTrackings = [SELECT Id, Book_Name__r.Name__c, Book_Name__r.Author__r.Name__c, 
                                                Book_Name__r.Author__r.Surname__c, Borrowed_By__r.Name__c, Borrowed_By__r.Surname__c
                                                FROM Book_Tracking__c
                                                WHERE Borrowed_By__c = :members];

        for (Book_Tracking__c bookTracking : bookTrackings) {
            Map<String, String> bookInfo = new Map<String, String>();
            bookInfo.put('Book Name', bookTracking.Book_Name__r.Name__c);
            bookInfo.put('Author Name and Surname', bookTracking.Book_Name__r.Author__r.Name__c +' '+ 
                         bookTracking.Book_Name__r.Author__r.Surname__c);
            
            booksRead.add(bookInfo);
        }
            System.debug(firstName + ' ' + lastName + ' is a member of the library.');
            System.debug('Books read by the member:'+booksRead);
        } else {
            System.debug(firstName + ' ' + lastName + ' is not a member of the library.');
        }
    }



    // Step 7: Correct the misspelled author name
    public static void correctAuthorName(String incorrectName, String correctName) {
        List<Author__c> authorsToUpdate = [SELECT Id, Name__c FROM Author__c WHERE Name__c = :incorrectName];

        for (Author__c author : authorsToUpdate) {
            author.Name__c = correctName;
        }

        update authorsToUpdate;
    }
}