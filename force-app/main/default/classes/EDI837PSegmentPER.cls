public class EDI837PSegmentPER {
    public static String generatePERSegment(){
        
        //formation of PER Segment
      
            String PER = 'PER';
            PER += '*' + EDIDataMappings.contactFunctionCode_01;//101
            PER += '*' + EDIDataMappings.ResponseContactName_02;//102
            PER += '*' + EDIDataMappings.CommunicationNumberQualifier_03;
            PER += '*' + EDIDataMappings.ResponseContactCommunicationNumber_04;
            PER += '~';
            
            return PER + '\n';
        
     /*   catch(Exception e){
            ElixirSuite__Exception_Log__c objExp = new ElixirSuite__Exception_Log__c();
            objExp.ElixirSuite__Stack_Trace_Long__c = 'EDI837p: Error occured in PER Segment.' +  e.getMessage();
            Insert objExp;
            return null;
        }*/
    }
}