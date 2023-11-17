trigger UpdateIdAsVolume on Books__c (before insert,before update) {
    List<Books__c> booksToUpdate = new List<Books__c>();

    for (Books__c book : Trigger.new) {
        if (book.Volume__c > 1) {
            // For new records with more than one volume, create new records with the same name
            for (Integer i = 1; i < book.Volume__c; i++) {
                Books__c updatedBook = new Books__c(
                    Name__c = book.Name__c,
                    Author__c = book.Author__c,  // Set the author from the original record
                    Price__c = book.Price__c,
                    Volume__c = 1  // Set the volume to 1 for the duplicated records
                );
                booksToUpdate.add(updatedBook);
                System.debug(booksToUpdate);
            }
        }
          
        }  
            

    // Update the volume of the original records
    for (Books__c book : Trigger.new) {
         book.Volume__c = 1;
    }

    // Insert the duplicated records
    insert booksToUpdate;
}