@isTest
public class TestCapitalizeMemberNamesBatch {
    @isTest
    static void test_BatchJob() {
        // Create test data
        List<Member__c> testMembers = new List<Member__c>();
        for (Integer i = 0; i < 200; i++) {
            testMembers.add(new Member__c(Name__c = 'Name' + i, Surname__c = 'Surname' + i, Email__c='test@test.tr'));
        }
        insert testMembers;

        Test.startTest();

        // Enqueue the batch job
        CapitalizeMemberNamesBatch batchJob = new CapitalizeMemberNamesBatch();
        Database.executeBatch(batchJob);

        Test.stopTest();

        // Retrieve the updated records and assert the changes
        List<Member__c> updatedMembers = [SELECT Id, Name__c, Surname__c FROM Member__c WHERE Id IN :testMembers];
        for (Member__c member : updatedMembers) {
            // Assert that names have been capitalized
            System.assertEquals(member.Name__c, member.Name__c.toUpperCase());
            System.assertEquals(member.Surname__c, member.Surname__c.toUpperCase());
        }
    }
}