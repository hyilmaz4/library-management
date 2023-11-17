@isTest
public class UpdateAsBookVolumeTest {

    @isTest
    static void testUpdateVolume() {
          List<Author__c> authors = new List<Author__c>();
        for (Integer i = 0; i < 5; i++) {
            Author__c author = new Author__c(
                Name__c = 'Author ' + i,
                Surname__c = 'Surname ' + i
            );
            authors.add(author);
        }
        insert authors;


        // Create test data
        List<Books__c> booksList = new List<Books__c>();
        for (Integer i = 0; i < 5; i++) {
            Books__c book = new Books__c(
                Name__c = 'Book ' + i,
                Volume__c = 3,
                Author__c = authors[0].id,
                Price__c = 20.0
            );
            booksList.add(book);
        }
        insert booksList;
        
       
        Test.startTest();
        UpdateAsBookVolume.updateVolume();
        Test.stopTest();

        // Verify the results
        List<Books__c> updatedBooks = [SELECT Name__c, Volume__c, Author__c, Price__c FROM Books__c];
        System.assertEquals(15, updatedBooks.size(), 'Total number of records should be 15');
                system.debug(updatedBooks.size());
        
        for (Books__c book : updatedBooks) {
            if (book.Volume__c > 1) {
                System.assertEquals(1, book.Volume__c, 'Duplicated records should have a volume of 1');
                system.assertEquals(20.0, book.Price__c);
                system.assertEquals('Book 1', book.Name__c);
            } else {
                System.assertEquals(1, book.Volume__c, 'Original records should have a volume of 1');
                system.assertEquals(20.0, book.Price__c);
            }
        }
            
        
        List<Books__c> originalBooks = [SELECT Name__c, Volume__c FROM Books__c WHERE Volume__c > 1];
        System.assertEquals(0, originalBooks.size(), 'Original records should have their volumes updated');
             system.debug(originalBooks.size());
        List<Books__c> duplicatedBooks = [SELECT Name__c, Volume__c FROM Books__c WHERE Volume__c = 1 AND Id NOT IN :booksList];
        System.assertEquals(10, duplicatedBooks.size(), 'Duplicated records should be created');
              system.debug(duplicatedBooks.size());
    }
}