public class EDI837PSegmentHI {
    public static String generateHISegment(ElixirSuite__Claim__c objClaim){
        try{
            String HI = 'HI';
            HI += '*' + EDIDataMappings.CodeListQualifierCode;
            HI += ':' +  EDIDataUtils.analyze(objClaim.ElixirSuite__Diagnosis_A__c, 3);
            if( objClaim.ElixirSuite__Diagnosis_B__c != null ){ HI += ':' + EDIDataUtils.analyze(objClaim.ElixirSuite__Diagnosis_B__c,3); }
            if( objClaim.ElixirSuite__Diagnosis_C__c != null ){ HI += ':' + EDIDataUtils.analyze(objClaim.ElixirSuite__Diagnosis_C__c,3); }
            if( objClaim.ElixirSuite__Diagnosis_D__c != null ){ HI += ':' + EDIDataUtils.analyze(objClaim.ElixirSuite__Diagnosis_D__c,3); }
            if( objClaim.ElixirSuite__Diagnosis_E__c != null ){ HI += ':' + EDIDataUtils.analyze(objClaim.ElixirSuite__Diagnosis_E__c,3); }
            if( objClaim.ElixirSuite__Diagnosis_F__c != null ){ HI += ':' + EDIDataUtils.analyze(objClaim.ElixirSuite__Diagnosis_F__c,3); }
            if( objClaim.ElixirSuite__Diagnosis_G__c != null ){ HI += ':' + EDIDataUtils.analyze(objClaim.ElixirSuite__Diagnosis_G__c,3); }
            if( objClaim.ElixirSuite__Diagnosis_H__c != null ){ HI += ':' + EDIDataUtils.analyze(objClaim.ElixirSuite__Diagnosis_H__c,3); }
            HI += '~' ;
            
            return HI + '\n';
        }
        catch(Exception e){
            ElixirSuite__Exception_Log__c objExp = new ElixirSuite__Exception_Log__c();
            objExp.ElixirSuite__Stack_Trace_Long__c = 'EDI837p: Error occurred HI Segment.' +  e.getMessage();
            Insert objExp;
            return null;
        }
    }
}