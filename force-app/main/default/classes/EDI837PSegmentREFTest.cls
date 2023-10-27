@isTest
public class EDI837PSegmentREFTest {
    @isTest
    static void testGenerateREFSegment() {
        ElixirSuite__CMS_1500_Claim_Generation__c objcms = new ElixirSuite__CMS_1500_Claim_Generation__c(
            ElixirSuite__Federal_Tax_Id_Number__c = '1234'
        );
        insert objcms;
		test.starttest();
        String refaSegment = EDI837PSegmentREF.generateREFSegment(objcms);
        String refaSegment1 = EDI837PSegmentREF.generateREFSegment(null);
        test.stoptest();
        System.assertNotEquals(null, refaSegment);
    }
}