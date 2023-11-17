trigger UpdateMemberLastBookPurchaseDate on Book_Tracking__c (before insert, before update) {
    // Collect the Member__c record Ids for all inserted Book_Tracking__c records
    Set<Id> memberIds = new Set<Id>();
    for (Book_Tracking__c bookTracking : Trigger.new) {
        if (bookTracking.Borrowed_By__c != null) {
            memberIds.add(bookTracking.Borrowed_By__c);
        }
    }

    // Query the latest Issue_Date__c for each Member__c record
    Map<Id, Date> memberLastBookPurchaseDates = new Map<Id, Date>();
    for (AggregateResult result : [
        SELECT Borrowed_By__c, MAX(Issue_Date__c) maxIssueDate
        FROM Book_Tracking__c
        WHERE Borrowed_By__c IN :memberIds
        GROUP BY Borrowed_By__c
    ]) {
        Id memberId = (Id)result.get('Borrowed_By__c');
        Date maxIssueDate = (Date)result.get('maxIssueDate');
        memberLastBookPurchaseDates.put(memberId, maxIssueDate);
    }

    // Update the Member__c records with the latest Issue_Date__c
    List<Member__c> membersToUpdate = new List<Member__c>();
    for (Id memberId : memberIds) {
        if (memberLastBookPurchaseDates.containsKey(memberId)) {
            Member__c member = new Member__c(Id = memberId);
            member.Last_Book_Read_Date__c = memberLastBookPurchaseDates.get(memberId);
            membersToUpdate.add(member);
        }
    }

    // Perform the updates
    update membersToUpdate;
}