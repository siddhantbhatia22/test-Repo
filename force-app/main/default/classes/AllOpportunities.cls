public with sharing class AllOpportunities {
    @AuraEnabled(cacheable=true)
        public static List<Opportunity> getAllOpportunities() {
        return[Select Id, Name, StageName, CloseDate,Account.Name, type From Opportunity];

    }
}