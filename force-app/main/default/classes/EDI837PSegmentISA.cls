public class EDI837PSegmentISA {
    public static String generateISASegment(){
        
            String ISA = 'ISA';
            ISA += '*' + EDIDataMappings.AuthInfoQualifier_1;//ISA01
            ISA += '*' + ' '.repeat(10);//ISA02
            ISA += '*' + EDIDataMappings.SecurityInfoQualifier_3;
            ISA += '*' + ' '.repeat(10);
            ISA += '*' + EDIDataMappings.SenderIDQualifier_5;
            ISA += '*' + EDIDataMappings.InterchangeSenderID;//75225
            ISA += '*' + EDIDataMappings.ReceiverIDQualifier_7;
            ISA += '*' + EDIDataMappings.InterchangeReceiverID_8;
            ISA += '*' + String.valueOf(DateTime.now().format('yyMMdd')); //Date
            ISA += '*' + EDIDataUtils.formattedTimeHHmm; //Time
            ISA += '*' + EDIDataMappings.InterchangeControlStandId_11;
            ISA += '*' + EDIDataMappings.InterchangeControlVersionNumber_12;
            ISA += '*' + EDIDataMappings.InterchangeControlNumber_13;
            ISA += '*' + EDIDataMappings.AcknowledgementRequested_14;
            ISA += '*' + EDIDataMappings.UsageIndicator_15Producttion;
            ISA += '*' + EDIDataMappings.ComponentElementSeparator_16;
            ISA += '~' ;
            
            return ISA + '\n';
        
        /*catch(Exception e){
            ElixirSuite__Exception_Log__c objExp = new ElixirSuite__Exception_Log__c();
            objExp.ElixirSuite__Stack_Trace_Long__c = 'EDI837p: Error ocuured ISA Segment.' +  e.getMessage();
            Insert objExp;
            return null;
        }*/
    }
}