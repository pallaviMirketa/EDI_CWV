public class EDI837PSegmentSBRHL {
    public static String generateSBRHLSegment(){
        
            String HL = 'HL';
            HL += '*' + '2';
            HL += '*' + EDIDataMappings.HierarchicalParentIDNumber_02;
            HL += '*' + EDIDataMappings.HierarchicalLevelCode_03;
            HL += '*' + EDIDataMappings.HierarchicalChildCode_04;
            HL += '~';
            return HL + '\n';
        
        /*catch(Exception e){
            ElixirSuite__Exception_Log__c objExp = new ElixirSuite__Exception_Log__c();
            objExp.ElixirSuite__Stack_Trace_Long__c = 'EDI837p: Error ocuured Subscriber HL Segment.' +  e.getMessage();
            Insert objExp;
            return null;
        }*/
    }
}