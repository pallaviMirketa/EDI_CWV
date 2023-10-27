public class EDI837PSegmentDMG {
    public static String generateDMGSegment(ElixirSuite__Claim__c objClaim){
        try{
            String DMG = 'DMG';
            DMG += '*' + EDIDataMappings.dateTimePeriodFormatQualifier;
            DMG += '*' + EDIDataUtils.analyze(EDIDataUtils.getDateTimeFormat(objClaim.ElixirSuite__Insured_DOB__c));
            DMG += '*' + EDIDataUtils.analyze(objClaim.ElixirSuite__Insured_Sex__c);
            DMG += '~';
            return DMG + '\n';
        }
        catch(exception e){
            ElixirSuite__Exception_Log__c objExp = new ElixirSuite__Exception_Log__c();
            objExp.ElixirSuite__Stack_Trace_Long__c = 'EDI837p: Error ocuured DMG Segment.' +  e.getMessage();
            Insert objExp;
            return null;
        }
    }
}