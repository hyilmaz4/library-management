public with sharing class BookSearch {

    @AuraEnabled(cacheable=true)
    public static List<Books__c> getBook(String textkey) {
        String keyString = '%' + textkey + '%'; 
        List<Books__c> multiBook = new List<Books__c>();
        try {
            multiBook = [SELECT Name, Name__c, Volume__c, Published_By__c,Pages__c,Price__c,Genre__c,Total_Issued__c,Total_Returned__c,
                    (SELECT BookName__c, MemberName__c, Author__c, Status__c FROM Books_Tracking__r) 
                FROM Books__c WHERE Name__c  LIKE :keyString ]; 
            
            system.debug(multiBook);
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
         system.debug(multiBook);
        
        return multiBook;
    }  
}