public class EDI837SegmentST {
	 public static String generateSTSegment(){
        try{
            String ST = 'ST';
            ST += '*' + '837'; //HealthCare Claim
            ST += '*' + EDIDataMappings.Transactionsetcontrol_02;
            ST += '*' + EDIDataMappings.Implementation_Convention_Reference03;
   
            return ST + '\n';
        }
        catch(Exception e){
            ElixirSuite__Exception_Log__c objExp = new ElixirSuite__Exception_Log__c();
            objExp.ElixirSuite__Stack_Trace_Long__c = 'EDI837p: Error ocuured ST Segment.' +  e.getMessage();
            Insert objExp;
            return null;
        }
    }
}