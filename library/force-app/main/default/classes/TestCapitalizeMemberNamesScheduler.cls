@isTest
public class TestCapitalizeMemberNamesScheduler {
    @isTest
    static void test_Scheduler() {
        // Create test data
        List<Member__c> testMembers = new List<Member__c>();
        for (Integer i = 0; i < 200; i++) {
            testMembers.add(new Member__c(Name__c = 'Name' + i, Surname__c = 'Surname' + i, Email__c='test@test.tr'));
        }
        insert testMembers;
         system.debug(testMembers);
        
        
        String cronExp = '0 0 0 * * ?'; // Set the cron expression to a date in the future
        Test.startTest();
         CapitalizeMemberNamesScheduler capName= new CapitalizeMemberNamesScheduler();
        system.schedule('CapitalizeMemberNamesScheduler', cronExp, capName);
     
        Test.stopTest();
        system.debug(capName);

    }
}