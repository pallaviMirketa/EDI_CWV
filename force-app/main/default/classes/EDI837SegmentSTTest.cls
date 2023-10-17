@isTest
public class EDI837SegmentSTTest {
   @isTest
    public static void generateSTSegmentTest(){

        Test.startTest();
        String strST = EDI837SegmentST.generateSTSegment();
        Test.stopTest();
        System.assertEquals(true, strST.contains('ST'));
        System.assertNotEquals(null, strST, 'Generated segment should not be null');
    } 
}