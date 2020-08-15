@istest
private class incidentmanagement_TM
{
    static testmethod void incidentmanagement_TM()
    {
        List<Incident__c> testlist = new List<Incident__c>();
        Incident__c testrec1 = new Incident__c();
        Incident__c testrec2 = new Incident__c();
        Incident__c testrec3 = new Incident__c();
        Incident__c testrec4 = new Incident__c();
        Incident__c testrec5 = new Incident__c();
        Incident__c testrec6 = new Incident__c();
        Incident__c testrec7 = new Incident__c();
        Incident__c testrec8 = new Incident__c();
        Incident__c testrec9 = new Incident__c();
        Incident__c testrec10 = new Incident__c();
        Incident__c testrec11 = new Incident__c();
        
        testlist.add(testrec1);      
        testlist.add(testrec2);
        testlist.add(testrec3);
        testlist.add(testrec4);
        testlist.add(testrec5);
        testlist.add(testrec6);
        testlist.add(testrec7);
        testlist.add(testrec8);
        testlist.add(testrec9);
        testlist.add(testrec10);
        testlist.add(testrec11);
        
        insert testlist;
        
        List<Timesheet__c> testlisttsheet = new List<Timesheet__c>();
        
        Timesheet__c tsheet1 = new Timesheet__c(Incident__c=testlist[0].Id,Incident_Activity__c='Analysis',Effort_in_hours__c=3);
        Timesheet__c tsheet2 = new Timesheet__c(Incident__c=testlist[0].Id,Incident_Activity__c='CUT Effort',Effort_in_hours__c=3);
        Timesheet__c tsheet3 = new Timesheet__c(Incident__c=testlist[0].Id,Incident_Activity__c='Deployment Effort',Effort_in_hours__c=3);
        Timesheet__c tsheet4 = new Timesheet__c(Incident__c=testlist[0].Id,Incident_Activity__c='Documentation',Effort_in_hours__c=3);
        Timesheet__c tsheet5 = new Timesheet__c(Incident__c=testlist[0].Id,Incident_Activity__c='Review Effort',Effort_in_hours__c=3);
        
        testlisttsheet.add(tsheet1);
        testlisttsheet.add(tsheet2);
        testlisttsheet.add(tsheet3);
        testlisttsheet.add(tsheet4);
        testlisttsheet.add(tsheet5);
        
        insert testlisttsheet;
        
        List<Incident__c> testlist1 =[Select ID from Incident__c limit 20];
        ApexPages.StandardSetController stdController = new ApexPages.StandardSetController(testlist1);
        incidentmanagement tinc = new incidentmanagement(stdController);
        System.currentPageReference().getParameters().put('incid',testlist[0].Id);        
        tinc.queryincident();
        tinc.getincdetail();
        tinc.saveinc();  
        tinc.searchincident();
        tinc.getincsearchresults();
        tinc.getInciSearch();
        
    }
}