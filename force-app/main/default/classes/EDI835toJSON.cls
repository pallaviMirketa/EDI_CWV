public class EDI835toJSON {
    public static String parseEDItoJSON(String ediString) {
        //Conversion of JSON to wrapper is straight forward using JSON.serialize
        //But here we are aiming to convert STRING to Wrapper that will convert into JSON
        //that is quite difficult and lengthly approach
        //So, we are now converting string Directly into JSON **************************
        List<String> segmentList = ediString.split('~');
        List<List<String>> segmentData= new List<List<String>>();
        Integer count = 0;
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
            if(segment[0].equals('DTM') && segment[0].contains('405')){
                gen.writeFieldName('productionDate');
                gen.writeStartObject();
                gen.writeObjectField('dateTimeQualifier', segment[1]);
                gen.writeObjectField('productionDate', segment[2]);
                gen.writeEndObject();
            }
            
            if(segment[0].equals('N1') && segment[1].contains('PR')){
                count++;
                gen.writeFieldName('payer');
                gen.writeStartObject();
                gen.writeObjectField('payerIdentifierCode', segment[1]);
                gen.writeObjectField('payerName', segment[2]);
                gen.writeObjectField('identificationCodeQualifer', segment[3]);
                gen.writeObjectField('payerIdentificationCode', segment[4]);
                gen.writeEndObject();
            }
            if(segment[0].equals('N1') && segment[1].contains('PE')){
                count--;
                gen.writeFieldName('payee');
                gen.writeStartObject();
                gen.writeObjectField('payeeIdentifierCode', segment[1]);
                gen.writeObjectField('payeeName', segment[2]);
                gen.writeObjectField('payeeIdentificationCodeQualifer', segment[3]);
                gen.writeObjectField('payeeIdentificationCode', segment[4]);
                gen.writeEndObject();
            } 
            if(segment[0].equals('N3')){
                String addressType = (count == 1) ? 'payerAddress' : 'payeeAddress';
                gen.writeFieldName(addressType);
                gen.writeStartObject();
                gen.writeObjectField('address1', segment[1]);
                gen.writeEndObject();
            }
            if(segment[0].equals('N4')){
                String locationType = (count == 1) ? 'payerLocation' : 'payeeLocation';
                System.debug('locationType ' + locationType);
                gen.writeFieldName(locationType);
                gen.writeStartObject();
                gen.writeObjectField('city', segment[1]);
                gen.writeObjectField('state', segment[2]);
                gen.writeObjectField('zip', segment[3]);
                gen.writeEndObject();
            }
            if(segment[0].equals('PER')){
                if(segment[1].contains('CX')){
                    gen.writeFieldName('payerContactInfo');
                }else if(segment[1].contains('BL')){
                    gen.writeFieldName('payerTechnicalContactInfo');
                }    
                gen.writeStartObject();
                gen.writeObjectField('contactFunctionCode', segment[1]);
                gen.writeObjectField('ResponseContactName', segment[2]);
                gen.writeObjectField('communitcationNumberQualifier', segment[3]);
                gen.writeObjectField('ResponseContactCommunicationNumber', segment[4]);
                gen.writeEndObject();
                
            }
            if(segment[0].equals('REF')){
                String referenceType = (count == 1) ? 'payerAdditionalInfo' : 'payeeAdditionalInfo';
                gen.writeFieldName(referenceType);
                gen.writeStartArray();
                if(segment[1].contains('2U')){
                    gen.writeStartObject();
                    gen.writeObjectField('payerIdenticationNumber', segment[1]);
                    gen.writeObjectField('payerReferenceIdentication', segment[2]);
                    gen.writeEndObject();
                }
                if(segment[1].contains('TJ')){
                    gen.writeStartObject();
                    gen.writeObjectField('payeeIdenticationNumber', segment[1]);
                    gen.writeObjectField('payeeReferenceIdentication', segment[2]);
                    gen.writeEndObject();
                }
                gen.writeEndArray();
            }
            if(segment[0].equals('LX')){
                gen.writeFieldName('Lx');
                gen.writeStartObject();
                gen.writeObjectField('serviceLine', segment[1]);
                gen.writeEndObject();
            }
            
        }
        
        gen.writeEndObject();
        gen.writeEndArray();
        for(List<String> segment1: segmentData){
            if(segment1[0].equals('TS3')){
                gen.writeFieldName('TS3_ProviderSummaryInformation');
                gen.writeStartObject();
                gen.writeObjectField('providerIdentifier', segment1[1]);
                gen.writeObjectField('facilityTypeCode', segment1[2]);
                gen.writeObjectField('fiscalPeriodDate', segment1[3]);
                gen.writeObjectField('totalClaimCount', segment1[4]);
                gen.writeObjectField('totalClaimChargeAmount', segment1[5]);
                gen.writeEndObject();
            }
        }
        gen.writeFieldName('Claims');
        gen.writeStartArray(); 
        List<List<String>> duplicateClaims = new List<List<String>>();
        for(List<String> segment1: segmentData){
            if(segment1[0].equals('TS3')){
                gen.writeFieldName('TS3_ProviderSummaryInformation');
                gen.writeStartObject();
                gen.writeObjectField('providerIdentifier', segment1[1]);
                gen.writeObjectField('facilityTypeCode', segment1[2]);
                gen.writeObjectField('fiscalPeriodDate', segment1[3]);
                gen.writeObjectField('totalClaimCount', segment1[4]);
                gen.writeObjectField('totalClaimChargeAmount', segment1[5]);
                gen.writeEndObject();
            }
            if(segment1[0].equals('CLP')){
                duplicateClaims.add(segment1);
                gen.writeStartObject();
                gen.writeObjectField('patientClaimControlNumber', segment1[1]);
                gen.writeObjectField('patientClaimStatusCode', segment1[2]);
                gen.writeObjectField('totalClaimChargeAmount', segment1[3]);
                gen.writeObjectField('totalAmountPaid', segment1[4]);
                gen.writeObjectField('patientResponsibilityAmount', segment1[5]);
                gen.writeObjectField('patientClaimFilingIndicatorCode', segment1[6]);
                gen.writeObjectField('payerClaimControlNumber', segment1[7]);
                
                List<List<String>> duplicateSegments = new List<List<String>>();
                for(List<String> segment2: segmentData){
                    if(segment2[0].equals('NM1') && segment2[1].contains('QC') && !duplicateSegments.contains(segment2)){
                        duplicateSegments.add(segment2);
                        gen.writeFieldName('patient');
                        gen.writeStartObject();
                        gen.writeObjectField('lastName', segment2[3]);
                        gen.writeObjectField('firstName', segment2[4]);
                        gen.writeObjectField('middleInitial', segment2[5]);
                        gen.writeObjectField('suffix', segment2[8]);
                        gen.writeObjectField('memberNumber', segment2[9]);
                        gen.writeEndObject();                        
                    }
                    if(segment2[0].equals('NM1') && segment2[1].contains('82') && !duplicateSegments.contains(segment2)){
                        duplicateSegments.add(segment2);
                        gen.writeFieldName('insured');
                        gen.writeStartObject();
                        gen.writeObjectField('organizationName', segment2[3]);
                        gen.writeObjectField('providerNumber', segment2[9]);
                        gen.writeEndObject();                        
                    }
                    if(segment2[0].equals('DTM') && segment2[1].contains('232') && !duplicateSegments.contains(segment2)){
                        duplicateSegments.add(segment2);
                        gen.writeFieldName('statmentToDate');
                        gen.writeStartObject();
                        gen.writeObjectField('dateTimeQualifier', segment2[1]);
                        gen.writeObjectField('expirationDate', segment2[2]);
                        gen.writeEndObject(); 
                    }
                    if(segment2[0].equals('DTM') && segment2[1].contains('233') && !duplicateSegments.contains(segment2) ){
                        duplicateSegments.add(segment2);
                        gen.writeFieldName('coverageExperationDate');
                        gen.writeStartObject();
                        gen.writeObjectField('dateTimeQualifier', segment2[1]);
                        gen.writeObjectField('receivedDate', segment2[2]);
                        gen.writeEndObject(); 
                    }
                    if(segment2[0].equals('SVC') && !duplicateSegments.contains(segment2)){
                        gen.writeFieldName('services');
                        gen.writeStartArray(); 
                        for(List<String> segment3: segmentData){
                            if(segment3[0].equals('SVC') && !duplicateSegments.contains(segment3)){
                                duplicateSegments.add(segment3);
                                gen.writeStartObject();
                                String[] parts = segment3[1].split(':');
                                gen.writeObjectField('serviceTypeCode', parts[0]);
                                gen.writeObjectField('serviceCode', parts[1]);
                                gen.writeObjectField('modifier1', parts[2]);
                                gen.writeObjectField('modifier2', '');
                                gen.writeObjectField('modifier3', '');
                                gen.writeObjectField('modifier4', '');
                                gen.writeObjectField('serviceChargeAmt', segment3[2]);
                                gen.writeObjectField('providerPaymentAmt', segment3[3]);
                                gen.writeEndObject();
                            }
                            /*if(segment3[0].equals('DTM') && segment3[1].contains('472') && !duplicateSegments.contains(segment3)){
duplicateSegments.add(segment3);
gen.writeFieldName('serviceDate');
gen.writeStartObject();
gen.writeObjectField('dateTimeQualifier', segment3[1]);
gen.writeObjectField('serviceDate', segment3[2]);
gen.writeEndObject();
}*/
                            if(segment3[0].equals('CLP') && !duplicateClaims.contains(segment3)){
                                break;
                            }
                        }
                        gen.writeEndArray();
                    }
                    if(segment2[0].equals('CLP') && !duplicateClaims.contains(segment2)){
                        break;
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