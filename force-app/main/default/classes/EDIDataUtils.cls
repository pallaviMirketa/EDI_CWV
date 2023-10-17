public class EDIDataUtils {
    
    public static final string formattedDate =  String.valueOf(DateTime.now().format('yyyyMMdd'));
    public static final string formattedTime =  String.valueOf(DateTime.now().format('HHmmss'));
    
    public static List<ElixirSuite__Claim__c> getClaimInfo(List<String> lstClaimId ) {
        try{
            List<ElixirSuite__Claim__c>  lstClaim = [SELECT Id, Name, ElixirSuite__Claim_Status__c,ElixirSuite__Payor__r.Id,ElixirSuite__Payor__c,
                                                     ElixirSuite__Payor__r.Name, ElixirSuite__Payor__r.ElixirSuite__Payer_Code__c, ElixirSuite__Insured_s_ID_Number__c, 
                                                     ElixirSuite__Patient_Name__c, ElixirSuite__Insured_s_Name__c,ElixirSuite__Account__r.Id,
                                                     ElixirSuite__Insured_DOB__c, ElixirSuite__Insured_Sex__c,CreatedDate,ElixirSuite__Total_Paid__c,
                                                     ElixirSuite__Patient_Relationship_to_Insured__c, ElixirSuite__Diagnosis_A__c, 
                                                     
                                                     (select Id, ElixirSuite__From_Date_Of_Service__c, ElixirSuite__To_Date_Of_Service__c,
                                                      ElixirSuite__Place_of_Service_Code_s__c, ElixirSuite__Procedure__r.Name,ElixirSuite__Procedure__r.ElixirSuite__Code_Description__c,
                                                      ElixirSuite__Modifier_1__c, ElixirSuite__Modifier_2__c, ElixirSuite__Modifier_3__c, ElixirSuite__Modifier_4__c,
                                                      ElixirSuite__Procedure_Charge__c FROM ElixirSuite__Claim_Line_Items__r)
                                                     FROM ElixirSuite__Claim__c WHERE Id IN: lstClaimId  WITH SECURITY_ENFORCED];
            System.debug('ElixirSuite__Payor__r : Data Utils'+ lstClaim[0].ElixirSuite__Payor__r.Id);
            return lstClaim;
        }catch(Exception e) {
            ElixirSuite__Exception_Log__c objExp = new ElixirSuite__Exception_Log__c();
            objExp.ElixirSuite__Stack_Trace_Long__c = 'EDI:GS-No Claims found for this claim.'+  lstClaimId +  e.getMessage();
            Insert objExp;
            return null;
        }  
    }
    Public static Organization getOrganizationInfo(){
        Organization objOrg = [SELECT Id, Name, Address, Phone, Fax FROM Organization];
        return objOrg;
    }
    public static ElixirSuite__CMS_1500_Claim_Generation__c getBillingProviderData(){
        ElixirSuite__CMS_1500_Claim_Generation__c objBillingProvider = [ SELECT ElixirSuite__Billing_Provider_NPI__c, ElixirSuite__Billing_Provider_Name__c, ElixirSuite__Billing_Provider_Address__c,
                                                                        ElixirSuite__Billing_Provider_City__c, ElixirSuite__Billing_Provider_State__c, ElixirSuite__Billing_Provider_Zipcode__c,
                                                                        ElixirSuite__Federal_Tax_Id_Number__c
                                                                        FROM ElixirSuite__CMS_1500_Claim_Generation__c WITH SECURITY_ENFORCED];
        return objBillingProvider;
    }
    
    public static ElixirSuite__Provider__c getProviderInfo(){
        ElixirSuite__Provider__c objProvider = [select Id,ElixirSuite__Provider_Taxonomy__c from ElixirSuite__Provider__c where  Name = 'COMMUNITY WELLNESS VENTURES, LLC' AND ElixirSuite__Provider_Taxonomy__c != null limit 1];
        return objProvider;
    } 
    
    
}