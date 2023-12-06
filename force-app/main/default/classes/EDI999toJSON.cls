public class EDI999toJSON {
    public static String parseEDI999toJSON(String ediString) {
        String ediMessage = ediString.replaceAll('~(\\n|\\r\\n|\\r|\\s)+', '~');
        List<String> segmentList = ediMessage.split('~');
        List<List<String>> segmentData= new List<List<String>>();
        Integer segmentDataSize = null;
        Integer ak2index = 0;
        Integer ak9index = 0;
        List<List<String>> duplicateAK2 = new List<List<String>>();
        JSONGenerator gen = JSON.createGenerator(true);
        
        for(string str: segmentList){
            segmentData.add(str.split('\\*'));
        }
        gen.writeStartObject();     
        gen.writeFieldName('Elixir');
        gen.writeStartArray();  
        gen.writeStartObject();
        gen.writeFieldName('RawData');
        gen.writeStartArray(); 
        
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
                gen.writeObjectField('usageIndicatorText',segmentDataSize > 15 ? EDI835DataMappings.getISAUsageIndicatorText(segmentData[i][15]) : '');
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
                gen.writeObjectField('transactionSetControlNumber', segmentDataSize > 2 ? segmentData[i][2] : '');
                gen.writeObjectField('implementationConventionPreference', segmentDataSize > 3 ? segmentData[i][3] : '');
                gen.writeEndObject();
            }
            if(segmentData[i][0].equals('AK1')){
                segmentDataSize = segmentData[i].size();
                gen.writeFieldName('ak1');
                gen.writeStartObject();
                gen.writeObjectField('functionalIdentifierCode', segmentDataSize > 1 ?  segmentData[i][1] : '');
                gen.writeObjectField('functionalIdentifierCodeText', segmentDataSize > 1 ?  EDI835DataMappings.getHealthCareRemarkCodes(segmentData[i][1]) : '');
                gen.writeObjectField('groupControlNumber', segmentDataSize > 2 ? segmentData[i][2] : '');
                gen.writeObjectField('versionAndRelease', segmentDataSize > 3 ? segmentData[i][3] : '');
                gen.writeEndObject();
            }
            if(segmentData[i][0].equals('AK2')) { ak2index = i; break; }
        }
        //-----------------------------------------------------------------------AK2 Segment starts
        gen.writeFieldName('ak2');
        gen.writeStartArray();// AK2 array starts
        for(Integer i = ak2index ;i < segmentData.size() ;i++){
           Integer flag = 0;
            if(segmentData[i][0].equals('AK2') && !duplicateAK2.contains(segmentData[i]) ){
                
                gen.writeStartObject();// AK2 object starts
                segmentDataSize = segmentData[i].size();
                duplicateAK2.add(segmentData[i]);
                gen.writeObjectField('transactionSetIdentifierCode', segmentDataSize > 1 ?  segmentData[i][1] : '');
                gen.writeObjectField('transactionSetControlNumber', segmentDataSize > 2 ?  segmentData[i][2] : '');
                gen.writeObjectField('version', segmentDataSize > 3 ?  segmentData[i][3] : '');
                for( Integer j = i + 1 ; j< segmentData.size();j++){
                    if(segmentData[j][0].equals('AK2')  && !duplicateAK2.contains(segmentData[j])){  break; }
                    if(segmentData[j][0].equals('AK9')) { ak9index = i; break; }
                    
                    if(segmentData[j][0].equals('IK3') && flag == 0){
                        System.debug('Inside IK3 ouside condition');
                        gen.writeFieldName('errors');
                        gen.writeStartArray();//error Array Starts
                        
                        for(Integer k = j ; k < segmentData.size(); k++){
                            
                            if(segmentData[k][0].equals('AK2')){  break;   }
                            if((segmentData[k][0].equals('IK5')) || (segmentData[k][0].equals('AK9'))){  break; }
                            
                            if(segmentData[k][0].equals('IK3')){
                                flag++;
                                gen.writeStartObject();// Error Object Starts
                                segmentDataSize = segmentData[k].size();
                                gen.writeObjectField('IK3_segmentCode', segmentDataSize > 1 ?  segmentData[k][1] : '');
                                gen.writeObjectField('IK3_segmentCodeText', segmentDataSize > 1 ?  EDI999DataMappings.getIK3SegmentDescription(segmentData[k][1]) : '');
                                gen.writeObjectField('IK3_segmentLinePosition', segmentDataSize > 2 ?  segmentData[k][2] : '');
                                gen.writeObjectField('IK3_loopCode', segmentDataSize > 3 ?  segmentData[k][3] : '');
                                gen.writeObjectField('IK3_segmentErrorCode', segmentDataSize > 4 ?  segmentData[k][4] : '');
                                gen.writeObjectField('IK3_segmentErrorCodeText', segmentDataSize > 4 ?  EDI999DataMappings.getErrorMessage( segmentData[k][4]) : '');//Data Map
                                
                                if(segmentData[k+1][0].equals('IK4')){
                                    System.debug('Inside IK4');
                                    segmentDataSize = segmentData[k].size();
                                    gen.writeObjectField('IK4_fieldPositionInSegment', segmentDataSize > 1 ?  segmentData[k+1][1] : '');
                                    gen.writeObjectField('IK4_fieldDataElementRef', segmentDataSize > 2 ?  segmentData[k+1][2] : '');
                                    gen.writeObjectField('IK4_fieldErrorCode', segmentDataSize > 3 ?  segmentData[k+1][3] : '');
                                    gen.writeObjectField('IK4_fieldErrorCodeText', segmentDataSize > 4 ?  segmentData[k+1][4] : '');
                                    
                                }
                                gen.writeEndObject();// error Object Starts
                            }
                        }
                        gen.writeEndArray();//error Array ends
                    }
                    if(segmentData[j][0].equals('IK5')){
                        segmentDataSize = segmentData[j].size();
                        gen.writeObjectField('acknowledgementCode', segmentDataSize > 1 ?  segmentData[j][1] : '');
                        gen.writeObjectField('acknowledgementCodeText', segmentDataSize > 1 ?  EDI999DataMappings.getAcknowledgementCode(segmentData[j][1]) : '');
                    }
                }
                gen.writeEndObject(); // AK2 object ends
            }
        }
        gen.writeEndArray();//AK2 array ends here
        //---------------------------------------------------------------------------AK2 Loop Ends
        for(Integer i = ak9index ;i < segmentData.size() ;i++){
            if(segmentData[i][0].equals('AK9')){
                Integer count = 0;
                count++;
                
                segmentDataSize = segmentData[i].size();
                gen.writeFieldName('ak9');
                gen.writeStartObject();
                gen.writeObjectField('functionalGroupAcknowledgeCode', segmentDataSize > 1 ?  segmentData[i][1] : '');
                gen.writeObjectField('functionalGroupAcknowledgeCodeText', segmentDataSize > 1 ?  EDI999DataMappings.getAcknowledgementCode(segmentData[i][1]) : '');
                gen.writeObjectField('numberofTransactionSetsIncluded', segmentDataSize > 2 ? segmentData[i][2] : '');
                gen.writeObjectField('numberofReceivedTransactionSets', segmentDataSize > 3 ? segmentData[i][3] : '');
                gen.writeObjectField('numberofAcceptedTransactionSets', segmentDataSize > 4 ? segmentData[i][4] : '');
                gen.writeEndObject();
            }
            
            if(segmentData[i][0].equals('SE')){
                segmentDataSize = segmentData[i].size();
                gen.writeFieldName('se');
                gen.writeStartObject();
                gen.writeObjectField('numberofIncludedSegments', segmentDataSize > 1 ? segmentData[i][1] : '');
                gen.writeObjectField('transactionSetControlNumber', segmentDataSize > 2 ? segmentData[i][2] : '');
                gen.writeEndObject();
            }
            if(segmentData[i][0].equals('GE')){
                segmentDataSize = segmentData[i].size();
                gen.writeFieldName('getrailers');
                gen.writeStartObject();
                gen.writeObjectField('numberOfIncludedSets', segmentDataSize > 1 ? segmentData[i][1] : '');
                gen.writeObjectField('groupControlNumber', segmentDataSize > 2 ? segmentData[i][2] : '');
                gen.writeEndObject();
            }
            if(segmentData[i][0].equals('IEA')){
                segmentDataSize = segmentData[i].size();
                gen.writeFieldName('ieatrailers');
                gen.writeStartObject();
                gen.writeObjectField('numberOfIncludedGroups', segmentDataSize > 1 ? segmentData[i][1] : '');
                gen.writeObjectField('interchangeControlNumber', segmentDataSize > 2 ? segmentData[i][2] : '');
                gen.writeEndObject();
            }
        }
        gen.writeEndObject();
        gen.writeEndArray();
        gen.writeEndObject();
        gen.writeEndArray();
        gen.writeEndObject();
        String jsonData = gen.getAsString();
        System.debug(jsonData);
        return jsonData;
        
    }
}