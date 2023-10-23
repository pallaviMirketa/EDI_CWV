@isTest
public class EDI837PSegmentISATest {
    @isTest
    static void testGenerateISASegment() {
		test.starttest();
        String isaSegment = EDI837PSegmentISA.generateISASegment();
        test.stoptest();
        System.assertNotEquals(null, isaSegment);
    }
}