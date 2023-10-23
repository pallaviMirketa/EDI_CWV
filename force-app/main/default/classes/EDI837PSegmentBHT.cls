public class EDI837PSegmentBHT {
    public static String generateBHTSegment(){
        try{
            String BHT = 'BHT';
            BHT += '*' + EDIDataMappings.HierarchicalStructureCode;
            BHT += '*' + EDIDataMappings.transactionSetPurposeCode;
            BHT += '*' + EDIDataMappings.originatorApplicationTransactionID;
            BHT += '*' + EDIDataUtils.getDateTimeFormat(DateTime.now());
            BHT += '*' + EDIDataUtils.formattedTime;
            BHT += '*' + EDIDataMappings.claimID;
            BHT += '~';
            System.debug('BHT '+BHT);
            return BHT + '\n';
        }
        catch(exception e){
            ElixirSuite__Exception_Log__c objExp = new ElixirSuite__Exception_Log__c();
            objExp.ElixirSuite__Stack_Trace_Long__c = 'EDI837p: Error ocuured BHT Segment.' +  e.getMessage();
            Insert objExp;
            return null;
        }
    }
}