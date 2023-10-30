public class EDI835toJSON {
    public static String parseEDItoJSON(String ediString) {
        //Conversion of JSON to wrapper is straight forward using JSON.serialize
        //But here we are aiming to convert STRING to Wrapper that will convert into JSON
        //that is quite difficult and lengthly approach
        //So, we are now converting string Directly into JSON **************************
        List<String> segmentList = ediString.split('~');
        List<List<String>> segmentData= new List<List<String>>();
        JSONGenerator gen = JSON.createGenerator(true);
        for(string str: segmentList){
            //List<String> innerDataList=str.split('*');
            segmentData.add(str.split('\\*'));
            //segmentData.put(str.split('\\*')[0].trim(),str.split('\\*'));
        }
        system.debug('segmentData:: '+segmentData);
        // JSONGenerator gen = JSON.createGenerator(true);
        gen.writeStartObject();      //{//
        gen.writeFieldName('mirketa');
        gen.writeStartArray();   //[//
        gen.writeStartObject();  //{//
        gen.writeFieldName('RawData');
        gen.writeStartArray(); //[//
        for(List<String> segment: segmentData){
            //System.debug('check Per '+segmentData.get('PER'));
            system.debug('key: '+segment[0]);
            //List<String> dataList=segmentData.get(segment);
            if(segment[0].equals('ISA')){
                gen.writeStartObject();  //{//
                gen.writeObjectField('interchangeSenderID', segment[6]);
                gen.writeObjectField('interchangeReceiverID', segment[8]);
            }
            if(segment[0].equals('GS')){
                gen.writeFieldName('gs');
                gen.writeStartObject();
                gen.writeObjectField('applicationSendersCode', segment[2]);
                gen.writeObjectField('applicationReceiversCode', segment[3]);
                gen.writeObjectField('dateOfMessage', segment[4]);
                gen.writeEndObject();
            }
            if(segment[0].equals('ST')){
                gen.writeFieldName('st');
                gen.writeStartObject();
                gen.writeObjectField('applicationSendersCode', segment[1]);
                gen.writeEndObject();
            }
            if(segment[0].equals('BPR')){
                gen.writeFieldName('finacialInfo');
                gen.writeStartObject();
                gen.writeObjectField('transactionHandlingCode', segment[1]);
                gen.writeObjectField('totalActualProviderPaymentAmount', segment[2]);
                gen.writeObjectField('creditDebitFlag', segment[3]);
                gen.writeObjectField('paymentMethodCode', segment[4]);
                gen.writeObjectField('paymentFormatCode', segment[5]);
                gen.writeObjectField('idNumberQualifier', segment[6]);
                gen.writeObjectField('identificationNumber', segment[7]);
                gen.writeObjectField('accountNumberQualifier', segment[8]);
                gen.writeObjectField('senderBankAccountNumber', segment[9]);
                gen.writeObjectField('originatingCompanyIdentifier', segment[10]);
                gen.writeObjectField('originatingCompanySupplementalCode', segment[11]);
                gen.writeObjectField('dfiIdentificationNumberQualifier', segment[12]);
                gen.writeObjectField('receiverBankIdNumber', segment[13]);
                gen.writeObjectField('acountNumberQualifier', segment[14]);
                gen.writeObjectField('receiverAccountNumber', segment[15]);
                gen.writeObjectField('checkIssueOrEftEffectiveDate', segment[16]);
                gen.writeEndObject();
            }
            if(segment[0].equals('TRN')){
                gen.writeFieldName('transInfo');
                gen.writeStartObject();
                gen.writeObjectField('traceTypeCode', segment[1]);
                gen.writeObjectField('checkNumber', segment[2]);
                gen.writeObjectField('employerIdentificationNum', segment[3]);
                gen.writeObjectField('originatingCompanySupplementalCode', segment[4]);
                gen.writeEndObject();
            }
            if(segment[0].equals('DTM')){
                gen.writeFieldName('productionDate');
                gen.writeStartObject();
                gen.writeObjectField('dateTimeQualifier', segment[1]);
                gen.writeObjectField('productionDate', segment[2]);
                gen.writeEndObject();
            }
            if(segment[0].equals('N1')){
                if(segment[1].contains('PR')){
                    gen.writeFieldName('payer');
                    gen.writeStartObject();
                    gen.writeObjectField('payerIdentifierCode', segment[1]);
                    gen.writeObjectField('payerName', segment[2]);
                    gen.writeObjectField('identificationCodeQualifer', segment[3]);
                    gen.writeObjectField('payerIdentificationCode', segment[4]);
                    gen.writeEndObject();
                }
            }
            if(segment[0].equals('N3')){
                gen.writeFieldName('payerAddress');
                gen.writeStartObject();
                gen.writeObjectField('address1', segment[1]);
                gen.writeEndObject();
            }
            if(segment[0].equals('N4')){
                gen.writeFieldName('payerLocation');
                gen.writeStartObject();
                gen.writeObjectField('city', segment[1]);
                gen.writeObjectField('state', segment[2]);
                gen.writeObjectField('zip', segment[3]);
                gen.writeEndObject();
            }
            if(segment[0].equals('PER')){
                System.debug('after if CX');
                if(segment[1].contains('CX')){
                    System.debug('Sne   *');
                    gen.writeFieldName('payerContactInfo');
                    gen.writeStartObject();
                    gen.writeObjectField('contactFunctionCode', segment[1]);
                    gen.writeObjectField('payerContactName', segment[2]);
                    gen.writeObjectField('communitcationNumberQualifier', segment[3]);
                    gen.writeObjectField('payerPhoneNum', segment[4]);
                    // gen.writeObjectField('communitcationNumberQualifier', dataList[5]);
                    gen.writeEndObject();
                }
                if(segment[1].contains('BL')){
                    System.debug('after if BL');
                    gen.writeFieldName('payerTechnicalContactInfo');
                    gen.writeStartObject();
                    gen.writeObjectField('contactFunctionCode', segment[1]);
                    gen.writeObjectField('payerTechnicalName', segment[2]);
                    gen.writeObjectField('communitcationNumberQualifier', segment[3]);
                    gen.writeObjectField('payerPhoneNum', segment[4]);
                    gen.writeEndObject();
                }
            }
            if(segment[0].equals('N1') && segment[1].contains('PE')){
                // payerN1 = segment[1];
                gen.writeFieldName('payee');
                gen.writeStartObject();
                gen.writeObjectField('payeeIdentifierCode', segment[1]);
                gen.writeObjectField('payeeName', segment[2]);
                gen.writeObjectField('payeeIdentificationCodeQualifer', segment[3]);
                gen.writeObjectField('payeeIdentificationCode', segment[4]);
                gen.writeEndObject();
            }           
            if(segment[0].equals('REF')){
            if(segment[1].contains('TJ')){
                gen.writeFieldName('payeeAdditionalInfo');
                gen.writeStartObject();
                gen.writeObjectField('payeeIdenticationNumber', segment[1]);
                gen.writeObjectField('payeeReferenceIdentication', segment[2]);
                gen.writeEndObject();
            }
        }
            if(segment[0].equals('LX')){
                gen.writeFieldName('Lx');
                gen.writeStartObject();
                gen.writeObjectField('serviceLine', segment[1]);
                gen.writeEndObject();
            }

            //if(segment.equalsIgnoreCase('REF')){}

            /*if(segment.equalsIgnoreCase('PER')){}//Second PER add extra condition - BL*/
        }

        gen.writeEndObject();
        gen.writeEndArray();
        gen.writeFieldName('Claims');
        gen.writeStartArray(); 
        for(List<String> segment1: segmentData){
            if(segment1[0].equals('CLP')){
                gen.writeStartObject();
                gen.writeObjectField('patientClaimControlNumber', segment1[1]);
                gen.writeObjectField('patientClaimStatusCode', segment1[2]);
                gen.writeObjectField('totalClaimChargeAmount', segment1[3]);
                gen.writeObjectField('totalAmountPaid', segment1[4]);
                gen.writeObjectField('patientResponsibilityAmount', segment1[5]);
                gen.writeObjectField('patientClaimFilingIndicatorCode', segment1[6]);
                gen.writeObjectField('payerClaimControlNumber', segment1[7]);
                // segmentData.remove(segment);
                for(List<String> segment2: segmentData){
                    if(segment2[0].equals('NM1') && segment2[1].contains('QC')){
                        gen.writeFieldName('patient');
                        gen.writeStartObject();
                        gen.writeObjectField('lastName', segment2[3]);
                        gen.writeObjectField('firstName', segment2[4]);
                        gen.writeObjectField('middleInitial', segment2[5]);
                        gen.writeObjectField('suffix', segment2[8]);
                        gen.writeObjectField('memberNumber', segment2[9]);
                        gen.writeEndObject();                        
                    }
                    if(segment2[0].equals('NM1') && segment2[1].contains('82')){
                        gen.writeFieldName('insured');
                        gen.writeStartObject();
                        gen.writeObjectField('organizationName', segment2[3]);
                        gen.writeObjectField('providerNumber', segment2[9]);
                        gen.writeEndObject();                        
                    }
                    if(segment2[0].equals('SVC')){
                        gen.writeFieldName('services');
                        gen.writeStartArray(); 
                        List<List<String>> duplicateSVC = new List<List<String>>();
                        for(List<String> segment3: segmentData){
                            if(segment3[0].equals('SVC') && !duplicateSVC.contains(segment3)){
                                duplicateSVC.add(segment3);
                                gen.writeStartObject();
                                String[] parts = segment3[1].split(':');
                                gen.writeObjectField('serviceTypeCode', parts[0]);
                                gen.writeObjectField('serviceCode', parts[1]);
                                gen.writeObjectField('serviceChargeAmt', segment3[2]);
                                gen.writeObjectField('providerPymentAmt', segment3[3]);
                                gen.writeEndObject();
                            }
                        }
                        gen.writeEndArray();
                    }
                }
                gen.writeEndObject();
            }
        } 
        gen.writeEndArray();
        gen.writeEndObject();
        gen.writeEndArray();
        gen.writeEndObject();
        String jsonData = gen.getAsString();
        system.debug('jsonData: '+jsonData);
        ElixirSuite__Exception_Log__c objExp = new ElixirSuite__Exception_Log__c();
        objExp.ElixirSuite__Stack_Trace_Long__c = jsonData;
        Insert objExp;
        return jsonData;
    }
}