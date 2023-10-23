public class EDI837PSegmentSE {
    public static String generatSESegment(integer count){
        try{
            String SE = 'SE';
            SE += '*' + (--count);
            SE += '*' + EDIDataMappings.Transactionsetcontrol_02;
            SE += '~';
            return SE + '\n';
        }
        catch(exception e){
            ElixirSuite__Exception_Log__c objExp = new ElixirSuite__Exception_Log__c();
            objExp.ElixirSuite__Stack_Trace_Long__c = 'EDI837p: Error ocuured SE Segment.' +  e.getMessage();
            Insert objExp;
            return null; 
        }
    }
}