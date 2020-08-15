@istest
private class timesheetmanagement_TM
{    
    static testmethod void timesheetmanagement_TM()    
    {  
        
        Incident__c newinc = new Incident__c();
        insert newinc;
        
        
        List<Timesheet_Entry__c> tsheetlist = new List<Timesheet_Entry__c>();
        
        Date currentdate = date.today();
        Date SelectedWeek = currentdate.toStartofWeek()+1; 
        
        Timesheet__c newtsheet  = new Timesheet__c(Incident__c=newinc.Id,Timesheet_for_Date__c=SelectedWeek,Week_Start_Date__c =SelectedWeek,Incident_Activity__c='Analysis');
        insert newtsheet;
        
        Timesheet__c newtsheet1  = new Timesheet__c(Timesheet_for_Date__c=SelectedWeek,Week_Start_Date__c =SelectedWeek,Other_Activity__c='System Study');
        insert newtsheet1;
        
        
        
        Timesheet_Entry__c tsheet1 = new Timesheet_Entry__c(Week_Start_Date__c=SelectedWeek,Mon__c=3,Tasks_Other__c='System Study',Comments__c='test1');
        Timesheet_Entry__c tsheet2 = new Timesheet_Entry__c(Week_Start_Date__c=SelectedWeek,Tue__c=3,Tasks_Other__c='Analysis',Comments__c='test2');
        Timesheet_Entry__c tsheet5 = new Timesheet_Entry__c(Week_Start_Date__c=SelectedWeek,Wed__c=3,Tasks_Other__c='Analysis',Comments__c='test3');
        Timesheet_Entry__c tsheet6 = new Timesheet_Entry__c(Week_Start_Date__c=SelectedWeek,Thu__c=3,Tasks_Other__c='Analysis',Comments__c='test4');
        Timesheet_Entry__c tsheet7 = new Timesheet_Entry__c(Week_Start_Date__c=SelectedWeek,Fri__c=3,Tasks_Other__c='Analysis',Comments__c='test5');
        Timesheet_Entry__c tsheet8 = new Timesheet_Entry__c(Week_Start_Date__c=SelectedWeek,Sat__c=3,Tasks_Other__c='Analysis',Comments__c='test6');
        Timesheet_Entry__c tsheet9 = new Timesheet_Entry__c(Week_Start_Date__c=SelectedWeek,Sun__c=3,Tasks_Other__c='Analysis',Comments__c='test7');
        Timesheet_Entry__c tsheet3 = new Timesheet_Entry__c(Week_Start_Date__c=SelectedWeek,Mon__c=3,Incident__c=newinc.Id,Tasks_for_Incident__c='Analysis');
      
        Timesheet_Entry__c tsheet4 = new Timesheet_Entry__c(Week_Start_Date__c=SelectedWeek,Tue__c=3,Incident__c=newinc.Id,Tasks_for_Incident__c='Coding');
        Timesheet_Entry__c tsheet10 = new Timesheet_Entry__c(Week_Start_Date__c=SelectedWeek,Wed__c=3,Incident__c=newinc.Id,Tasks_for_Incident__c='Unit Testing');
        Timesheet_Entry__c tsheet11 = new Timesheet_Entry__c(Week_Start_Date__c=SelectedWeek,Thu__c=3,Incident__c=newinc.Id,Tasks_for_Incident__c='Review & Peer Testing');
        Timesheet_Entry__c tsheet12 = new Timesheet_Entry__c(Week_Start_Date__c=SelectedWeek,Fri__c=3,Incident__c=newinc.Id,Tasks_for_Incident__c='Documentation');
        Timesheet_Entry__c tsheet13 = new Timesheet_Entry__c(Week_Start_Date__c=SelectedWeek,Sat__c=3,Incident__c=newinc.Id,Tasks_for_Incident__c='Deployment');
        Timesheet_Entry__c tsheet14 = new Timesheet_Entry__c(Week_Start_Date__c=SelectedWeek,Sun__c=3,Incident__c=newinc.Id,Tasks_for_Incident__c='Rework');
        
        tsheetlist.add(tsheet1);
        tsheetlist.add(tsheet2);
        tsheetlist.add(tsheet3);
        tsheetlist.add(tsheet4);
        tsheetlist.add(tsheet5);
        tsheetlist.add(tsheet6);
        tsheetlist.add(tsheet7);
        tsheetlist.add(tsheet8);
        tsheetlist.add(tsheet9);
        tsheetlist.add(tsheet10);
        tsheetlist.add(tsheet11);
        tsheetlist.add(tsheet12);
        tsheetlist.add(tsheet13);
        tsheetlist.add(tsheet14);
        
        
        insert tsheetlist;
        timesheetmanagement testtime = new timesheetmanagement();
        testtime.onloadfunction();
        testtime.getentrylist();
        testtime.getotherentrylist();
        testtime.getweekvalues();
        //testtime.addrow();
        //testtime.addrowothers();
        testtime.savetimesheet();
        System.currentPagereference().getParameters().put('rownumber','2');
        testtime.deltsheet();
        testtime.addrow();
        testtime.addrowothers();
        try{
        Timesheet_Entry__c tsheet99 = new Timesheet_Entry__c(Week_Start_Date__c=SelectedWeek,Tue__c=3,Incident__c=newinc.Id,Tasks_for_Incident__c='Coding');
        insert tsheet99;
        }
        catch (Exception e)
        {}
        
        try{
        Timesheet_Entry__c tsheet999 = new Timesheet_Entry__c(Week_Start_Date__c=SelectedWeek,Wed__c=3,Tasks_Other__c='Analysis',Comments__c='test3');
        insert tsheet999;
        }
        catch (Exception e)
        {}
       
    } 
}