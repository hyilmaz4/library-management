public class CapitalizeMemberNamesBatch implements Database.Batchable<sObject> {
    public Database.QueryLocator start(Database.BatchableContext context) {
        String query = 'SELECT Id, Name__c, Surname__c FROM Member__c';
        return Database.getQueryLocator(query);
    }

    public void execute(Database.BatchableContext context, List<Member__c> scope) {
        for (Member__c member : scope) {
            member.Name__c = member.Name__c.toUpperCase();
            member.Surname__c = member.Surname__c.toUpperCase();
        }
        update scope;
    }

    public void finish(Database.BatchableContext context) {
        // Optional: Add any post-processing logic if needed.
    }
}