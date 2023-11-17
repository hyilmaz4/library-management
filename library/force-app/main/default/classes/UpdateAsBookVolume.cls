public class UpdateAsBookVolume {
    public static void updateVolume() {
        List<Books__c> booksToInsert = new List<Books__c>();
        List<Books__c> oldList = [SELECT Name__c, Volume__c, Author__c, Price__c FROM Books__c];

        for (Books__c book : oldList) {
            if (book.Volume__c > 1) {
                // For new records with more than one volume, create new records with the same name
                for (Integer i = 2; i <= book.Volume__c; i++) {
                    Books__c updatedBook = new Books__c(
                        Name__c = book.Name__c,
                        Volume__c = 1,  // Set the volume to 1 for the duplicated records
                        Author__c = book.Author__c,  // Set the author from the original record
                        Price__c = book.Price__c
                 
                    );
                    booksToInsert.add(updatedBook);
                    System.debug(updatedBook); // Use updatedBook instead of booksToUpdate for debugging
                }
            }
        }
     // Update the volume of the original records
    for (Books__c book : oldList) {
        book.Volume__c = 1;
    }
        // Insert the new records
        if (!booksToInsert.isEmpty()) {
            insert booksToInsert;
        }
    }
}


// geriye kalan volume 1 den farklı olan kayıtları Anonymus Window 
 /* List<Books__c> booksToUpdate = new List<Books__c>();
        List<Books__c> oldList = [SELECT Id, Name__c, Volume__c, Author__c, Price__c FROM Books__c WHERE Volume__c <> 1];

        for (Books__c book : oldList) {
            book.Volume__c = 1; // Set the volume to 1 for the records with volume not equal to 1
            booksToUpdate.add(book);
        }

        // Update the records with the new volume
        if (!booksToUpdate.isEmpty()) {
            update booksToUpdate;
        }*/