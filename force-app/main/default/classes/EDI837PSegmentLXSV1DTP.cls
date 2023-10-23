public class EDI837PSegmentLXSV1DTP{
    public static String generateLXSV1DTPSegment(ElixirSuite__Claim__c objClaim){
        try{
            List<ElixirSuite__Claim_Line_Items__c> allClaimItems = objClaim.ElixirSuite__Claim_Line_Items__r;
            Integer counter = 1;
            String finalLXSegment = '';
            for(ElixirSuite__Claim_Line_Items__c objClaimlineItem: allClaimItems){
                String LX = 'LX';
                LX += '*' + counter;
                LX += '~';
                counter ++;
                String SV1 = 'SV1';
                SV1 += '*' + EDIDataMappings.ProductorServiceIDQualifier_01;//101 -1
                SV1 += ':' + EDIDataUtils.analyze(objClaimlineItem.ElixirSuite__CPT_HCPCS_Code__c); //101 -2
                if(objClaimlineItem.ElixirSuite__Modifier_1__c != null){ SV1 += ':' + EDIDataUtils.analyze(objClaimlineItem.ElixirSuite__Modifier_1__c); }//101-3
                if(objClaimlineItem.ElixirSuite__Modifier_2__c != null){ SV1 += ':' + EDIDataUtils.analyze(objClaimlineItem.ElixirSuite__Modifier_2__c); }//101-4
                SV1 += '*' + EDIDataUtils.analyze(String.valueOf(objClaimlineItem.ElixirSuite__Procedure_Charge__c)); //102
                SV1 += '*' + EDIDataMappings.UnitorBasisforMeasurementCode_03; //103
                SV1 += '*' + EDIDataUtils.analyze(String.valueOf(objClaimlineItem.ElixirSuite__Days_Units__c)); //104
                SV1 += '*' + EDIDataUtils.analyze(String.valueOf(objClaimlineItem.ElixirSuite__Place_of_Service__c)); //105
                SV1 += '*'; //106 - no data
                SV1 += '*' + EDIDataUtils.analyze(objClaimlineItem.ElixirSuite__Diagnosis_Pointer__c); //107
                SV1 += '*';
                SV1 += '~';
                String DTP = 'DTP';
                DTP += '*' + '472';
                DTP += '*' + 'D8';
                DTP += '*' + EDIDataUtils.getDateTimeFormat(objClaimlineItem.ElixirSuite__From_Date_Of_Service__c);
                DTP += '~';
                finalLXSegment += LX + '\n'+ SV1 + '\n' + DTP + '\n';
                
            }
            return finalLXSegment;
        }
        catch(exception e){
            ElixirSuite__Exception_Log__c objExp = new ElixirSuite__Exception_Log__c();
            objExp.ElixirSuite__Stack_Trace_Long__c = 'EDI837p: Error ocuured LX ,SV1 and DTP Segment.' +  e.getMessage();
            Insert objExp;
            return null;
        }
    }
}