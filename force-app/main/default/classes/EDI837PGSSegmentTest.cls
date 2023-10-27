@isTest
public class EDI837PGSSegmentTest {
    @isTest
    static void testGenerateGSSegment() {
        test.starttest();
        String gsSegment = EDI837PGSSegment.generateGSSegment();
        test.stoptest();
    }
    
}