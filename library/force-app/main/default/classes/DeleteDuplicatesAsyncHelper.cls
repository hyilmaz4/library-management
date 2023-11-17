public class DeleteDuplicatesAsyncHelper {
    @future
    public static void deleteDuplicatesAsync(List<Id> bookIdsToDelete) {
        // Delete the duplicate records for the specified book IDs
        List<Books__c> booksToDelete = [SELECT Id FROM Books__c WHERE Id IN :bookIdsToDelete];
        delete booksToDelete;
    }
}