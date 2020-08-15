public with sharing class AccountManagerImparatively {
    
    @AuraEnabled
    public static List<Account> getAccount(Integer numberOfRecords){

        return [SELECT Id, Name, Phone FROM Account Limit :numberOfRecords];
        
    }
}