public class EDI837PSegmentCLM {
    public static String generateCLMSegment(ElixirSuite__Claim__c objClaim){
        try{
            String CLM = 'CLM';
            CLM += '*' + objClaim.Id;
            CLM += '*' + objClaim.ElixirSuite__Total_Charge__c;
            CLM += '*';
            CLM += '*';
            CLM += '*' + EDIDataMappings.FacilityTypeCode;
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
            Insert objExp;
            return null;
        }
    }
}