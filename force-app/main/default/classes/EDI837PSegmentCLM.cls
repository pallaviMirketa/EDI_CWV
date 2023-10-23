public class EDI837PSegmentCLM {
    public static String generateCLMSegment(ElixirSuite__Claim__c objClaim){
        try{
            List<ElixirSuite__Claim_Line_Items__c> claimLineItem = objClaim.ElixirSuite__Claim_Line_Items__r;
            String CLM = 'CLM';
            CLM += '*' + objClaim.Name;
            CLM += '*' + EDIDataUtils.analyze(String.valueOf(objClaim.ElixirSuite__Total_Charge__c));
            CLM += '*';
            CLM += '*';
            CLM += '*' + EDIDataUtils.analyze(String.valueOf(claimLineItem[0].ElixirSuite__Place_of_Service__c));
            CLM += ':' + EDIDataMappings.FacilityCodeQualifier;
            CLM += ':' + EDIDataMappings.ClaimFrequencyTypeCode;
            CLM += '*' + EDIDataMappings.ProviderorSupplierSignatureIndicator;
            CLM += '*' + EDIDataMappings.AssignmentorPlanParticipationCode;
            CLM += '*' + EDIDataMappings.BenefitsAssignmentCertificationIndicator;
            CLM += '*' + EDIDataMappings.ReleaseofInformationCode;
            CLM += '~' ;
            
            return CLM + '\n';
        }
        catch(Exception e){
            ElixirSuite__Exception_Log__c objExp = new ElixirSuite__Exception_Log__c();
            objExp.ElixirSuite__Stack_Trace_Long__c = 'EDI837p: Error occurred CLM Segment.' +  e.getMessage();
            system.debug('ex--'+ e.getMessage());
            Insert objExp;
            return null;
        }
    }
}