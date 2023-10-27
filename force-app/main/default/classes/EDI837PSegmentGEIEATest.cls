@isTest
public class EDI837PSegmentGEIEATest {
    @isTest
    public static void generateGEIEATest(){
        
        Test.startTest();
        String result = EDI837PSegmentGEIEA.genrateGEAndIEASegments();
        String result1 = EDI837PSegmentGEIEA.generateGESegment();
        String result2 = EDI837PSegmentGEIEA.generateIEASegment();
        Test.stopTest();
        System.assertEquals(true, result1.contains('GE'));
        System.assertEquals(true, result2.contains('IEA'));
    }   
}