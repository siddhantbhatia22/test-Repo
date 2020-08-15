/**
 * @File Name          : paginationEventController.cls
 * @Description        : 
 * @Author             : ChangeMeIn@UserSettingsUnder.SFDoc
 * @Group              : 
 * @Last Modified By   : ChangeMeIn@UserSettingsUnder.SFDoc
 * @Last Modified On   : 9/30/2019, 4:22:45 PM
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    9/30/2019   ChangeMeIn@UserSettingsUnder.SFDoc     Initial Version
**/
public with sharing class PaginationEventController {
   @AuraEnabled (cacheable=true)
    public static List<Account> retrieveAccounts(){
        return [SELECT Id, Name, Type, BillingCountry
                FROM Account
                LIMIT 1000];
    }
}