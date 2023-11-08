@istest
public class EDI837PSegmentSETest {
    @istest
    public static void generateSETest(){
        Test.startTest();
            String result = EDI837PSegmentSE.generatSESegment(10);
            String result1 = EDI837PSegmentSE.generatSESegment(null);
            Test.stopTest();
    }
}