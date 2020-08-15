trigger UpdateActualEfforts on Incident__c (before update) 
{
  for (Incident__c updatedinc:System.Trigger.new) 
    {
        updatedinc.Analysis_Actual__c = 0;
        updatedinc.CUT_Actual__c =0;
        updatedinc.Deployment_Actual__c = 0;
        updatedinc.Documentation_Actual__c = 0;
        updatedinc.Review_Testing_Actual__c = 0;
        updatedinc.Unit_Testing_Actual_hrs__c = 0;
        updatedinc.Rework_Actual_hrs__c = 0;
        
        
        List<Timesheet__c> tsheetentries = [select Incident_Activity__c,Effort_in_hours__c,Incident__c from Timesheet__c where Incident__c =:updatedinc.Id ];
        system.debug('Tsheet entries are'+tsheetentries.size());
        if( tsheetentries.size() > 0)
        {
            system.debug('Tsheet entries are'+tsheetentries.size());
            for(Integer i=0;i<tsheetentries.size();i++)
            {
                if (tsheetentries[i].Incident_Activity__c == 'Analysis')
                    updatedinc.Analysis_Actual__c+= tsheetentries[i].Effort_in_hours__c;
                if (tsheetentries[i].Incident_Activity__c == 'Coding')
                    updatedinc.CUT_Actual__c+= tsheetentries[i].Effort_in_hours__c;
                if (tsheetentries[i].Incident_Activity__c == 'Deployment')
                    updatedinc.Deployment_Actual__c+= tsheetentries[i].Effort_in_hours__c;
                if (tsheetentries[i].Incident_Activity__c == 'Documentation')
                    updatedinc.Documentation_Actual__c+= tsheetentries[i].Effort_in_hours__c;
                if (tsheetentries[i].Incident_Activity__c == 'Review & Peer Testing')
                    updatedinc.Review_Testing_Actual__c+= tsheetentries[i].Effort_in_hours__c;
                if (tsheetentries[i].Incident_Activity__c == 'Unit Testing')
                    updatedinc.Unit_Testing_Actual_hrs__c+= tsheetentries[i].Effort_in_hours__c;
                if (tsheetentries[i].Incident_Activity__c == 'Rework')
                    updatedinc.Rework_Actual_hrs__c+= tsheetentries[i].Effort_in_hours__c;
            }
                        
        }    
        
    }                 
    

}