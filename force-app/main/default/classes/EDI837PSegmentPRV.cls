public class EDI837PSegmentPRV {
    public static String generatePRVSegment(ElixirSuite__Provider__c objProvider){
        try{
            String PRV = 'PRV';
            PRV += '*' + EDIDataMappings.providerCode;
            PRV += '*' + EDIDataMappings.referenceIdentificationQualifier;
            PRV += '*' + EDIDataUtils.analyze(objProvider.ElixirSuite__Provider_Taxonomy__c, 50);
            PRV += '~' ;
            return PRV + '\n';
        }
        catch(exception e){
            ElixirSuite__Exception_Log__c objExp = new ElixirSuite__Exception_Log__c();
            objExp.ElixirSuite__Stack_Trace_Long__c = 'EDI837p: Error ocuured PRV Segment.' +  e.getMessage();
            Insert objExp;
            return null;
        }
    }
}