public class EDI837PSegmentREF {
    public static String generateREFSegment(ElixirSuite__CMS_1500_Claim_Generation__c objCMS1500){
        try{
            String REF = 'REF';
            REF += '*' + EDIDataMappings.referenceIdQualifierREF;
            REF += '*' + (objCMS1500.ElixirSuite__Federal_Tax_Id_Number__c).replace('-','');
            REF += '~';
            
            return REF + '\n';
        }
        catch(exception e){
            ElixirSuite__Exception_Log__c objExp = new ElixirSuite__Exception_Log__c();
            objExp.ElixirSuite__Stack_Trace_Long__c = 'EDI837p: Error ocuured REF Segment.' +  e.getMessage();
            Insert objExp;
            return null;
        }
    }
}