public class EDI835toJSON {
    public static String parseEDItoJSON(String ediString) {
        //Conversion of JSON to wrapper is straight forward using JSON.serialize
        //But here we are aiming to convert STRING to Wrapper that will convert into JSON
        //that is quite difficult and lengthly approach
        //So, we are now converting string Directly into JSON ***************************
        String ediMessage = ediString.replaceAll('~\\n','~');
        List<String> segmentList = ediMessage.split('~');
        List<List<String>> segmentData= new List<List<String>>();
        Integer count = 0;
        Integer payeeREFCount = 0;
        Integer payerREFCount = 0;
        Integer dtmCountOfsvc = 0;
        
        Integer segmentDataSize = null;
        
        JSONGenerator gen = JSON.createGenerator(true);
        for(string str: segmentList){
            segmentData.add(str.split('\\*'));
        }
        gen.writeStartObject();      //{//
        gen.writeFieldName('Elixir');
        gen.writeStartArray();   //[//
        gen.writeStartObject();  //{//
        gen.writeFieldName('RawData');
        gen.writeStartArray(); //[//
        for(Integer i = 0 ;i < segmentData.size() ;i++){
            if(segmentData[i][0].equals('ISA')){
                segmentDataSize = segmentData[i].size();
                gen.writeStartObject();  
                gen.writeObjectField('authorizationInformationQualifier', segmentDataSize > 1 ? segmentData[i][1] : '');
                gen.writeObjectField('authorizationInformationQualifierText', segmentDataSize > 1 ? EDI835DataMappings.getAuthorizationType(segmentData[i][1]) : '');
                gen.writeObjectField('authorizationInformation', segmentDataSize > 2 ? segmentData[i][2] : '');
                gen.writeObjectField('securityInformationQualifier', segmentDataSize > 3 ? segmentData[i][3] : '');
                gen.writeObjectField('securityInformationQualifierText', segmentDataSize > 3 ? EDI835DataMappings.getSecurityInfoQualifierText(segmentData[i][3]) : '');
                gen.writeObjectField('securityInformation', segmentDataSize > 4 ? segmentData[i][4] : '');
                gen.writeObjectField('senderIDQualifier', segmentDataSize > 5 ? segmentData[i][5] : ''); 
                gen.writeObjectField('senderIDQualifierText', segmentDataSize > 5 ?  EDI835DataMappings.getISACode(segmentData[i][5]) : '');
                gen.writeObjectField('interchangeSenderID', segmentDataSize > 6 ? segmentData[i][6] : '');
                gen.writeObjectField('receiverIDQualifier', segmentDataSize > 7 ? segmentData[i][7] : '');
                gen.writeObjectField('receiverIDQualifierText', segmentDataSize > 7 ? EDI835DataMappings.getISACode(segmentData[i][7]) : '');
                gen.writeObjectField('interchangeReceiverID',segmentDataSize > 8 ? segmentData[i][8] : '');
                gen.writeObjectField('interchangeDate',segmentDataSize > 9 ? segmentData[i][9] : '');
                gen.writeObjectField('interchangeTime',segmentDataSize > 10 ? segmentData[i][10] : '');
                gen.writeObjectField('interchangeControlStandardsIdentifier',segmentDataSize > 11 ? segmentData[i][11] : '');
                gen.writeObjectField('interchangeControlVersionNumber',segmentDataSize > 12 ? segmentData[i][12] : '');
                gen.writeObjectField('interchangeControlNumber',segmentDataSize > 13 ? segmentData[i][13] : '');
                gen.writeObjectField('acknowledgementRequested',segmentDataSize > 14 ? segmentData[i][14] : '');
                gen.writeObjectField('acknowledgementRequestedText',segmentDataSize > 14 ? EDI835DataMappings.getackRequestedText(segmentData[i][14]) : '');
                gen.writeObjectField('usageIndicator',segmentDataSize > 15 ? segmentData[i][15] : '');
                gen.writeObjectField('componentElementSeparator',segmentDataSize > 16 ? segmentData[i][16] : '');
            }
            if(segmentData[i][0].equals('GS')){
                segmentDataSize = segmentData[i].size();
                gen.writeFieldName('gs');
                gen.writeStartObject();
                gen.writeObjectField('codeIdentifyingInformationType', segmentDataSize > 1 ? segmentData[i][1] : '');
                gen.writeObjectField('codeIdentifyingInformationTypeText', segmentDataSize > 1 ? EDI835DataMappings.getGSSegmentCodes(segmentData[i][1]) : '');
                gen.writeObjectField('applicationSendersCode', segmentDataSize > 2 ? segmentData[i][2] : '');
                gen.writeObjectField('applicationReceiversCode', segmentDataSize > 3 ? segmentData[i][3] : '');
                gen.writeObjectField('dateOfMessage', segmentDataSize > 4 ? segmentData[i][4] : '');
                gen.writeObjectField('time', segmentDataSize > 5 ? segmentData[i][5] : '');
                gen.writeObjectField('groupControlNumber', segmentDataSize > 6 ? segmentData[i][6] : '');
                gen.writeObjectField('transactionTypeCode', segmentDataSize > 7 ? segmentData[i][7] : '');
                gen.writeObjectField('transactionTypeCodeText', segmentDataSize > 7 ? EDI835DataMappings.getGSTransactionTypeCodeText(segmentData[i][7]) : '');
                gen.writeObjectField('versionAndRelease', segmentDataSize > 8 ? segmentData[i][8] : '');
                gen.writeEndObject();
            }
            if(segmentData[i][0].equals('ST')){
                segmentDataSize = segmentData[i].size();
                gen.writeFieldName('st');
                gen.writeStartObject();
                gen.writeObjectField('applicationSendersCode', segmentDataSize > 1 ?  segmentData[i][1] : '');
                gen.writeObjectField('transactionSetControlNumber', segmentDataSize > 1 ? segmentData[i][2] : '');
                gen.writeEndObject();
            }
            if(segmentData[i][0].equals('BPR')){
                segmentDataSize = segmentData[i].size();
                gen.writeFieldName('finacialInfo');
                gen.writeStartObject();
                gen.writeObjectField('transactionHandlingCode', segmentDataSize > 1 ? segmentData[i][1] : '');
                gen.writeObjectField('transactionHandlingCodeText', segmentDataSize > 1 ? EDI835DataMappings.getPaymentMethod(segmentData[i][1]) : '');
                gen.writeObjectField('totalActualProviderPaymentAmount', segmentDataSize > 2 ? segmentData[i][2] : '');
                gen.writeObjectField('creditDebitFlag', segmentDataSize > 3 ? segmentData[i][3] : '');
                gen.writeObjectField('creditDebitFlagText', segmentDataSize > 3 ? EDI835DataMappings.getcreditDebitFlagText(segmentData[i][3]) : '');
                gen.writeObjectField('paymentMethodCode', segmentDataSize > 4 ? segmentData[i][4] : '');
                gen.writeObjectField('paymentMethodCodeText', segmentDataSize > 4 ? EDI835DataMappings.getpaymentMethodCodeText(segmentData[i][4]) : '');
                gen.writeObjectField('paymentFormatCode', segmentDataSize > 5 ? segmentData[i][5] : '');
                gen.writeObjectField('paymentFormatCodeText', segmentDataSize > 5 ?  EDI835DataMappings.getPaymentFormat(segmentData[i][5]) : '');
                gen.writeObjectField('idNumberQualifier', segmentDataSize > 6 ? segmentData[i][6] : '');
                gen.writeObjectField('idNumberQualifierText', segmentDataSize > 6 ? EDI835DataMappings.getBPRIdentificationType(segmentData[i][6]) : '');
                gen.writeObjectField('identificationNumber', segmentDataSize > 7 ? segmentData[i][7] : '');
                gen.writeObjectField('accountNumberQualifier', segmentDataSize > 8 ? segmentData[i][8] : '');
                gen.writeObjectField('accountNumberQualifierText', segmentDataSize > 8 ? EDI835DataMappings.getAccNumberQualifier(segmentData[i][8]) : '');
                gen.writeObjectField('senderBankAccountNumber', segmentDataSize > 9 ? segmentData[i][9] : '');
                gen.writeObjectField('originatingCompanyIdentifier', segmentDataSize > 10 ? segmentData[i][10] : '');
                gen.writeObjectField('originatingCompanySupplementalCode', segmentDataSize > 11 ? segmentData[i][11] : '');
                gen.writeObjectField('dfiIdentificationNumberQualifier', segmentDataSize > 12 ? segmentData[i][12] : '');
                gen.writeObjectField('dfiIdentificationNumberQualifierText', segmentDataSize > 12 ? EDI835DataMappings.getBPRIdentificationType(segmentData[i][12] ) : '');
                gen.writeObjectField('receiverBankIdNumber', segmentDataSize > 13 ? segmentData[i][13] : '');
                gen.writeObjectField('acountNumberQualifier', segmentDataSize > 14 ?  segmentData[i][14] : '');
                gen.writeObjectField('accountNumberQualifierText', segmentDataSize > 14 ? EDI835DataMappings.getAccNumberQualifier(segmentData[i][14]) : '');
                gen.writeObjectField('receiverAccountNumber', segmentDataSize > 15 ? segmentData[i][15] : '');
                gen.writeObjectField('checkIssueOrEftEffectiveDate', segmentDataSize > 16 ? segmentData[i][16] : '');
                gen.writeEndObject();
            }
            if(segmentData[i][0].equals('TRN')){
                segmentDataSize = segmentData[i].size();
                gen.writeFieldName('transInfo');
                gen.writeStartObject();
                gen.writeObjectField('traceTypeCode', segmentDataSize > 1 ? segmentData[i][1] : '');
                gen.writeObjectField('traceTypeCodeText', segmentDataSize > 1 ? EDI835DataMappings.getTRNCode(segmentData[i][1]) : '');
                gen.writeObjectField('currentTransactionTraceNumber', segmentDataSize > 2 ? segmentData[i][2] : '');
                gen.writeObjectField('OriginatingCompanyIdentifier', segmentDataSize > 3 ? segmentData[i][3] : '');
                gen.writeObjectField('originatingCompanySupplementalCode', segmentDataSize > 4 ?  segmentData[i][4] : '');
                gen.writeEndObject();
            }
            if(segmentData[i][0].equals('REF') && segmentData[i][1].equals('EV')){
                segmentDataSize = segmentData[i].size();
                gen.writeFieldName('receiverIdentification');
                gen.writeStartObject();
                gen.writeObjectField('referenceIdentificationQualifier', segmentDataSize > 1 ? segmentData[i][1] : '');
                gen.writeObjectField('referenceIdentificationQualifierText', segmentDataSize > 1 ? EDI835DataMappings.getREFInfo(segmentData[i][1]) : '');
                gen.writeObjectField('memberGrouporPolicyNumber', segmentDataSize > 2 ? segmentData[i][2] : '');
                gen.writeEndObject();
            }
            if(segmentData[i][0].equals('DTM') && segmentData[i][1].contains('405')){
                segmentDataSize = segmentData[i].size();
                gen.writeFieldName('productionDate');
                gen.writeStartObject();
                gen.writeObjectField('dateTimeQualifier', segmentDataSize > 1 ? segmentData[i][1] : '');
                gen.writeObjectField('dateTimeQualifierText', segmentDataSize > 1 ? EDI835DataMappings.getDTMDateType(segmentData[i][1]) : '');
                gen.writeObjectField('productionDate', segmentDataSize > 2 ? segmentData[i][2] : '');
                gen.writeEndObject();
            }
            
            if(segmentData[i][0].equals('N1') && segmentData[i][1].contains('PR')){
                segmentDataSize = segmentData[i].size();
                gen.writeFieldName('payer');
                gen.writeStartObject();
                gen.writeObjectField('payerIdentifierCode', segmentDataSize > 1 ? segmentData[i][1] : '');
                gen.writeObjectField('payerIdentifierCodeText', segmentDataSize > 1 ? EDI835DataMappings.getN1IdentificationCode(segmentData[i][1]) : '');
                gen.writeObjectField('payerName', segmentDataSize > 2 ? segmentData[i][2] : '');
                gen.writeObjectField('identificationCodeQualifer', segmentDataSize > 3 ? segmentData[i][3] : '');
                gen.writeObjectField('identificationCodeQualiferText', segmentDataSize > 3 ? EDI835DataMappings.getN1IdentificationCode(segmentData[i][3]) : '');
                gen.writeObjectField('payerIdentificationCode', segmentDataSize > 4 ? segmentData[i][4] : '');
                gen.writeEndObject();
                for(Integer j = i+1; j< segmentData.size();j++){
                    if(segmentData[j][0].equals('PER')){ 
                        break;
                    }
                    if(segmentData[j][0].equals('N3')){
                        segmentDataSize = segmentData[j].size();
                        gen.writeFieldName('payerAddress');
                        gen.writeStartObject();
                        gen.writeObjectField('address1', segmentDataSize > 1 ?  segmentData[j][1] : '');
                        gen.writeObjectField('address2', segmentDataSize > 2 ?  segmentData[j][2] : '');
                        gen.writeEndObject();
                    }
                    if(segmentData[j][0].equals('N4')){
                        segmentDataSize = segmentData[j].size();
                        gen.writeFieldName('payerLocation');
                        gen.writeStartObject();
                        gen.writeObjectField('city', segmentDataSize > 1 ? segmentData[j][1] : '');
                        gen.writeObjectField('state',segmentDataSize > 2 ? segmentData[j][2] : '');
                        gen.writeObjectField('zipCode', segmentDataSize > 3 ? segmentData[j][3].substring(0,5) : '');
                        gen.writeObjectField('zip4', segmentDataSize > 3 ? segmentData[j][3].substring(5) : '');
                        gen.writeEndObject();
                    }
                    if(segmentData[j][0].equals('REF') && payerREFCount == 0){
                        gen.writeFieldName('payerAdditionalInfo');
                        gen.writeStartArray();
                        for(Integer k = j ; k < segmentData.size(); k++){
                            if(segmentData[k][0].equals('PER')){
                                break;
                            }
                            if(segmentData[k][0].equals('REF')){
                                segmentDataSize = segmentData[k].size();
                                gen.writeStartObject();
                                gen.writeObjectField('payerReferenceIdentication', segmentDataSize > 1 ? segmentData[k][1] : '');
                                gen.writeObjectField('payerReferenceIdenticationText', segmentDataSize > 1 ?EDI835DataMappings.getREFInfo(segmentData[k][1]) : '');
                                gen.writeObjectField('payerIdenticationNumber', segmentDataSize > 2 ? segmentData[k][2] : '');
                                gen.writeEndObject();
                            }
                            
                        }
                        gen.writeEndArray();
                        payerREFCount++;
                    }
                }
            }
            if(segmentData[i][0].equals('PER')){
                
                if(segmentData[i][1].contains('CX')){
                    segmentDataSize = segmentData[i].size();
                    gen.writeFieldName('payerContactInfo');
                    gen.writeStartObject();
                    gen.writeObjectField('contactFunctionCode', segmentDataSize > 1 ? segmentData[i][1] : '');
                    gen.writeObjectField('contactFunctionCodeText', segmentDataSize > 1 ? EDI835DataMappings.getPERContactFunctionCodeText(segmentData[i][1]) : '');
                    gen.writeObjectField('payerContactName', segmentDataSize > 2 ? segmentData[i][2] : '');
                    gen.writeObjectField('communitcationNumberQualifier1', segmentDataSize > 3 ? segmentData[i][3] : '');
                    gen.writeObjectField('communitcationNumberQualifierText', segmentDataSize > 3 ?  EDI835DataMappings.getPERInfo(segmentData[i][3]) : '');
                    gen.writeObjectField('responseContactCommunication', segmentDataSize > 4 ? segmentData[i][4] : '');
                    gen.writeObjectField('communitcationNumberQualifier2', segmentDataSize > 5 ? segmentData[i][5] : '');
                    gen.writeObjectField('communitcationNumberQualifierText', segmentDataSize > 5 ?  EDI835DataMappings.getPERInfo(segmentData[i][5]) : '');
                    gen.writeObjectField('responseContactCommunication', segmentDataSize > 6 ? segmentData[i][6] : '');
                    gen.writeObjectField('communitcationNumberQualifier3', segmentDataSize > 7 ? segmentData[i][7] : '');
                    gen.writeObjectField('communitcationNumberQualifierText', segmentDataSize > 7 ?  EDI835DataMappings.getPERInfo(segmentData[i][7]) : '');
                    gen.writeObjectField('responseContactCommunication', segmentDataSize > 8 ? segmentData[i][8] : '');
                    gen.writeEndObject();
                }
                else if(segmentData[i][1].contains('BL')){
                    segmentDataSize = segmentData[i].size();
                    gen.writeFieldName('payerTechnicalContactInfo');
                    gen.writeStartObject();
                    gen.writeObjectField('contactFunctionCode', segmentDataSize > 1 ? segmentData[i][1] : '');
                    gen.writeObjectField('contactFunctionCodeText', segmentDataSize > 1 ?  EDI835DataMappings.getPERContactFunctionCodeText(segmentData[i][1]) : '');
                    gen.writeObjectField('payerTechnicalName',  segmentDataSize > 2 ? segmentData[i][2] : '');
                    gen.writeObjectField('communitcationNumberQualifier1', segmentDataSize > 3 ? segmentData[i][3] : '');
                    gen.writeObjectField('communitcationNumberQualifierText', segmentDataSize > 3 ?  EDI835DataMappings.getPERInfo(segmentData[i][3]) : '');
                    gen.writeObjectField('responseContactCommunication', segmentDataSize > 4 ? segmentData[i][4] : '');
                    gen.writeObjectField('communitcationNumberQualifier2', segmentDataSize > 5 ? segmentData[i][5] : '');
                    gen.writeObjectField('communitcationNumberQualifierText', segmentDataSize > 5 ?  EDI835DataMappings.getPERInfo(segmentData[i][5]) : '');
                    gen.writeObjectField('responseContactCommunication', segmentDataSize > 6 ? segmentData[i][6] : '');
                    gen.writeObjectField('communitcationNumberQualifier3', segmentDataSize > 7 ? segmentData[i][7] : '');
                    gen.writeObjectField('communitcationNumberQualifierText', segmentDataSize > 7 ?  EDI835DataMappings.getPERInfo(segmentData[i][7]) : '');
                    gen.writeObjectField('responseContactCommunication', segmentDataSize > 8 ? segmentData[i][8] : '');
                    gen.writeEndObject();
                }    
            }
            if(segmentData[i][0].equals('N1') && segmentData[i][1].contains('PE')){
                segmentDataSize = segmentData[i].size();
                gen.writeFieldName('payee');
                gen.writeStartObject();
                gen.writeObjectField('payeeIdentifierCode', segmentDataSize > 1 ? segmentData[i][1] : '');
                gen.writeObjectField('payeeIdentifierCodeText', segmentDataSize > 1 ? EDI835DataMappings.getN1IdentificationCode(segmentData[i][1]) : '');
                gen.writeObjectField('payeeName', segmentDataSize > 2 ? segmentData[i][2] : '');
                gen.writeObjectField('identificationCodeQualifer', segmentDataSize > 3 ? segmentData[i][3] : '');
                gen.writeObjectField('identificationCodeQualiferText', segmentDataSize > 3 ? EDI835DataMappings.getN1IdentificationCode(segmentData[i][3]) : '');
                gen.writeObjectField('payeeIdentificationCode', segmentDataSize > 4 ? segmentData[i][4] : '');
                gen.writeEndObject();
                for(Integer j = i+1; j< segmentData.size();j++){
                    if(segmentData[j][0].equals('LX')){ 
                        break;
                    }
                    if(segmentData[j][0].equals('N3')){
                        segmentDataSize = segmentData[j].size();
                        gen.writeFieldName('payeeAddress');
                        gen.writeStartObject();
                        gen.writeObjectField('address1', segmentDataSize > 1 ? segmentData[j][1] : '');
                        gen.writeObjectField('address2', segmentDataSize > 2 ? segmentData[j][2] : '');
                        gen.writeEndObject();
                    }
                    if(segmentData[j][0].equals('N4')){
                        segmentDataSize = segmentData[j].size();
                        gen.writeFieldName('payeeLocation');
                        gen.writeStartObject();
                        gen.writeObjectField('city', segmentDataSize > 1 ? segmentData[j][1] : '');
                        gen.writeObjectField('state', segmentDataSize > 2 ? segmentData[j][2] : '');
                        gen.writeObjectField('zipCode', segmentDataSize > 3 ? segmentData[j][3].substring(0,5) :'');
                        gen.writeObjectField('zip4', segmentDataSize > 3 ? segmentData[j][3].substring(5) :'');
                        gen.writeEndObject();
                    }
                    if(segmentData[j][0].equals('REF') &&  payeeREFCount== 0 ){
                        gen.writeFieldName('payeeAdditionalInfo');
                        gen.writeStartArray();
                        for(Integer k = j ; k < segmentData.size(); k++){
                            if(segmentData[k][0].equals('LX')){
                                break;
                            }
                            if(segmentData[k][0].equals('REF')){
                                segmentDataSize = segmentData[k].size();
                                gen.writeStartObject();
                                gen.writeObjectField('payeeReferenceIdentication', segmentDataSize > 1 ? segmentData[k][1] : '');
                                gen.writeObjectField('payeeReferenceIdenticationText', segmentDataSize > 1 ? EDI835DataMappings.getREFInfo(segmentData[k][1]) : '');
                                gen.writeObjectField('payeeIdenticationNumber', segmentDataSize > 2 ? segmentData[k][2] : '');
                                gen.writeEndObject();
                            }
                            
                        }
                        gen.writeEndArray();
                        payeeREFCount++;
                        break;
                    }
                }
            }
            
            if(segmentData[i][0].equals('LX')){
                segmentDataSize = segmentData[i].size();
                gen.writeFieldName('lx');
                gen.writeStartObject();
                gen.writeObjectField('serviceLine', segmentDataSize > 1 ? segmentData[i][1] : '');
                gen.writeEndObject();
            }
            if(segmentData[i][0].equals('TS3')){ break; }
            if(segmentData[i][0].equals('CLP')){ break; }
        }
        
        gen.writeEndObject();
        gen.writeEndArray();
        
        for(List<String> segment: segmentData){
            if(segment[0].equals('TS3')){
                segmentDataSize = segment.size();
                gen.writeFieldName('providerSummaryInformation');
                gen.writeStartObject();
                gen.writeObjectField('providerIdentifier', segmentDataSize > 1 ? segment[1] : '');
                gen.writeObjectField('facilityTypeCode', segmentDataSize > 2 ?  segment[2] : '');
                gen.writeObjectField('facilityTypeCodeText', segmentDataSize > 2 ?  EDI835DataMappings.getTS3FacilityTypeCode(segment[2]) : '');
                gen.writeObjectField('fiscalPeriodDate', segmentDataSize > 3 ? segment[3] : '');
                gen.writeObjectField('totalClaimCount',segmentDataSize > 4 ?  segment[4] : '');
                gen.writeObjectField('totalClaimChargeAmount',segmentDataSize > 5 ?  segment[5] : '');
                gen.writeEndObject();
            }
            if(segment[0].equals('CLP')){ break; }
        }
        gen.writeFieldName('claims');
        gen.writeStartArray(); 
        List<List<String>> duplicateClaims = new List<List<String>>();
        for(Integer i = 0 ;i < segmentData.size() ;i++){
            Integer claimREFcnt = 0;
            Integer claimsDTMcount = 0;
            Integer refSVCCount =0;
            if(segmentData[i][0].equals('CLP')  && !duplicateClaims.contains(segmentData[i])){
                segmentDataSize = segmentData[i].size();
                duplicateClaims.add(segmentData[i]);
                gen.writeStartObject();
                gen.writeObjectField('patientClaimControlNumber', segmentDataSize > 1 ? segmentData[i][1]: '');
                gen.writeObjectField('patientClaimStatusCode', segmentDataSize > 2 ?  segmentData[i][2]: '');
                gen.writeObjectField('patientClaimStatusCodeText', segmentDataSize > 2 ?  EDI835DataMappings.getClaimStatusDescription(segmentData[i][2]): '');
                gen.writeObjectField('totalClaimChargeAmount', segmentDataSize > 3 ?  segmentData[i][3]: '');
                gen.writeObjectField('totalAmountPaid', segmentDataSize > 4 ? segmentData[i][4]: '');
                gen.writeObjectField('patientResponsibilityAmount',  segmentDataSize > 5 ?  segmentData[i][5]: '');
                gen.writeObjectField('patientClaimFilingIndicatorCode', segmentDataSize > 6 ?  segmentData[i][6]: '');
                gen.writeObjectField('patientClaimFilingIndicatorCodetext', segmentDataSize > 6 ?  EDI835DataMappings.getpatientClaimIndicatorText(segmentData[i][6]): '');
                gen.writeObjectField('payerClaimControlNumber', segmentDataSize > 7 ?  segmentData[i][7]: '');
                gen.writeObjectField('facilityTypeCode', segmentDataSize > 8 ?  segmentData[i][8]: '');
                gen.writeObjectField('facilityTypeCodeText', segmentDataSize > 8 ? EDI835DataMappings.getCLPFacilityTypeCode(segmentData[i][8]) : '');
                gen.writeObjectField('claimFrequencyCode', segmentDataSize > 9 ?  segmentData[i][9]: '');
                gen.writeObjectField('claimFrequencyCodeText', segmentDataSize > 9 ?  EDI835DataMappings.getClaimFrequencyCode(segmentData[i][9]): '');
                
                for( Integer j = i + 1 ; j< segmentData.size();j++){
                    if(segmentData[j][0].equals('CLP')  && !duplicateClaims.contains(segmentData[j])){
                        break;
                    }
                    if(segmentData[j][0].equals('NM1') && segmentData[j][1].contains('QC')){
                        segmentDataSize = segmentData[j].size();
                        gen.writeFieldName('patient');
                        gen.writeStartObject();
                        gen.writeObjectField('entityIdentifierCode', segmentDataSize > 1 ? segmentData[j][1] : '');
                        gen.writeObjectField('entityIdentifierCodeText', segmentDataSize > 1 ? EDI835DataMappings.getNM1SegmentCodes(segmentData[j][1]) : '');
                        gen.writeObjectField('lastName', segmentDataSize > 3 ? segmentData[j][3] : '');
                        gen.writeObjectField('firstName', segmentDataSize > 4 ? segmentData[j][4] : '');
                        gen.writeObjectField('middleInitial',  segmentDataSize > 5 ? segmentData[j][5] : ''); 
                        gen.writeObjectField('namePrefix',  segmentDataSize > 6 ? segmentData[j][6] : ''); 
                        gen.writeObjectField('nameSuffix',  segmentDataSize > 7 ? segmentData[j][7] : ''); 
                        gen.writeObjectField('identificationCodeQualifier',  segmentDataSize > 8 ? segmentData[j][8] : ''); 
                        gen.writeObjectField('identificationCodeQualifierText',  segmentDataSize > 8 ? EDI835DataMappings.getNM1SegmentCodes(segmentData[j][8]) : ''); 
                        gen.writeObjectField('memberNumber',  segmentDataSize > 9 ? segmentData[j][9] : ''); 
                        gen.writeEndObject();                        
                    }
                    if(segmentData[j][0].equals('NM1') && segmentData[j][1].contains('82')){
                        segmentDataSize = segmentData[j].size();
                        gen.writeFieldName('insured');
                        gen.writeStartObject();
                        gen.writeObjectField('entityIdentifierCode', segmentDataSize > 1 ? segmentData[j][1] : '');
                        gen.writeObjectField('entityIdentifierCodeText', segmentDataSize > 1 ? EDI835DataMappings.getNM1SegmentCodes(segmentData[j][1]) : '');
                        gen.writeObjectField('entityIdentifierCode', segmentDataSize > 1 ? segmentData[j][1] : '');
                        gen.writeObjectField('EntityTypeQualifier', segmentDataSize > 2 ? segmentData[j][2] : '');
                        gen.writeObjectField('organizationName', segmentDataSize > 3 ? segmentData[j][3] : '');
                        gen.writeObjectField('responseContactFirstName', segmentDataSize > 4 ? segmentData[j][4] : '');
                        gen.writeObjectField('responseContactMiddleName', segmentDataSize > 5 ? segmentData[j][5] : '');
                        gen.writeObjectField('namePrefix', segmentDataSize > 6 ? segmentData[j][6] : '');
                        gen.writeObjectField('responseContactNameSuffix', segmentDataSize > 7 ? segmentData[j][7] : '');
                        gen.writeObjectField('identificationCodeQualifier', segmentDataSize > 8 ? segmentData[j][8] : '');
                        gen.writeObjectField('providerNumber', segmentDataSize > 9 ? segmentData[j][9] : '');
                        gen.writeEndObject();                        
                    }
                    if(segmentData[j][0].equals('NM1') && segmentData[j][1].contains('74')){
                        segmentDataSize = segmentData[j].size();
                        gen.writeFieldName('correctedPatientOrinsuredName');
                        gen.writeStartObject();
                        gen.writeObjectField('entityIdentifierCode', segmentDataSize > 1 ? segmentData[j][1] : '');
                        gen.writeObjectField('entityIdentifierCodeText', segmentDataSize > 1 ? EDI835DataMappings.getNM1SegmentCodes(segmentData[j][1]) : '');
                        gen.writeObjectField('EntityTypeQualifier', segmentDataSize > 2 ? segmentData[j][2] : '');
                        gen.writeObjectField('responseContactLastorOrganizationName', segmentDataSize > 3 ? segmentData[j][3] : '');
                        gen.writeObjectField('responseContactFirstName', segmentDataSize > 4 ? segmentData[j][4] : '');
                        gen.writeObjectField('responseContactMiddleName', segmentDataSize > 5 ? segmentData[j][5] : '');
                        gen.writeObjectField('namePrefix', segmentDataSize > 6 ? segmentData[j][6] : '');
                        gen.writeObjectField('responseContactNameSuffix', segmentDataSize > 7 ? segmentData[j][7] : '');
                        gen.writeObjectField('identificationCodeQualifier', segmentDataSize > 8 ? segmentData[j][8] : '');
                        gen.writeObjectField('responseContactIdentifier', segmentDataSize > 9 ? segmentData[j][9] : '');
                        gen.writeEndObject();                        
                    }
                    if(segmentData[j][0].equals('MOA')){
                        segmentDataSize = segmentData[j].size();
                        gen.writeFieldName('outpatientAdjudicationInformation');
                        gen.writeStartObject();
                        gen.writeObjectField('reimbursementRate', segmentDataSize > 1 ? segmentData[j][1] : '');
                        gen.writeObjectField('HCPCSPayableAmount', segmentDataSize > 2 ? segmentData[j][2] : '');
                        gen.writeObjectField('claimPaymentRemarkCode1', segmentDataSize > 3 ? segmentData[j][3] : '');
                        gen.writeObjectField('claimPaymentRemarkCode1Text', segmentDataSize > 3 ? EDI835DataMappings.getCASandMOAGroupCode(segmentData[j][3]) : '');
                        gen.writeObjectField('claimPaymentRemarkCode2', segmentDataSize > 4 ? segmentData[j][4] : '');
                        gen.writeObjectField('claimPaymentRemarkCode2Text', segmentDataSize > 4 ? EDI835DataMappings.getCASandMOAGroupCode(segmentData[j][4]) : '');
                        gen.writeObjectField('claimPaymentRemarkCode3', segmentDataSize > 5 ? segmentData[j][5] : '');
                        gen.writeObjectField('claimPaymentRemarkCode3Text', segmentDataSize > 5 ? EDI835DataMappings.getCASandMOAGroupCode(segmentData[j][5]) : '');
                        gen.writeObjectField('claimPaymentRemarkCode4', segmentDataSize > 6 ? segmentData[j][6] : '');
                        gen.writeObjectField('claimPaymentRemarkCode4Text', segmentDataSize > 6 ? EDI835DataMappings.getCASandMOAGroupCode(segmentData[j][6]) : '');
                        gen.writeObjectField('monetaryAmount', segmentDataSize > 7 ? segmentData[j][7] : '');
                        gen.writeEndObject();  
                    }
                    if(segmentData[j][0].equals('REF') && claimREFcnt == 0){
                        gen.writeFieldName('serviceIdentification');
                        gen.writeStartArray();
                        for(Integer l=j;l<segmentData.size();l++){
                            if(segmentData[l][0].equals('SVC')){
                                break;
                            }
                            if( segmentData[l][0].equals('REF')){
                                segmentDataSize = segmentData[l].size();
                                gen.writeStartObject();
                                gen.writeObjectField('referenceIdentificationQualifier',segmentDataSize > 1 ? segmentData[l][1] : '');
                                gen.writeObjectField('referenceIdentificationQualifierText',segmentDataSize > 1 ? EDI835DataMappings.getREFInfo(segmentData[l][1]): '');
                                gen.writeObjectField('memberGrouporPolicyNumber',segmentDataSize > 2 ? segmentData[l][2] : '');
                                gen.writeEndObject(); 
                            }
                        }
                        gen.writeEndArray();
                        claimREFcnt++;
                    }
                    if(segmentData[j][0].equals('DTM') && claimsDTMcount == 0){
                        gen.writeFieldName('allDTM');
                        gen.writeStartArray();
                        for(Integer l = j ; l < segmentData.size(); l++){
                            if(segmentData[l][0].equals('SVC')){
                                break;
                            }if(segmentData[l][0].equals('DTM')){
                                segmentDataSize = segmentData[l].size();
                                gen.writeStartObject();
                                gen.writeObjectField('dateTimeQualifier',segmentDataSize > 1 ? segmentData[l][1] : '');
                                gen.writeObjectField('dateTimeQualifierText',segmentDataSize > 1 ? EDI835DataMappings.getDTMDateType(segmentData[l][1]) : '');
                                gen.writeObjectField('date',segmentDataSize > 2 ? segmentData[l][2] : '');
                                gen.writeEndObject(); 
                            }
                        }
                        claimsDTMcount++;
                        gen.writeEndArray();
                    }
                    if(segmentData[j][0].equals('PER')){
                        gen.writeFieldName('claimContactInformation');
                        gen.writeStartArray();
                        for(Integer l = j ; l < segmentData.size(); l++){
                            if(segmentData[l][0].equals('SVC')){
                                break;
                            }
                            if(segmentData[l][0].equals('PER')){
                                segmentDataSize = segmentData[l].size();
                                gen.writeStartObject();
                                gen.writeObjectField('contactFunctionCode',segmentDataSize > 1 ?  segmentData[l][1] : '');
                                gen.writeObjectField('contactFunctionCodeText',segmentDataSize > 1 ?  EDI835DataMappings.getPERContactFunctionCodeText(segmentData[l][1]) : '');
                                gen.writeObjectField('contactName', segmentDataSize > 2 ? segmentData[l][2] : '');
                                gen.writeObjectField('communitcationNumberQualifier1', segmentDataSize > 3 ? segmentData[l][3] : '');
                                gen.writeObjectField('communitcationNumberQualifierText', segmentDataSize > 3 ?  EDI835DataMappings.getPERInfo(segmentData[l][3]) : '');
                                gen.writeObjectField('responseContactCommunication', segmentDataSize > 4 ? segmentData[l][4] : '');
                                gen.writeObjectField('communitcationNumberQualifier2', segmentDataSize > 5 ? segmentData[l][5] : '');
                                gen.writeObjectField('communitcationNumberQualifierText', segmentDataSize > 5 ?  EDI835DataMappings.getPERInfo(segmentData[l][5]) : '');
                                gen.writeObjectField('responseContactCommunication', segmentDataSize > 6 ? segmentData[l][6] : '');
                                gen.writeObjectField('communitcationNumberQualifier3', segmentDataSize > 7 ? segmentData[l][7] : '');
                                gen.writeObjectField('communitcationNumberQualifierText', segmentDataSize > 7 ?  EDI835DataMappings.getPERInfo(segmentData[l][7]) : '');
                                gen.writeObjectField('responseContactCommunication', segmentDataSize > 8 ? segmentData[l][8] : '');
                                gen.writeEndObject();
                            }
                        }
                        gen.writeEndArray();
                    }
                    if(segmentData[j][0].equals('AMT')){
                        gen.writeFieldName('claimSupplementalInformation');
                        gen.writeStartArray();
                        for(Integer l = j ; l < segmentData.size(); l++){
                            if(segmentData[l][0].equals('CLP')){
                                break;
                            }
                            if(segmentData[l][0].equals('AMT')){
                                segmentDataSize = segmentData[l].size();
                                gen.writeStartObject();
                                gen.writeObjectField('amountQualifierCode',segmentDataSize > 1 ?  segmentData[l][1] : '');
                                gen.writeObjectField('amountQualifierCodeText', segmentDataSize > 1 ? EDI835DataMappings.getAmountText(segmentData[l][1]) : '');
                                gen.writeObjectField('totalClaimChargeAmount',segmentDataSize > 2 ?  segmentData[l][2] : '');
                                gen.writeEndObject();
                            }
                        }
                        gen.writeEndArray();
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
                                segmentDataSize = segmentData[k].size();
                                String[] parts = segmentData[k][1].split(':');
                                gen.writeObjectField('serviceTypeCode',  parts[0]);
                                gen.writeObjectField('serviceCode',segmentDataSize > 1 ?  parts[1] : '');
                                gen.writeObjectField('modifier1', parts.size()> 2? parts[2] : '');
                                gen.writeObjectField('modifier2', parts.size()> 3? parts[3] : '');
                                gen.writeObjectField('modifier3', parts.size()> 4? parts[4] : '');
                                gen.writeObjectField('modifier4', parts.size()> 5? parts[5] : '');
                                gen.writeObjectField('serviceChargeAmt',segmentDataSize > 2 ? segmentData[k][2] : '');
                                gen.writeObjectField('providerPymentAmt',segmentDataSize > 3 ? segmentData[k][3] : '');
                                gen.writeObjectField('revenueCode',segmentDataSize > 4 ? segmentData[k][4] : '');
                                gen.writeObjectField('quantity',segmentDataSize > 5 ? segmentData[k][5] : '');
                                gen.writeObjectField('unitsofServiceCount',segmentDataSize > 7 ? segmentData[k][7] : '');
                                gen.writeFieldName('service');
                                gen.writeStartArray();
                                for(Integer l = k+1 ; l < segmentData.size(); l++){
                                    if(segmentData[l][0].equals('SVC') && dtmCountOfsvc == 0){
                                        dtmCountOfsvc++;
                                        break;
                                    }if(segmentData[l][0].equals('CLP')){
                                        dtmCountOfsvc = 0;
                                        break;
                                    }
                                    if( segmentData[l][0].equals('DTM')){
                                        
                                        segmentDataSize = segmentData[l].size();
                                        
                                        gen.writeStartObject();
                                        gen.writeObjectField('dateTimeQualifier',segmentDataSize > 1 ?  segmentData[l][1] : '');
                                        gen.writeObjectField('serviceDate',segmentDataSize > 2 ?  segmentData[l][2] : '');
                                        gen.writeEndObject();
                                    }
                                }
                                gen.writeEndArray();
                                
                                gen.writeFieldName('adjust');
                                gen.writeStartArray();
                                for(Integer l = k+1 ; l < segmentData.size(); l++){
                                    if(segmentData[l][0].equals('SVC')){
                                        break;
                                    }
                                    if(segmentData[l][0].equals('CAS')){
                                        segmentDataSize = segmentData[l].size();
                                        gen.writeStartObject();
                                        gen.writeObjectField('claimAdjustmentGroupCode',segmentDataSize > 1 ? segmentData[l][1] : '');
                                        gen.writeObjectField('claimAdjustmentGroupCodeText',segmentDataSize > 1 ? EDI835DataMappings.getCASandMOAGroupCode(segmentData[l][1]): '');
                                        gen.writeObjectField('adjustmentCodeReason',segmentDataSize > 2 ? segmentData[l][2] : '');
                                        gen.writeObjectField('adjustmentCodeReasonText', segmentDataSize > 2 ? EDI835DataMappings.getAdjustmentReason(segmentData[l][2]):'');
                                        gen.writeObjectField('adjustmentAmt',segmentDataSize > 3 ? segmentData[l][3] : '');
                                        gen.writeObjectField('adjustmentQuantity',segmentDataSize > 4 ? segmentData[l][4] : '');
                                        gen.writeObjectField('additionaladjustmentGroupCode', segmentDataSize > 5 ? segmentData[l][5] : '');
                                        gen.writeObjectField('additionalAdjustmentGroupCodeText',segmentDataSize > 5 ? EDI835DataMappings.getCASandMOAGroupCode(segmentData[l][5]): '');
                                        gen.writeObjectField('additionaladjustmentCodeReason',segmentDataSize > 6 ? segmentData[l][6] : '');
                                        gen.writeObjectField('additionaladjustmentCodeReasonText', segmentDataSize > 6? EDI835DataMappings.getAdjustmentReason(segmentData[l][6]):'');
                                        gen.writeObjectField('additionaladjustmentQuantity',segmentDataSize > 7 ? segmentData[l][7] : '');
                                        gen.writeEndObject(); 
                                    }
                                }
                                gen.writeEndArray();
                                gen.writeFieldName('serviceIdentification');
                                gen.writeStartArray();
                                for(Integer l=K+1;l<segmentData.size();l++){
                                    if(segmentData[l][0].equals('SVC') && refSVCCount == 0){
                                        refSVCCount++;
                                        break; 
                                    }
                                    if(segmentData[l][0].equals('CLP')){
                                        break;
                                    }
                                    if( segmentData[l][0].equals('REF')){
                                        segmentDataSize = segmentData[l].size();
                                        gen.writeStartObject();
                                        gen.writeObjectField('referenceIdentificationQualifier',segmentDataSize > 1 ? segmentData[l][1] : '');
                                        gen.writeObjectField('referenceIdentificationQualifierText',segmentDataSize > 1 ? EDI835DataMappings.getREFInfo(segmentData[l][1]): '');
                                        gen.writeObjectField('referenceIdentification',segmentDataSize > 2 ? segmentData[l][2] : '');
                                        gen.writeEndObject(); 
                                    }
                                }
                                gen.writeEndArray();
                                
                                gen.writeFieldName('amt_ServiceSupplementalAmount');
                                gen.writeStartArray();
                                for(Integer l = k+1 ; l < segmentData.size(); l++){
                                    if(segmentData[l][0].equals('SVC')){
                                        break;
                                    }
                                    if(segmentData[l][0].equals('AMT')){
                                        segmentDataSize = segmentData[l].size();
                                        gen.writeStartObject();
                                        gen.writeObjectField('amountQualifierCode',segmentDataSize > 1 ?  segmentData[l][1] : '');
                                        gen.writeObjectField('amountQualifierCodeText', segmentDataSize > 1 ? EDI835DataMappings.getAmountText(segmentData[l][1]) : '');
                                        gen.writeObjectField('amount',segmentDataSize > 2 ?  segmentData[l][2] : '');
                                        gen.writeEndObject();
                                    }
                                }
                                gen.writeEndArray();
                                
                                gen.writeFieldName('lq_HealthCareRemarkCodes');
                                gen.writeStartArray();
                                for(Integer l = k+1 ; l < segmentData.size(); l++){
                                    if(segmentData[l][0].equals('SVC')){
                                        break;
                                    }
                                    if(segmentData[l][0].equals('LQ')){
                                        segmentDataSize = segmentData[l].size();
                                        gen.writeStartObject();
                                        gen.writeObjectField('codeListQualifierCode',segmentDataSize > 1 ?  segmentData[l][1] : '');
                                        gen.writeObjectField('codeListQualifierCodeText',segmentDataSize > 1 ?  EDI835DataMappings.getHealthCareRemarkCodes(segmentData[l][1]) : '');
                                        gen.writeObjectField('formIdentifier',segmentDataSize > 2 ?  segmentData[l][2] : '');
                                        gen.writeObjectField('formIdentifierText', segmentDataSize > 2 ? EDI835DataMappings.getFormatText(segmentData[l][2]) : '');
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
        string jsonString = JSON.serializePretty(jsonData);
        return jsonData;
    }
}