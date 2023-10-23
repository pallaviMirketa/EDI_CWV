@isTest
public class EDI837PSegmentBHTTest {
  @isTest
    public static void generateBHTSegmentTest(){
        Test.startTest();
        String strBHT = EDI837PSegmentBHT.generateBHTSegment();
        Test.stopTest();
        System.assertEquals(true, strBHT.contains('BHT'));
    } 
}