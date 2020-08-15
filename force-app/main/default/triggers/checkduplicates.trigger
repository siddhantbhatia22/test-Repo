trigger checkduplicates on Timesheet_Entry__c (before insert) 
{
    for (Timesheet_Entry__c newentry:System.Trigger.new) 
    {
        List<Timesheet_Entry__c> existingentries = [select Incident__c, Tasks_for_Incident__c,Tasks_Other__c,Comments__c from Timesheet_Entry__c where Week_Start_Date__c = :newentry.Week_Start_Date__c and OwnerId=:newentry.OwnerId];
        
        for ( Integer i =0;i< existingentries.size(); i++)
        {
            if (existingentries[i].Incident__c == newentry.Incident__c && existingentries[i].Tasks_for_Incident__c ==  newentry.Tasks_for_Incident__c && existingentries[i].Tasks_Other__c == NULL && existingentries[i].Comments__c == NULL)
            {
                newentry.addError('Duplicate entry found. There already exists an entry for the same Incident and IncidentTask combination. Please update the old one');
                break;
            }
            if (existingentries[i].Tasks_Other__c == newentry.Tasks_Other__c && existingentries[i].Comments__c ==  newentry.Comments__c && existingentries[i].Incident__c == NULL && existingentries[i].Tasks_for_Incident__c == NULL)
            {
                newentry.addError('Duplicate entry found. There already exists an entry for the same OtherActivity and Comment combination. Please update the old one');
                break;
            }
        }        
    }
}