public class EDIDataUtils {
    
    public static final string formattedTime =  String.valueOf(DateTime.now().format('HHmmss'));
    public static final string formattedTimeHHmm =  String.valueOf(DateTime.now().format('HHmm'));
    
    public static string getDateTimeFormat(DateTime dt){
        String formattedDate = dt.format('yyyyMMdd');
        return formattedDate;
    }    
    public static String analyze(String fieldValue, Integer maxLength) {
        //1. Null Check
        if((fieldValue != null ? fieldValue : '' ) == '' ){
            return '';
        }
        //Replace special characters
        fieldValue = fieldValue.replaceAll('[\\r\\n*~]+', ' ');
        
        //Truncating the fieldValue
        if (fieldValue.length() > maxLength) {
            if(maxLength != 0 ) fieldValue = fieldValue.substring(0, maxLength);
        }
        return fieldValue;
    }
    
    public static String getModifiers(String modifierValue){
        if(modifierValue == 'A'){
            return '1';
        }
        else if(modifierValue == 'B'){
            return '2';
        }
        else if(modifierValue == 'C'){
            return '3';
        }else if(modifierValue == 'D'){
            return '4';
        }
        return modifierValue;
    }
    public static List<ElixirSuite__Claim__c> getClaimInfo(set<id> claimId ) {
        try{
            List<ElixirSuite__Claim__c>  lstClaim = [SELECT Id, Name, ElixirSuite__Account__r.ElixirSuite__SSN__c,ElixirSuite__Claim_Status__c,ElixirSuite__Payor__r.Id,ElixirSuite__Payor__c,
                                                     ElixirSuite__Payor__r.Name, ElixirSuite__Payor__r.ElixirSuite__Payer_Code__c, ElixirSuite__Insured_s_ID_Number__c, 
                                                     ElixirSuite__Patient_Name__c, ElixirSuite__Insured_s_Name__c,ElixirSuite__Account__r.Id,
                                                     ElixirSuite__Insured_DOB__c, ElixirSuite__Insured_Sex__c,CreatedDate,ElixirSuite__Total_Paid__c,
                                                     ElixirSuite__Patient_Relationship_to_Insured__c, ElixirSuite__Diagnosis_A__c,ElixirSuite__Diagnosis_B__c,
                                                     ElixirSuite__Diagnosis_C__c, ElixirSuite__Diagnosis_D__c, ElixirSuite__Diagnosis_E__c ,ElixirSuite__Diagnosis_F__c,
                                                     ElixirSuite__Diagnosis_G__c, ElixirSuite__Diagnosis_H__c,ElixirSuite__Total_Charge__c ,Rendering_Provider_First__c,
                                                     Rendering_Provider_Last__c, Rendering_Provider_ID__c,Rendering_Provider_NPI__c,
                                                     
                                                     ElixirSuite__VOB_lookup__r.ElixirSuite__Insured_Last_Name__c, ElixirSuite__VOB_lookup__r.ElixirSuite__Insured_First_Name__c,
                                                     ElixirSuite__VOB_lookup__r.ElixirSuite__Insured_Middle_Name__c, ElixirSuite__VOB_lookup__r.ElixirSuite__Subscriber_Suffix__c,
                                                     ElixirSuite__VOB_lookup__r.ElixirSuite__Insured_SSN__c, ElixirSuite__VOB_lookup__r.ElixirSuite__Insured_Address__c,
                                                     ElixirSuite__VOB_lookup__r.ElixirSuite__Insured_City__c, ElixirSuite__VOB_lookup__r.ElixirSuite__Insured_State__c,
                                                     ElixirSuite__VOB_lookup__r.ElixirSuite__Insured_Zipcode__c,ElixirSuite__VOB_lookup__r.ElixirSuite__Patient_Relationship_With_Insured__c,
                                                     
                                                     (select Id, ElixirSuite__From_Date_Of_Service__c, ElixirSuite__CPT_HCPCS_Code__c,
                                                      ElixirSuite__Place_of_Service__c, ElixirSuite__Days_Units__c, ElixirSuite__Diagnosis_Pointer__c,
                                                      ElixirSuite__Modifier_1__c, ElixirSuite__Modifier_2__c,
                                                      ElixirSuite__Procedure_Charge__c FROM ElixirSuite__Claim_Line_Items__r)
                                                     FROM ElixirSuite__Claim__c WHERE Id IN: claimId  WITH SECURITY_ENFORCED
                                                    ];
            return lstClaim;
        }catch(Exception e) {
            ElixirSuite__Exception_Log__c objExp = new ElixirSuite__Exception_Log__c();
            objExp.ElixirSuite__Stack_Trace_Long__c = 'EDI:Error in fetching data from Query .'+  e.getMessage();
            Insert objExp;
            return null;
        }  
    }
    public static Organization getOrganizationInfo(){
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