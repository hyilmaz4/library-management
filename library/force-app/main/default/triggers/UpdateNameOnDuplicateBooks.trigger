trigger UpdateNameOnDuplicateBooks on Books__c (after insert, after update) {

    for (Books__c book : Trigger.new) {
        String bookName = book.Name__c;
        Integer bookVolume = Integer.valueOf(book.Volume__c);
        List<Books__c> booksToUpdate = new List<Books__c>();

        if (Trigger.isInsert && bookVolume > 1) {
            // For new records with more than one volume, update the Name__c field
            for (Integer i = 1; i <= bookVolume; i++) {
                Books__c updatedBook = new Books__c(
                    Id = book.Id,
                    Name__c = bookName + ' ' + String.valueOf(i)
                    
                );
                booksToUpdate.add(updatedBook);
                system.debug(booksToUpdate);
            }
        } else if (Trigger.isUpdate && bookVolume != Trigger.oldMap.get(book.Id).Volume__c) {
            // For updated records with a change in volume, update the Name__c field
            for (Integer i = 1; i <= bookVolume; i++) {
                Books__c updatedBook = new Books__c(
                    Id = book.Id,
                    Name__c = bookName + ' ' + String.valueOf(i)
                );
                booksToUpdate.add(updatedBook);
                system.debug(booksToUpdate);
            }
        }
         if (!booksToUpdate.isEmpty()) {
            update booksToUpdate;
        }
}
}