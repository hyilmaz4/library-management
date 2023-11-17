public class CapitalizeMemberNamesScheduler implements Schedulable {
    public void execute(SchedulableContext context) {
        // Create an instance of the batch class
        CapitalizeMemberNamesBatch batchJob = new CapitalizeMemberNamesBatch();
        
        // Execute the batch job
        Database.executeBatch(batchJob);
    }
}