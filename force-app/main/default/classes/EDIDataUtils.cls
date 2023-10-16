public class EDIDataUtils {
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
        public static final string formattedDate =  String.valueOf(DateTime.now().format('yyyyMMdd'));
        public static final string formattedTime =  String.valueOf(DateTime.now().format('HHmmss'));
        
    }