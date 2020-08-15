public class timesheetmanagement 
{    


public String weekselection{get; set;}
public String incselection{get; set;}
Public List<Timesheet_Entry__c> tentries;
Public List<Timesheet_Entry__c> otherentries;
Public Date SelectedWeek;

    public Id oppId {get; set;}

Public void deltsheet()
{
    String rownumber = System.currentPagereference().getParameters().get('rownumber');
    Decimal rownumb = Decimal.Valueof(rownumber);
    Integer rowno = rownumb.IntValue();
    String tentryid = System.currentPagereference().getParameters().get('tentryid');
    if (rownumber != '')
        tentries.remove(rowno);
}

public void onloadfunction()
{
    if ( weekselection != null)
    {
        SelectedWeek = date.valueOf(weekselection);  
        system.debug('The Selected Week is'+SelectedWeek);
        tentries = [select Id,Incident__c,Displayfields__c,Tasks_for_Incident__c,Effort__c,Week_Start_Date__c,Mon__c,Tue__c,Wed__c,Thu__c,Fri__c,Sat__c,Sun__c from Timesheet_Entry__c where Week_Start_Date__c=:SelectedWeek and Incident__c!=NULL and OwnerId=:Userinfo.getUserId()];
        otherentries = [select Comments__c,Displayfields__c,Tasks_Other__c,Effort__c,Week_Start_Date__c,Mon__c,Tue__c,Wed__c,Thu__c,Fri__c,Sat__c,Sun__c from Timesheet_Entry__c where Week_Start_Date__c=:SelectedWeek and Incident__c=NULL and OwnerId=:Userinfo.getUserId()];
        
    } 
    else
    {
        Date currentdate = date.today();
        SelectedWeek = currentdate.toStartofWeek()+1; 
        system.debug('The Selected Week is'+SelectedWeek);
        tentries = [select Id,Incident__c,Displayfields__c,Tasks_for_Incident__c,Effort__c,Week_Start_Date__c,Mon__c,Tue__c,Wed__c,Thu__c,Fri__c,Sat__c,Sun__c from Timesheet_Entry__c where Week_Start_Date__c=:SelectedWeek and Incident__c!=NULL  and OwnerId=:Userinfo.getUserId()];
        otherentries = [select Comments__c,Displayfields__c,Tasks_Other__c,Effort__c,Week_Start_Date__c,Mon__c,Tue__c,Wed__c,Thu__c,Fri__c,Sat__c,Sun__c from Timesheet_Entry__c where Week_Start_Date__c=:SelectedWeek and Incident__c=NULL  and OwnerId=:Userinfo.getUserId()];
        
    }    
}       
public List<Timesheet_Entry__c> getentrylist()
{
    if (tentries!=NULL && tentries.size()>0) 
       return tentries;
    else
        return null;    
}
public List<Timesheet_Entry__c> getotherentrylist()
{
    if (otherentries!=NULL && otherentries.size()>0) 
            return otherentries;
    else
        return null;    
}  
         
public List<SelectOption> getweekvalues()
{
  List<SelectOption> options = new List<SelectOption>();
  Date currentdate = date.today();
  Date currentweekstart = currentdate.toStartofWeek()+1;
  Date currentweekend = currentweekstart +6;  
  Date oldestweekstart = currentweekstart - 7;
  Date oldestweekend; 
  options.add(new SelectOption(currentweekstart+'',currentweekstart.format()+'--to-- '+currentweekend.format()));
  for (Integer i =0; i< 3 ; i++)
  {
     oldestweekend = oldestweekstart+6;
     options.add(new SelectOption(oldestweekstart+'',oldestweekstart.format()+'--to--'+oldestweekend.format())); 
     oldestweekstart -=7;
  }   
  
  return options;
}
public void addrow()
{
    system.debug('The Selected Week is'+SelectedWeek);
    Timesheet_Entry__c newentry = new Timesheet_Entry__c(Week_Start_Date__c=SelectedWeek,OwnerId=Userinfo.getUserId() );
    tentries.add(newentry);
} 
public void addrowothers()
{
    system.debug('The Selected Week is'+SelectedWeek);
    Timesheet_Entry__c newentry = new Timesheet_Entry__c(Week_Start_Date__c=SelectedWeek,OwnerId=Userinfo.getUserId() );
    otherentries.add(newentry);
} 
Public Pagereference canceltimesheet()
{
    Pagereference p = Page.timesheetmanagement; 
    return p;
}     
public Pagereference savetimesheet()
{
    try
    {
    List<Timesheet__c> existingtsheet = [Select Comments__c,Id,Timesheet_for_Date__c,Incident_Activity__c,Incident__c,Other_Activity__c from Timesheet__c where Week_Start_Date__c =:SelectedWeek and OwnerId=:Userinfo.getUserId()];
    List<Timesheet__c> tsheet = new List<Timesheet__c>();
    Boolean flag=false;
    upsert tentries;
    upsert otherentries;
    if(tentries!=NULL)
    {
        for (Integer i=0;i<tentries.size();i++)
        {
            if(tentries[i].Mon__c != NULL)
             {
                 if(existingtsheet.size() > 0)
                 {
                     for(Integer j=0;j<existingtsheet.size();j++)
                     {
                         if(existingtsheet[j].Timesheet_for_Date__c == tentries[i].Week_Start_Date__c && existingtsheet[j].Incident_Activity__c == tentries[i].Tasks_for_Incident__c && existingtsheet[j].Incident__c == tentries[i].Incident__c )
                         {
                             existingtsheet[j].Effort_in_hours__c = tentries[i].Mon__c;                             
                             flag = true;
                             break;
                         }
                         else
                             flag = false;
                     }
                 }
                 
                 if (flag == false)
                 {          
                     Timesheet__c newtsheet = new Timesheet__c(Week_Start_Date__c = SelectedWeek,Timesheet_Entry__c=tentries[i].Id,Timesheet_for_Date__c = tentries[i].Week_Start_Date__c,Effort_in_hours__c = tentries[i].Mon__c,Incident__c = tentries[i].Incident__c,Incident_Activity__c = tentries[i].Tasks_for_Incident__c);
                     tsheet.add(newtsheet);
                 }   
             }
             if(tentries[i].Tue__c != NULL)
             {
                 if(existingtsheet.size() > 0)
                 {
                     for(Integer j=0;j<existingtsheet.size();j++)
                     {
                         if(existingtsheet[j].Timesheet_for_Date__c == tentries[i].Week_Start_Date__c+1 && existingtsheet[j].Incident_Activity__c == tentries[i].Tasks_for_Incident__c && existingtsheet[j].Incident__c == tentries[i].Incident__c )
                         {
                             existingtsheet[j].Effort_in_hours__c = tentries[i].Tue__c;                             
                             flag = true;
                             break;
                         }
                         else
                             flag = false;
                     }
                 }
                 
                 if (flag == false)
                 {          
                     Timesheet__c newtsheet = new Timesheet__c(Week_Start_Date__c = SelectedWeek,Timesheet_Entry__c=tentries[i].Id,Timesheet_for_Date__c = tentries[i].Week_Start_Date__c+1,Effort_in_hours__c = tentries[i].Tue__c,Incident__c = tentries[i].Incident__c,Incident_Activity__c = tentries[i].Tasks_for_Incident__c);
                     tsheet.add(newtsheet);
                 }   
             }
             if(tentries[i].Wed__c != NULL)
             {
                 if(existingtsheet.size() > 0)
                 {
                     for(Integer j=0;j<existingtsheet.size();j++)
                     {
                         if(existingtsheet[j].Timesheet_for_Date__c == tentries[i].Week_Start_Date__c+2 && existingtsheet[j].Incident_Activity__c == tentries[i].Tasks_for_Incident__c && existingtsheet[j].Incident__c == tentries[i].Incident__c )
                         {
                             existingtsheet[j].Effort_in_hours__c = tentries[i].Wed__c;                             
                             flag = true;
                             break;
                         }
                         else
                             flag = false;
                     }
                 }
                 
                 if (flag == false)
                 {          
                     Timesheet__c newtsheet = new Timesheet__c(Week_Start_Date__c = SelectedWeek,Timesheet_Entry__c=tentries[i].Id,Timesheet_for_Date__c = tentries[i].Week_Start_Date__c+2,Effort_in_hours__c = tentries[i].Wed__c,Incident__c = tentries[i].Incident__c,Incident_Activity__c = tentries[i].Tasks_for_Incident__c);
                     tsheet.add(newtsheet);
                 }   
             }
             if(tentries[i].Thu__c != NULL)
             {
                 if(existingtsheet.size() > 0)
                 {
                     for(Integer j=0;j<existingtsheet.size();j++)
                     {
                         if(existingtsheet[j].Timesheet_for_Date__c == tentries[i].Week_Start_Date__c+3 && existingtsheet[j].Incident_Activity__c == tentries[i].Tasks_for_Incident__c && existingtsheet[j].Incident__c == tentries[i].Incident__c )
                         {
                             existingtsheet[j].Effort_in_hours__c = tentries[i].Thu__c;                             
                             flag = true;
                             break;
                         }
                         else
                             flag = false;
                     }
                 }
                 
                 if (flag == false)
                 {          
                     Timesheet__c newtsheet = new Timesheet__c(Week_Start_Date__c = SelectedWeek,Timesheet_Entry__c=tentries[i].Id,Timesheet_for_Date__c = tentries[i].Week_Start_Date__c+3,Effort_in_hours__c = tentries[i].Thu__c,Incident__c = tentries[i].Incident__c,Incident_Activity__c = tentries[i].Tasks_for_Incident__c);
                     tsheet.add(newtsheet);
                 }   
             }
             if(tentries[i].Fri__c != NULL)
             {
                 if(existingtsheet.size() > 0)
                 {
                     for(Integer j=0;j<existingtsheet.size();j++)
                     {
                         if(existingtsheet[j].Timesheet_for_Date__c == tentries[i].Week_Start_Date__c+4 && existingtsheet[j].Incident_Activity__c == tentries[i].Tasks_for_Incident__c && existingtsheet[j].Incident__c == tentries[i].Incident__c )
                         {
                             existingtsheet[j].Effort_in_hours__c = tentries[i].Fri__c;                             
                             flag = true;
                             break;
                         }
                         else
                             flag = false;
                     }
                 }
                 
                 if (flag == false)
                 {          
                     Timesheet__c newtsheet = new Timesheet__c(Week_Start_Date__c = SelectedWeek,Timesheet_Entry__c=tentries[i].Id,Timesheet_for_Date__c = tentries[i].Week_Start_Date__c+4,Effort_in_hours__c = tentries[i].Fri__c,Incident__c = tentries[i].Incident__c,Incident_Activity__c = tentries[i].Tasks_for_Incident__c);
                     tsheet.add(newtsheet);
                 }   
             }
             if(tentries[i].Sat__c != NULL)
             {
                 if(existingtsheet.size() > 0)
                 {
                     for(Integer j=0;j<existingtsheet.size();j++)
                     {
                         if(existingtsheet[j].Timesheet_for_Date__c == tentries[i].Week_Start_Date__c+5 && existingtsheet[j].Incident_Activity__c == tentries[i].Tasks_for_Incident__c && existingtsheet[j].Incident__c == tentries[i].Incident__c )
                         {
                             existingtsheet[j].Effort_in_hours__c = tentries[i].Sat__c;                             
                             flag = true;
                             break;
                         }
                         else
                             flag = false;
                     }
                 }
                 
                 if (flag == false)
                 {          
                     Timesheet__c newtsheet = new Timesheet__c(Week_Start_Date__c = SelectedWeek,Timesheet_Entry__c=tentries[i].Id,Timesheet_for_Date__c = tentries[i].Week_Start_Date__c+5,Effort_in_hours__c = tentries[i].Sat__c,Incident__c = tentries[i].Incident__c,Incident_Activity__c = tentries[i].Tasks_for_Incident__c);
                     tsheet.add(newtsheet);
                 }   
             }
             if(tentries[i].Sun__c != NULL)
             {
                 if(existingtsheet.size() > 0)
                 {
                     for(Integer j=0;j<existingtsheet.size();j++)
                     {
                         if(existingtsheet[j].Timesheet_for_Date__c == tentries[i].Week_Start_Date__c+6 && existingtsheet[j].Incident_Activity__c == tentries[i].Tasks_for_Incident__c && existingtsheet[j].Incident__c == tentries[i].Incident__c )
                         {
                             existingtsheet[j].Effort_in_hours__c = tentries[i].Sun__c;                             
                             flag = true;
                             break;
                         }
                         else
                             flag = false;
                     }
                 }
                 
                 if (flag == false)
                 {          
                     Timesheet__c newtsheet = new Timesheet__c(Week_Start_Date__c = SelectedWeek,Timesheet_Entry__c=tentries[i].Id,Timesheet_for_Date__c = tentries[i].Week_Start_Date__c+6,Effort_in_hours__c = tentries[i].Sun__c,Incident__c = tentries[i].Incident__c,Incident_Activity__c = tentries[i].Tasks_for_Incident__c);
                     tsheet.add(newtsheet);
                 }   
             }
                           
        }
          
        
                  
            
    }        
    
    
    
    /******* Other Activity Summary *********/
    
    
    if(otherentries!=NULL)
    {
    for (Integer i=0;i<otherentries.size();i++)
        {
            if(otherentries[i].Mon__c != NULL)
             {
                 if(existingtsheet.size() > 0)
                 {
                     for(Integer j=0;j<existingtsheet.size();j++)
                     {
                         if(existingtsheet[j].Timesheet_for_Date__c == otherentries[i].Week_Start_Date__c && existingtsheet[j].Other_Activity__c == otherentries[i].Tasks_Other__c && existingtsheet[j].Comments__c == otherentries[i].Comments__c )
                         {
                             existingtsheet[j].Effort_in_hours__c = otherentries[i].Mon__c;                             
                             flag = true;
                             break;
                         }
                         else
                             flag = false;
                     }
                 }
                 
                 if (flag == false)
                 {          
                     Timesheet__c newtsheet = new Timesheet__c(Week_Start_Date__c = SelectedWeek,Timesheet_Entry__c=otherentries[i].Id,Timesheet_for_Date__c = otherentries[i].Week_Start_Date__c,Effort_in_hours__c = otherentries[i].Mon__c,Comments__c = otherentries[i].Comments__c,Other_Activity__c = otherentries[i].Tasks_Other__c);
                     tsheet.add(newtsheet);
                 }   
             }
             
            if(otherentries[i].Tue__c != NULL)
             {
                 if(existingtsheet.size() > 0)
                 {
                     for(Integer j=0;j<existingtsheet.size();j++)
                     {
                         if(existingtsheet[j].Timesheet_for_Date__c == otherentries[i].Week_Start_Date__c+1 && existingtsheet[j].Other_Activity__c == otherentries[i].Tasks_Other__c && existingtsheet[j].Comments__c == otherentries[i].Comments__c )
                         {
                             existingtsheet[j].Effort_in_hours__c = otherentries[i].Tue__c;                             
                             flag = true;
                             break;
                         }
                         else
                             flag = false;
                     }
                 }
                 
                 if (flag == false)
                 {          
                     Timesheet__c newtsheet = new Timesheet__c(Week_Start_Date__c = SelectedWeek,Timesheet_Entry__c=otherentries[i].Id,Timesheet_for_Date__c = otherentries[i].Week_Start_Date__c+1,Effort_in_hours__c = otherentries[i].Tue__c,Comments__c = otherentries[i].Comments__c,Other_Activity__c = otherentries[i].Tasks_Other__c);
                     tsheet.add(newtsheet);
                 }   
             }
             if(otherentries[i].Wed__c != NULL)
             {
                 if(existingtsheet.size() > 0)
                 {
                     for(Integer j=0;j<existingtsheet.size();j++)
                     {
                         if(existingtsheet[j].Timesheet_for_Date__c == otherentries[i].Week_Start_Date__c+2 && existingtsheet[j].Other_Activity__c == otherentries[i].Tasks_Other__c && existingtsheet[j].Comments__c == otherentries[i].Comments__c )
                         {
                             existingtsheet[j].Effort_in_hours__c = otherentries[i].Wed__c;                             
                             flag = true;
                             break;
                         }
                         else
                             flag = false;
                     }
                 }
                 
                 if (flag == false)
                 {          
                     Timesheet__c newtsheet = new Timesheet__c(Week_Start_Date__c = SelectedWeek,Timesheet_Entry__c=otherentries[i].Id,Timesheet_for_Date__c = otherentries[i].Week_Start_Date__c+2,Effort_in_hours__c = otherentries[i].Wed__c,Comments__c = otherentries[i].Comments__c,Other_Activity__c = otherentries[i].Tasks_Other__c);
                     tsheet.add(newtsheet);
                 }   
             }
             if(otherentries[i].Thu__c != NULL)
             {
                 if(existingtsheet.size() > 0)
                 {
                     for(Integer j=0;j<existingtsheet.size();j++)
                     {
                         if(existingtsheet[j].Timesheet_for_Date__c == otherentries[i].Week_Start_Date__c+3 && existingtsheet[j].Other_Activity__c == otherentries[i].Tasks_Other__c && existingtsheet[j].Comments__c == otherentries[i].Comments__c )
                         {
                             existingtsheet[j].Effort_in_hours__c = otherentries[i].Thu__c;                             
                             flag = true;
                             break;
                         }
                         else
                             flag = false;
                     }
                 }
                 
                 if (flag == false)
                 {          
                     Timesheet__c newtsheet = new Timesheet__c(Week_Start_Date__c = SelectedWeek,Timesheet_Entry__c=otherentries[i].Id,Timesheet_for_Date__c = otherentries[i].Week_Start_Date__c+3,Effort_in_hours__c = otherentries[i].Thu__c,Comments__c = otherentries[i].Comments__c,Other_Activity__c = otherentries[i].Tasks_Other__c);
                     tsheet.add(newtsheet);
                 }   
             }
             if(otherentries[i].Fri__c != NULL)
             {
                 if(existingtsheet.size() > 0)
                 {
                     for(Integer j=0;j<existingtsheet.size();j++)
                     {
                         if(existingtsheet[j].Timesheet_for_Date__c == otherentries[i].Week_Start_Date__c+4 && existingtsheet[j].Other_Activity__c == otherentries[i].Tasks_Other__c && existingtsheet[j].Comments__c == otherentries[i].Comments__c )
                         {
                             existingtsheet[j].Effort_in_hours__c = otherentries[i].Fri__c;                             
                             flag = true;
                             break;
                         }
                         else
                             flag = false;
                     }
                 }
                 
                 if (flag == false)
                 {          
                     Timesheet__c newtsheet = new Timesheet__c(Week_Start_Date__c = SelectedWeek,Timesheet_Entry__c=otherentries[i].Id,Timesheet_for_Date__c = otherentries[i].Week_Start_Date__c+4,Effort_in_hours__c = otherentries[i].Fri__c,Comments__c = otherentries[i].Comments__c,Other_Activity__c = otherentries[i].Tasks_Other__c);
                     tsheet.add(newtsheet);
                 }   
             }
             if(otherentries[i].Sat__c != NULL)
             {
                 if(existingtsheet.size() > 0)
                 {
                     for(Integer j=0;j<existingtsheet.size();j++)
                     {
                         if(existingtsheet[j].Timesheet_for_Date__c == otherentries[i].Week_Start_Date__c+5 && existingtsheet[j].Other_Activity__c == otherentries[i].Tasks_Other__c && existingtsheet[j].Comments__c == otherentries[i].Comments__c )
                         {
                             existingtsheet[j].Effort_in_hours__c = otherentries[i].Sat__c;                             
                             flag = true;
                             break;
                         }
                         else
                             flag = false;
                     }
                 }
                 
                 if (flag == false)
                 {          
                     Timesheet__c newtsheet = new Timesheet__c(Week_Start_Date__c = SelectedWeek,Timesheet_Entry__c=otherentries[i].Id,Timesheet_for_Date__c = otherentries[i].Week_Start_Date__c+5,Effort_in_hours__c = otherentries[i].Sat__c,Comments__c = otherentries[i].Comments__c,Other_Activity__c = otherentries[i].Tasks_Other__c);
                     tsheet.add(newtsheet);
                 }   
             }
            if(otherentries[i].Sun__c != NULL)
             {
                 if(existingtsheet.size() > 0)
                 {
                     for(Integer j=0;j<existingtsheet.size();j++)
                     {
                         if(existingtsheet[j].Timesheet_for_Date__c == otherentries[i].Week_Start_Date__c+6 && existingtsheet[j].Other_Activity__c == otherentries[i].Tasks_Other__c && existingtsheet[j].Comments__c == otherentries[i].Comments__c )
                         {
                             existingtsheet[j].Effort_in_hours__c = otherentries[i].Sun__c;                             
                             flag = true;
                             break;
                         }
                         else
                             flag = false;
                     }
                 }
                 
                 if (flag == false)
                 {          
                     Timesheet__c newtsheet = new Timesheet__c(Week_Start_Date__c = SelectedWeek,Timesheet_Entry__c=otherentries[i].Id,Timesheet_for_Date__c = otherentries[i].Week_Start_Date__c+6,Effort_in_hours__c = otherentries[i].Sun__c,Comments__c = otherentries[i].Comments__c,Other_Activity__c = otherentries[i].Tasks_Other__c);
                     tsheet.add(newtsheet);
                 }   
             }
                           
        }                                    
        
    }
        if(tsheet.size()>0)
            insert tsheet;
        if(existingtsheet.size() >0)
            update existingtsheet;
    Pagereference p = Page.timesheetmanagement; 
    return p;   
    }
    catch(Exception e){ return null;}
    
}
}