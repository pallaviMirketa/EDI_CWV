public class calloutToClaimMdEDIERA {
    
    public static void entryPointToCallout(Set<id> claimIds){
        String body = EDI837PHandler.generateEDI837PMessage(claimIds);
        createDataStagingAndContentDoc(body);
        calloutToUpload837(body); 
    }
    @future(callout=true)
    public static void calloutToUpload837(String data) {
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://www.claim.md/services/upload/');
        request.setMethod('POST');
        request.setHeader('Content-Type', 'multipart/form-data; boundary=claim_info');
        
        String boundary = 'claim_info';
        String body = '--' + boundary + '\r\n';
        
        // Add the 'AccountKey' parameter
        body += 'Content-Disposition: form-data; name="AccountKey"\r\n\r\n';
        body += '8869fThoqjdYQelGBKQaYLwcyYdA' + '\r\n';
        
        // Add the 'File' parameter (XML file)
        body += '--' + boundary + '\r\n';
        body += 'Content-Disposition: form-data; name="File"; filename="837P'+System.today()+'.txt"\r\n';
        body += 'Content-Type: application/xml\r\n\r\n';
        
        String footer = '\r\n--' + boundary + '--\r\n';
        
        request.setBodyAsBlob(Blob.valueOf(body + data + footer));
        
        // Send the request
        Http http = new Http();
        HttpResponse response = http.send(request);
        
        if (response.getStatusCode() == 200) {
            createDataStagingAndContentDoc(response.getBody());
            System.debug('data sent to external system' + response.getBody());
            
            List < ElixirSuite__Integration_Data__c > integrationOrder = [SELECT Id, ElixirSuite__Integration_Data__c , ElixirSuite__Posted__c , ElixirSuite__ERA_Id__c 
                                                         FROM ElixirSuite__Integration_Data__c 
                                                         WHERE ElixirSuite__Integration_Data__c  = NULL AND ElixirSuite__ERA_Id__c  != NULL AND ElixirSuite__Posted__c = false
                                                         WITH SECURITY_ENFORCED
                                                         ORDER BY CreatedDate DESC
                                                        ];
            if (integrationOrder == null && integrationOrder.size() <= 0) {
                String responseFromEra=calloutToGetEraId();
                parseEraXmlResponsetoJSON(responseFromEra);
            }else{
                calloutToEra835(integrationOrder[0].ElixirSuite__ERA_Id__c);
            }
        } else {
            System.debug('Error sending data to the external system: ' + response.getBody());
        }
    }
    public static String calloutToGetEraId(){
        String url = 'callout:Claim_MD/services/era/?';
        url += 'AccountKey=8869fThoqjdYQelGBKQaYLwcyYdA';
        url += '&eraid=0';
        HttpRequest req = new HttpRequest();
        req.setHeader('Content-Type', 'text/html; charset=UTF-8');
        req.setMethod('GET');
        req.setEndpoint(url);
        Http http = new Http();
        http.send(req);
        HttpResponse response = http.send(req);
        return response.getBody();
    }
    @future(callout=true)
    public static void calloutToEra835(String eraId){
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://www.claim.md/services/era835/');
        request.setMethod('POST');
        
        request.setHeader('Content-Type', 'multipart/form-data; boundary=get_eraid');
        
        String boundary = 'get_eraid';
        String body = '--' + boundary + '\r\n';
        
        // Add the 'AccountKey' parameter
        body += 'Content-Disposition: form-data; name="AccountKey"\r\n\r\n';
        body += '8869fThoqjdYQelGBKQaYLwcyYdA' + '\r\n';
        
        // Add the 'EraId' parameter
        body += '--' + boundary + '\r\n';
        body += 'Content-Disposition: form-data; name="eraid"\r\n\r\n';
        body += eraId + '\r\n';
        
        String footer = '\r\n--' + boundary + '--\r\n';
        request.setBodyAsBlob(Blob.valueOf(body + footer));
        
        // Send the request
        Http http = new Http();
        HttpResponse response = http.send(request);
        
        if (response.getStatusCode() == 200) {
            System.debug('ERA835 Response' + response.getBody());
            createDataStagingAndContentDoc(response.getBody());
        } else {
            System.debug('Error sending data to the external system: ' + response.getBody());
        }
    }
    
    @future
    public static void createDataStagingAndContentDoc(String body){
        ContentVersion cv = new ContentVersion();
        cv.Title = 'EDI_837P_AR' + Datetime.now().format('dd-MMM-yyyy');
        cv.PathOnClient = cv.Title + '.txt';
        cv.VersionData = Blob.valueOf(body);
        insert cv;
        
        Data_Staging__c DataStaging = new Data_Staging__c();
        insert DataStaging;
        
        List<ContentVersion> cvList = [SELECT ContentDocumentId FROM ContentVersion WHERE Id = :cv.Id];
        if (!cvList.isEmpty()) {
            ContentDocumentLink cdl = new ContentDocumentLink();
            cdl.ContentDocumentId = cvList[0].ContentDocumentId;
            cdl.LinkedEntityId = DataStaging.Id;
            cdl.ShareType = 'V';
            cdl.Visibility = 'AllUsers';
            insert cdl;
        } else {
            System.debug('Error: ContentDocumentId not found for ContentVersion.');
        }
    }
    
    public static void parseEraXmlResponsetoJSON(String responseBody){
        Dom.Document doc = new Dom.Document();
        //system.debug(response.getBody());
        doc.load(responseBody);
        Dom.XMLNode root = doc.getRootElement(); //result
        String ParentJson = '{';
        String finalJson = '{';
        List < String > mainERAJson = new List < String > ();
        List < String > mainJson = new List < String > ();
        List < String > ERAAttributes = new List < String > ();
        try {
            if (root.getNodeType() == Dom.XmlNodeType.ELEMENT) {
                String keyval = root.getAttributeKeyAt(0);
                String ParentElement = root.getAttribute(keyval, '');
                List < Dom.XMLNode > children = root.getChildElements();
                ParentJson += '"' + keyval + '": ' + '[';
                String ERAJson = '';
                ERAJson += '{';
                ERAAttributes.add('"' + keyval + '": "' + ParentElement + '"');
                ERAJson += String.join(ERAAttributes, ',');
                mainERAJson.add(ERAJson);
                ParentJson += String.join(mainERAJson, ',') + '}]}';
                finalJson += '"' + 'claim' + '": ' + '[';
                for (Dom.XMLNode child: children) {
                    String claimJson = '';
                    //  system.debug(child.getName());
                    claimJson += '{';
                    List < String > firstAttributes = new List < String > ();
                    for (Integer i = 0; i < child.getAttributeCount(); i++) {
                        String key = child.getAttributeKeyAt(i);
                        String value = child.getAttribute(key, '');
                        firstAttributes.add('"' + key + '": "' + value + '"');
                    }
                    if (firstAttributes != null && firstAttributes.size() > 0) {
                        claimJson += String.join(firstAttributes, ',');
                    }
                    claimJson += ',';
                    claimJson += '"' + 'messages' + '": ' + '[';
                    List < String > allMessages = new List < String > ();
                    for (Dom.XMLNode secondChild: child.getChildElements()) {
                        // system.debug(secondChild.getName());//messages
                        List < String > lstAttributes = new List < String > ();
                        for (Integer i = 0; i < secondChild.getAttributeCount(); i++) {
                            String key = secondChild.getAttributeKeyAt(i);
                            String value = secondChild.getAttribute(key, '');
                            if (i == 0) {
                                lstAttributes.add('{' + '"' + key + '": "' + value + '"');
                            } else {
                                lstAttributes.add('"' + key + '": "' + value + '"');
                            }
                            if (i == secondChild.getAttributeCount() - 1) {
                                lstAttributes[i] += '}';
                            }
                        }
                        if (lstAttributes.size() > 0) {
                            allMessages.add(String.join(lstAttributes, ','));
                        }
                    }
                    claimJson += String.join(allMessages, ',') + ']}';
                    mainJson.add(claimJson);
                }
                finalJson += String.join(mainJson, ',') + ']}';
                system.debug('**finalJson'+finalJson);     
                setIntegrationDataAndCallout(parentJson, finalJson);
            }
        } catch (Exception e) {
            throw new AuraHandledException('No ERA found!!');
        }
    }
    @future
    public static void setIntegrationDataAndCallout(String parentJson, String finalJson) {
        Map < String, Object > LastERAresults = (Map < String, Object > ) JSON.deserializeUntyped(parentJson);
        Map < String, Object > results = (Map < String, Object > ) JSON.deserializeUntyped(finalJson);
        List < Object > lastERAIdlist = (List < Object > ) LastERAresults.get('last_eraid');
        List < Object > lstCustomers = (List < Object > ) results.get('claim');
        // system.debug('lastERAIdlist--'+lastERAIdlist);
        //  system.debug('lstCustomers--'+lstCustomers);
        // system.debug('lstCustomers--'+lstCustomers.size());
        ElixirSuite__Integration_Data__c intParentData;
        Map < String, Object > lastERAId;
        for (Object result: lastERAIdlist) {
            lastERAId = (Map < String, Object > ) result;
        }
        intParentData = new ElixirSuite__Integration_Data__c();
        if (lastERAId.get('last_eraid') != null) {
            intParentData.ElixirSuite__ERA_Id__c  = string.valueOf(lastERAId.get('last_eraid'));
            intParentData.ElixirSuite__Type__c = 'ERA Remitance Search';
        }
        if (intParentData != null) {
                insert intParentData;
                //DMLManager.insertAsUser(intParentData);
                //  system.debug('IntParentdatalist--'+intParentData);
            }
        ElixirSuite__Integration_Data__c intData;
        Map < String, Object > customerAttributes;
        //  system.debug('lstCustomers--'+lstCustomers);
        List < ElixirSuite__Integration_Data__c > Intdatalist = new List < ElixirSuite__Integration_Data__c > ();
        if (lstCustomers != null) {
            for (Object obj: lstCustomers) {
                //   system.debug('obj--'+obj);
                customerAttributes = (Map < String, Object > ) obj;
                intData = new ElixirSuite__Integration_Data__c();
                calloutToEra835(string.valueOf(customerAttributes.get('eraid')));
                intData.ElixirSuite__ERA_Id__c  = string.valueOf(customerAttributes.get('eraid'));
                intData.ElixirSuite__Type__c = 'ERA Remitance Search';
                intData.ElixirSuite__Integration_Data__c = intParentData.Id; //Attaching child to its parent
                intData.ElixirSuite__ERA_Generated__c = false;
                intData.ElixirSuite__Last_Response_Id__c = intData.ElixirSuite__ERA_Id__c;
                intData.ElixirSuite__Check_Number__c = string.valueOf(customerAttributes.get('check_number'));
                intData.ElixirSuite__check_type__c = string.valueOf(customerAttributes.get('check_type'));
                intData.ElixirSuite__Provider_Name__c = string.valueOf(customerAttributes.get('claimmd_prov_name'));
                intData.ElixirSuite__Download_Time__c = string.valueOf(customerAttributes.get('download_time'));
                //intData.Paid_Amount__c = Integer.valueOf(customerAttributes.get('paid_amount'));
                intData.ElixirSuite__Paid_Date__c = string.valueOf(customerAttributes.get('paid_date'));
                Date paidDate = Date.valueOf(string.valueOf(customerAttributes.get('paid_date')));
                //   system.debug('#### paidDate : ' + paidDate);
                intData.ElixirSuite__Payer_Name__c = string.valueOf(customerAttributes.get('payer_name'));
                intData.ElixirSuite__Payer_Id__c = string.valueOf(customerAttributes.get('payerid'));
                intData.ElixirSuite__Provider_NPI__c = string.valueOf(customerAttributes.get('prov_npi'));
                intData.ElixirSuite__Provider_Tax_Id__c = string.valueOf(customerAttributes.get('prov_taxid'));
                intData.ElixirSuite__Received_Date_Time__c = string.valueOf(customerAttributes.get('received_time'));
                String recievedDateStr = string.valueOf(customerAttributes.get('received_time'));
                List < String > recDateSplit = recievedDateStr.split(' ');
                String datePart = recDateSplit[0];
                List < String > datePartSplit = datePart.split('-');
                String recievedDateFinal = datePartSplit[2] + '-';
                //Datetime receivedDate = DateTime.valueOf(string.valueOf(customerAttributes.get('received_time')));
                //system.debug('#### receivedDate : ' + receivedDate );
                Intdatalist.add(intData);
            }
            //   system.debug('Intdatalist--'+Intdatalist);
        }
        if (Intdatalist.size() > 0) {
            insert Intdatalist;
            //system.debug('Intdatalist--'+Intdatalist);
            
        }
        //calloutToEra835(null);
    }
}