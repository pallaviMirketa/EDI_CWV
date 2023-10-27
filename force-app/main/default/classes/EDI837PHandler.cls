public class EDI837PHandler {
    public static String generateEDI837PMessage(Set<id> claimId){
        List<ElixirSuite__Claim__c> claimList=EDIDataUtils.getClaimInfo(claimId);//query insurance,Claim Line Items here only. No need for line 6 and 7
        Organization objOrgData = EDIDataUtils.getOrganizationInfo();
        ElixirSuite__Provider__c objProvider = EDIDataUtils.getProviderInfo();
        ElixirSuite__CMS_1500_Claim_Generation__c objProviderMetaData = EDIDataUtils.getBillingProviderData();
        Map<String,String> NM1N3N4Data = EDI837PSegmentNM1N3N4.generateNM1N3N4Segment(objOrgData, objProviderMetaData, claimList[0]);
        String EDI837P = '';
        try{
            //Generate ISA,GS,ST and BHT segments before loop.
            EDI837P += EDI837PSegmentISA.generateISASegment();
            EDI837P += EDI837PGSSegment.generateGSSegment();
            EDI837P += EDI837SegmentST.generateSTSegment();
            EDI837P += EDI837PSegmentBHT.generateBHTSegment();
            EDI837P += NM1N3N4Data.get('41');
            EDI837P += EDI837PSegmentPER.generatePERSegment();
            EDI837P += NM1N3N4Data.get('40');
            
            for(ElixirSuite__Claim__c claimData: claimList){
                
                NM1N3N4Data = EDI837PSegmentNM1N3N4.generateNM1N3N4Segment(objOrgData, objProviderMetaData, claimData);
                EDI837P += EDI837PSegmentHL.generateHLSegment();
                EDI837P += EDI837PSegmentPRV.generatePRVSegment(objProvider);
                EDI837P += NM1N3N4Data.get('85');
                EDI837P += EDI837PSegmentREF.generateREFSegment(objProviderMetaData);
                EDI837P += EDI837PSegmentPER.generatePERSegment();
                EDI837P += EDI837PSegmentSBRHL.generateSBRHLSegment();
                EDI837P += EDI837PSegmentSBR.generateSBRSegment();
                EDI837P += NM1N3N4Data.get('IL');
                EDI837P += EDI837PSegmentDMG.generateDMGSegment(claimData);
                EDI837P += NM1N3N4Data.get('PR');
                EDI837P += EDI837PSegmentCLM.generateCLMSegment(claimData);
                EDI837P += EDI837PSegmentHI.generateHISegment(claimData);
                EDI837P += EDI837PSegmentLXSV1DTP.generateLXSV1DTPSegment(claimData);
                EDI837P += NM1N3N4Data.get('82');
                
                NM1N3N4Data.clear();
            }
            
            Integer segmentCount = EDI837P.split('\n',-1).size() - 1;
            
            EDI837P += EDI837PSegmentSE.generatSESegment(segmentCount);
            EDI837P += EDI837PSegmentGEIEA.genrateGEAndIEASegments();
            return EDI837P;
            
        } catch (Exception e) { 
            
            ElixirSuite__Exception_Log__c objExp = new ElixirSuite__Exception_Log__c();
            objExp.ElixirSuite__Stack_Trace_Long__c = 'Exception occurred in EDI generation:'+ e.getMessage();
            Insert objExp;
            return EDI837P;
        }
    }
}