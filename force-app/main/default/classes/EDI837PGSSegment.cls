public class EDI837PGSSegment {
    public static String generateGSSegment(ElixirSuite__Claim__c claim,Organization objOrg){
        
        //formation of GS Segment
        try{
            String GS = 'GS';
            GS += '*' +'HC';//CodeIdentifyingInformationType
            GS += '*' + EDIDataMappings.applicationCode; //SenderIdCode
            GS += '*' + '77033'; //receiverId
            GS += '*' + EDIDataUtils.getDateTimeFormat(DateTime.now()); //Date
            GS += '*' + EDIDataUtils.formattedTime; //Time
            GS += '*' + EDIDataMappings.GroupControlNumber_6;//GroupControlNumber
            GS += '*' + EDIDataMappings.transactionTypeCode_7; //TransactionTypeCode//ElixirSuite__Payment_Method__c
            GS += '*' + EDIDataMappings.VersionAndRelease_8; //VersionAndRelease
            GS += '~' ;
            
            System.debug('GS'+ GS);
            return GS + + '\n';
        }
        catch(Exception e){
            ElixirSuite__Exception_Log__c objExp = new ElixirSuite__Exception_Log__c();
            objExp.ElixirSuite__Stack_Trace_Long__c = 'EDI837p: Error occured in GS Segment.' +  e.getMessage();
            Insert objExp;
            return null;
        }
    }
}