@isTest
public class EDI837PSegmentPERTest{
    @isTest
    public static void generatePERSegmentTest(){
        Test.startTest();
        String strPER = EDI837PSegmentPER.generatePERSegment();
        Test.stopTest();
        System.assertEquals(true, strPER.contains('PER'));
    } 
}