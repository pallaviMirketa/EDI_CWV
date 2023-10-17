public class EDI837PSegmentPER {
    public static String generatePERSegment(){
        
        //formation of PER Segment
        try{
            String PER = 'PER';
            PER += '*' + EDIDataMappings.contactFunctionCode;
            PER += '*' + EDIDataMappings.submitterContactName;
            PER += '*' + EDIDataMappings.communicationNumberQualifier;
            PER += '~';
            
            return PER + '\n';
        }
        catch(Exception e){
            ElixirSuite__Exception_Log__c objExp = new ElixirSuite__Exception_Log__c();
            objExp.ElixirSuite__Stack_Trace_Long__c = 'EDI837p: Error occured in PER Segment.' +  e.getMessage();
            Insert objExp;
            return null;
        }
    }
}