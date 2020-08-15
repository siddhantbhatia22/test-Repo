trigger UpdateEfforts on Timesheet__c (before insert, before update) 
{
    for (Timesheet__c updatedTimesheet:System.Trigger.new) 
    {
        if (updatedTimesheet.Incident__c != NULL)
        {
            Incident__c incdetail = [Select Analysis_Actual__c,CUT_Actual__c,Deployment_Actual__c,Documentation_Actual__c,Review_Testing_Actual__c from Incident__c where Id=:updatedTimesheet.Incident__c];     
            update incdetail;    
        }  
      
    }
}