@isTest
public class EDI837SegmentSBRTest {
    @isTest
    public static void generateSBRSegmentTest(){
       Test.startTest();
        String strSbr = EDI837PSegmentSBR.generateSBRSegment();
        Test.stopTest();
        System.assertEquals(true, strSbr.contains('SBR'));
    }
}