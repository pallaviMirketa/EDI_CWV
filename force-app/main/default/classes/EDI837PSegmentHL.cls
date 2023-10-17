public class EDI837PSegmentHL {
public static String generateHLSegment(){
       
            String HL = 'HL';
            HL += '*' + EDIDataMappings.hierarchicalIDNumber;
            HL += '*';
            HL += '*' + EDIDataMappings.hierarchicalLevelCode;
            HL += '*' + EDIDataMappings.hierarchicalChildCode;
            HL += '~';
            return HL;
        
       /* catch(exception e){
            ElixirSuite__Exception_Log__c objExp = new ElixirSuite__Exception_Log__c();
            objExp.ElixirSuite__Stack_Trace_Long__c = 'EDI837p: Error ocuured HL Segment.' +  e.getMessage();
            Insert objExp;
            return null;
        }*/
    }
}