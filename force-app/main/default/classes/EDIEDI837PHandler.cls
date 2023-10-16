public class EDIEDI837PHandler {
    public static String generateEDI837PMessage(List<ElixirSuite__Claim__c> claimList){
        Organization objOrgData = EDIDataUtils.getOrganizationInfo();
        String EDI837P = '';
        for(ElixirSuite__Claim__c claimData: claimList){
            EDI837P += EDI837PSegmentISA.generateISASegment(claimList,objOrgData);
            EDI837P += EDI837PGSSegment.generateGSSegment(claimData,objOrgData);
            EDI837P += EDI837SegmentST.generateSTSegment();
        }
        return EDI837P;
    }
}