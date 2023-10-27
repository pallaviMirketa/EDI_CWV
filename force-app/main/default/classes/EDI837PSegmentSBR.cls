public class EDI837PSegmentSBR {
    public static String generateSBRSegment(){
            String SBR = 'SBR';
            SBR += '*' + EDIDataMappings.PayerResponsibilitySequenceNumberCode_01; //PayerResponsibilitySequenceNumberCode_01
            SBR += '*' + EDIDataMappings.IndividualRelationshipCode_02;
            SBR += '*'; //Insured Group or Policy Number
            SBR += '******';
            SBR += EDIDataMappings.ClaimFilingIndicatorCode_09;
            SBR += '~';
            
            return SBR + '\n';
      
         /* catch(Exception e){
            ElixirSuite__Exception_Log__c objExp = new ElixirSuite__Exception_Log__c();
            objExp.ElixirSuite__Stack_Trace_Long__c = 'EDI837p: Error ocuured SBR Segment.' +  e.getMessage();
            Insert objExp;
            return null;
        }*/
    }
}