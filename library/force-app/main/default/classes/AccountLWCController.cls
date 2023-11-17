public with sharing class AccountLWCController {
    //consructor
    
    public AccountLWCController(){
        
    }
        @AuraEnabled(cacheable=true)
        public static list<Account> retrive(string searchterm){
            list<Account> multiAcc=new list<Account>();
            string search ='%' +searchterm + '%';
            try{
                multiAcc=[SELECT Id,Name, Industry,Website,Phone FROM Account 
                          WHERE name LIKE :Search ORDER BY CreatedDate DESC];
            } Catch (exception e){
                throw new AuraHandledException(e.getMessage());
            }
            return multiAcc;
        
    }

}