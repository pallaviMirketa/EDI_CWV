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
        for(Integer i = 0 ;i < segmentData.size() ;i++){
            //System.debug('check Per '+segmentData[i]Data.get('PER'));
            system.debug('key: '+segmentData[i][0]);
            //List<String> dataList=segmentData[i]Data.get(segmentData[i]);
            if(segmentData[i][0].equals('ISA')){
                gen.writeStartObject();  //{//
                gen.writeObjectField('interchangeSenderID', segmentData[i][6]);
                gen.writeObjectField('interchangeReceiverID', segmentData[i][8]);
            }
            if(segmentData[i][0].equals('GS')){
                gen.writeFieldName('gs');
                gen.writeStartObject();
                gen.writeObjectField('applicationSendersCode', segmentData[i][2]);
                gen.writeObjectField('applicationReceiversCode', segmentData[i][3]);
                gen.writeObjectField('dateOfMessage', segmentData[i][4]);
                gen.writeEndObject();
            }
            if(segmentData[i][0].equals('ST')){
                gen.writeFieldName('st');
                gen.writeStartObject();
                gen.writeObjectField('applicationSendersCode', segmentData[i][1]);
                gen.writeEndObject();
            }
            if(segmentData[i][0].equals('BPR')){
                gen.writeFieldName('finacialInfo');
                gen.writeStartObject();
                gen.writeObjectField('transactionHandlingCode', segmentData[i][1]);
                gen.writeObjectField('totalActualProviderPaymentAmount', segmentData[i][2]);
                gen.writeObjectField('creditDebitFlag', segmentData[i][3]);
                gen.writeObjectField('paymentMethodCode', segmentData[i][4]);
                gen.writeObjectField('paymentFormatCode', segmentData[i][5]);
                gen.writeObjectField('idNumberQualifier', segmentData[i][6]);
                gen.writeObjectField('identificationNumber', segmentData[i][7]);
                gen.writeObjectField('accountNumberQualifier', segmentData[i][8]);
                gen.writeObjectField('senderBankAccountNumber', segmentData[i][9]);
                gen.writeObjectField('originatingCompanyIdentifier', segmentData[i][10]);
                gen.writeObjectField('originatingCompanySupplementalCode', segmentData[i][11]);
                gen.writeObjectField('dfiIdentificationNumberQualifier', segmentData[i][12]);
                gen.writeObjectField('receiverBankIdNumber', segmentData[i][13]);
                gen.writeObjectField('acountNumberQualifier', segmentData[i][14]);
                gen.writeObjectField('receiverAccountNumber', segmentData[i][15]);
                gen.writeObjectField('checkIssueOrEftEffectiveDate', segmentData[i][16]);
                gen.writeEndObject();
            }
            if(segmentData[i][0].equals('TRN')){
                gen.writeFieldName('transInfo');
                gen.writeStartObject();
                gen.writeObjectField('traceTypeCode', segmentData[i][1]);
                gen.writeObjectField('checkNumber', segmentData[i][2]);
                gen.writeObjectField('employerIdentificationNum', segmentData[i][3]);
                gen.writeObjectField('originatingCompanySupplementalCode', segmentData[i][4]);
                gen.writeEndObject();
            }
            if(segmentData[i][0].equals('DTM') && segmentData[i][1].contains('405')){
                gen.writeFieldName('productionDate');
                gen.writeStartObject();
                gen.writeObjectField('dateTimeQualifier', segmentData[i][1]);
                gen.writeObjectField('productionDate', segmentData[i][2]);
                gen.writeEndObject();
            }
            
            if(segmentData[i][0].equals('N1') && segmentData[i][1].contains('PR')){
                gen.writeFieldName('payer');
                gen.writeStartObject();
                gen.writeObjectField('payerIdentifierCode', segmentData[i][1]);
                gen.writeObjectField('payerName', segmentData[i][2]);
                gen.writeObjectField('identificationCodeQualifer', segmentData[i][3]);
                gen.writeObjectField('payerIdentificationCode', segmentData[i][4]);
                gen.writeEndObject();
                for(Integer j = i+1; j< segmentData.size();j++){
                    if(segmentData[j][0].equals('PER')){ //doubt
                        break;
                    }
                    if(segmentData[j][0].equals('N3')){
                        gen.writeFieldName('payerAddress');
                        gen.writeStartObject();
                        gen.writeObjectField('address1', segmentData[j][1]);
                        gen.writeEndObject();
                    }
                    if(segmentData[j][0].equals('N4')){
                        gen.writeFieldName('payerLocation');
                        gen.writeStartObject();
                        gen.writeObjectField('city', segmentData[j][1]);
                        gen.writeObjectField('state', segmentData[j][2]);
                        gen.writeObjectField('zip', segmentData[j][3]);
                        gen.writeEndObject();
                    }
                    if(segmentData[j][0].equals('REF')){
                        gen.writeFieldName('payerAdditionalInfo');
                        gen.writeStartArray();
                        for(Integer k = j ; k < segmentData.size(); k++){
                            if(segmentData[k][0].equals('PER')){
                                break;
                            }
                            if(segmentData[k][0].equals('REF')){
                                gen.writeStartObject();
                                gen.writeObjectField('payerReferenceIdentication', segmentData[k][1]);
                                gen.writeObjectField('payerIdenticationNumber', segmentData[k][2]);
                                gen.writeEndObject();
                            }
                            
                        }
                        gen.writeEndArray();
                    }
                }
            }
            if(segmentData[i][0].equals('PER')){
                if(segmentData[i][1].contains('CX')){
                    gen.writeFieldName('payerContactInfo');
                }else if(segmentData[i][1].contains('BL')){
                    gen.writeFieldName('payerTechnicalContactInfo');
                }    
                gen.writeStartObject();
                gen.writeObjectField('contactFunctionCode', segmentData[i][1]);
                gen.writeObjectField('payerContactName', segmentData[i][2]);
                gen.writeObjectField('communitcationNumberQualifier', segmentData[i][3]);
                gen.writeObjectField('payerContactCommunicationNumber', segmentData[i][4]);
                gen.writeEndObject();
                
            }
              if(segmentData[i][0].equals('N1') && segmentData[i][1].contains('PE')){
                gen.writeFieldName('payee');
                gen.writeStartObject();
                gen.writeObjectField('payeeIdentifierCode', segmentData[i][1]);
                gen.writeObjectField('payeeName', segmentData[i][2]);
                gen.writeObjectField('identificationCodeQualifer', segmentData[i][3]);
                gen.writeObjectField('payeeIdentificationCode', segmentData[i][4]);
                gen.writeEndObject();
                for(Integer j = i+1; j< segmentData.size();j++){
                    if(segmentData[j][0].equals('LX')){ //doubt
                        break;
                    }
                    if(segmentData[j][0].equals('N3')){
                        gen.writeFieldName('payeeAddress');
                        gen.writeStartObject();
                        gen.writeObjectField('address1', segmentData[j][1]);
                        gen.writeEndObject();
                    }
                    if(segmentData[j][0].equals('N4')){
                        gen.writeFieldName('payeeLocation');
                        gen.writeStartObject();
                        gen.writeObjectField('city', segmentData[j][1]);
                        gen.writeObjectField('state', segmentData[j][2]);
                        gen.writeObjectField('zip', segmentData[j][3]);
                        gen.writeEndObject();
                    }
                    if(segmentData[j][0].equals('REF')){
                        gen.writeFieldName('payeeAdditionalInfo');
                        gen.writeStartArray();
                        for(Integer k = j ; k < segmentData.size(); k++){
                            if(segmentData[k][0].equals('LX')){
                                break;
                            }
                            if(segmentData[k][0].equals('REF')){
                                gen.writeStartObject();
                                gen.writeObjectField('payeeReferenceIdentication', segmentData[k][1]);
                                gen.writeObjectField('payeeIdenticationNumber', segmentData[k][2]);
                                gen.writeEndObject();
                            }
                            
                        }
                        gen.writeEndArray();
                        break;
                    }
                }
            }
            
            
            if(segmentData[i][0].equals('LX')){
                gen.writeFieldName('lx');
                gen.writeStartObject();
                gen.writeObjectField('serviceLine', segmentData[i][1]);
                gen.writeEndObject();
            }
            
        }
        
        gen.writeEndObject();
        gen.writeEndArray();
        
        for(List<String> segment: segmentData){
            if(segment[0].equals('TS3')){
                gen.writeFieldName('providerSummaryInformation');
                gen.writeStartArray(); 
                gen.writeStartObject();
                gen.writeObjectField('providerIdentifier', segment[1]);
                gen.writeObjectField('facilityTypeCode', segment[2]);
                gen.writeObjectField('fiscalPeriodDate', segment[3]);
                gen.writeObjectField('totalClaimCount', segment[4]);
                gen.writeObjectField('totalClaimChargeAmount', segment[5]);
                gen.writeEndObject();
                gen.writeEndArray();
            }
        }
        gen.writeFieldName('claims');
        gen.writeStartArray(); 
        List<List<String>> duplicateClaims = new List<List<String>>();
        for(Integer i = 0 ;i < segmentData.size() ;i++){
            if(segmentData[i][0].equals('CLP')  && !duplicateClaims.contains(segmentData[i])){
                duplicateClaims.add(segmentData[i]);
                gen.writeStartObject();
                gen.writeObjectField('patientClaimControlNumber', segmentData[i][1]);
                gen.writeObjectField('patientClaimStatusCode', segmentData[i][2]);
                gen.writeObjectField('totalClaimChargeAmount', segmentData[i][3]);
                gen.writeObjectField('totalAmountPaid', segmentData[i][4]);
                gen.writeObjectField('patientResponsibilityAmount', segmentData[i][5]);
                gen.writeObjectField('patientClaimFilingIndicatorCode', segmentData[i][6]);
                gen.writeObjectField('payerClaimControlNumber', segmentData[i][7]);
                for( Integer j = i + 1 ; j< segmentData.size();j++){
                    if(segmentData[j][0].equals('CLP')  && !duplicateClaims.contains(segmentData[j])){
                        break;
                    }
                    if(segmentData[j][0].equals('NM1') && segmentData[j][1].contains('QC')){
                        gen.writeFieldName('patient');
                        gen.writeStartObject();
                        gen.writeObjectField('lastName', segmentData[j][3]);
                        gen.writeObjectField('firstName', segmentData[j][4]);
                        gen.writeObjectField('middleInitial', segmentData[j][5]);
                        gen.writeObjectField('suffix', segmentData[j][8]);
                        gen.writeObjectField('memberNumber', segmentData[j][9]);
                        gen.writeEndObject();                        
                    }
                    if(segmentData[j][0].equals('NM1') && segmentData[j][1].contains('82')){
                        gen.writeFieldName('insured');
                        gen.writeStartObject();
                        gen.writeObjectField('organizationName', segmentData[j][3]);
                        gen.writeObjectField('providerNumber', segmentData[j][9]);
                        gen.writeEndObject();                        
                    }
                    if(segmentData[j][0].equals('DTM') && segmentData[j][1].contains('232')){
                        gen.writeFieldName('statmentToDate');
                        gen.writeStartObject();
                        gen.writeObjectField('dateTimeQualifier', segmentData[j][1]);
                        gen.writeObjectField('expirationDate', segmentData[j][2]);
                        gen.writeEndObject(); 
                    }
                    if(segmentData[j][0].equals('DTM') && segmentData[j][1].contains('233')){
                        gen.writeFieldName('coverageExperationDate');
                        gen.writeStartObject();
                        gen.writeObjectField('dateTimeQualifier', segmentData[j][1]);
                        gen.writeObjectField('receivedDate', segmentData[j][2]);
                        gen.writeEndObject(); 
                    }
                    if(segmentData[j][0].equals('SVC')){
                        gen.writeFieldName('services');
                        gen.writeStartArray(); 
                        for(Integer k = j ; k < segmentData.size(); k++){
                            if(segmentData[k][0].equals('CLP') && !duplicateClaims.contains(segmentData[k])){
                                break;
                            }
                            if(segmentData[k][0].equals('SVC')){
                                gen.writeStartObject();
                                String[] parts = segmentData[k][1].split(':');
                                gen.writeObjectField('serviceTypeCode', parts[0]);
                                gen.writeObjectField('serviceCode', parts[1]);
                                gen.writeObjectField('modifier1', parts[2]);
                                gen.writeObjectField('modifier2', '');
                                gen.writeObjectField('modifier3', '');
                                gen.writeObjectField('modifier4', '');
                                gen.writeObjectField('serviceChargeAmt', segmentData[k][2]);
                                gen.writeObjectField('providerPaymentAmt', segmentData[k][3]);
                                for(Integer l = k+1 ; l < segmentData.size(); l++){
                                    if( segmentData[l][0].equals('DTM')){
                                        gen.writeFieldName('service');
                                        gen.writeStartObject();
                                        gen.writeObjectField('dateTimeQualifier', segmentData[l][1]);
                                        gen.writeObjectField('serviceDate', segmentData[l][2]);
                                        gen.writeEndObject();
                                        break;
                                    }
                                }
                                gen.writeFieldName('adjust');
                                gen.writeStartArray();
                                for(Integer l = k+1 ; l < segmentData.size(); l++){
                                    if(segmentData[l][0].equals('SVC')){
                                        break;
                                    }
                                    if(segmentData[l][0].equals('CAS')){
                                        gen.writeStartObject();
                                        gen.writeObjectField('claimAdjustmentGroupCode', segmentData[l][1]);
                                        gen.writeObjectField('adjustmentCodeReason', segmentData[l][2]);
                                        gen.writeObjectField('adjustmentAmt', segmentData[l][3]);
                                        gen.writeObjectField('adjustmentQuantity', segmentData[l][4]);
                                        gen.writeEndObject(); 
                                    }
                                }
                                gen.writeEndArray();
                                gen.writeEndObject();
                            }   
                        }
                        gen.writeEndArray();
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