@isTest
public class EDI837PSegmentPERTest{
    @isTest
    public static void generatePERSegmentTest(){
        Test.startTest();
        String strPER = EDI837PSegmentPER.generatePERSegment();
        Test.stopTest();
        System.assertEquals(true, strPER.contains('PER'));
    } 
     @isTest
    private static String simulateException() {
        return 'Simulated Exception';
    }

    @isTest
    public static void generatePERSegmentWithExceptionTest(){
        //Test.startTest();
         String strPER = EDI837PSegmentPER.generatePERSegment();
        if(strPER != ''){
   // throw new Exception('error message');
    }        
        // Simulate an exception by calling the helper method
       /* String errorMessage = simulateException();
        if (errorMessage != null) {
            // Handle the exception
            ElixirSuite__Exception_Log__c objExp = new ElixirSuite__Exception_Log__c();
            objExp.ElixirSuite__Stack_Trace_Long__c = 'EDI837p: Error occurred in PER Segment.' + errorMessage;
            Insert objExp;
        }
        
        String strPER = EDI837PSegmentPER.generatePERSegment();
        Test.stopTest();

        // Verify that the method returns null
        //System.assertEquals(null, strPER);

        // Verify that an exception log record was inserted
        List<ElixirSuite__Exception_Log__c> exceptionLogs = [SELECT Id FROM ElixirSuite__Exception_Log__c];
        System.assertEquals(1, exceptionLogs.size());*/
    }
}