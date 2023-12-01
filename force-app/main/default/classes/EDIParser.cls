public class EDIParser{
    @AuraEnabled
    public static String getJSONtoReconcile(Id recordId){
        String combinedData = '';
        String EDIJSON = '';
        String EDI999JSON = '';
        String EDIType = '';
        String toastMessage = '';
        
        Data_Staging__c objDataRecord = [SELECT Id, Name, Status__c, EDI_Type__c
                                         FROM Data_Staging__c
                                         WHERE Id =: recordId ];                                        
        
        if ((objDataRecord.EDI_Type__c =='835 EDI') && (objDataRecord.Status__c != '835 EDI Received' )){
            throw new AuraHandledException('Status should be: 835 EDI Received');  
        }
        
        List<ContentDocumentLink> contentDocumentLink = [SELECT Id, ContentDocumentId, ContentDocument.Title,
                                                         ContentDocument.FileExtension, ContentDocument.Description,
                                                         ContentDocument.LatestPublishedVersionId
                                                         FROM ContentDocumentLink
                                                         WHERE  LinkedEntityId = :objDataRecord.Id   limit 1  ];
        
        if (contentDocumentLink.isEmpty()) {
            throw new AuraHandledException('Upload an EDI_835 File.');
        }  
        
        ContentDocument contentDocument = [SELECT Id, Title, FileExtension, Description, LatestPublishedVersionId,
                                           LatestPublishedVersion.VersionData
                                           FROM ContentDocument
                                           WHERE Id =: contentDocumentLink[0].ContentDocumentId];
        
        ContentVersion contentVersion  = [SELECT Id, Title,VersionData
                                          FROM ContentVersion
                                          s WHERE ContentDocumentId = :contentDocument.Id];
        
        List<Blob> fileDataList = new List<Blob>();
        fileDataList.add(contentVersion.VersionData);
        
        if(fileDataList.size() > 0 ) {
            for(Blob data : fileDataList) {
                combinedData = data.toString();
            }
        }
        if (objDataRecord.EDI_Type__c == '835 EDI' ) {
            EDIJSON = EDI835toJSON.parseEDItoJSON(combinedData); 
            System.debug('TESTTTT');
            String edi835Response = EDIParser.reconcileEDI835JSON(objDataRecord,EDIJSON);
                if(edi835Response == null){
                    throw new AuraHandledException('EDI 835 Reconcilation Failed');
                }
                EDIType= '_EDI835_';
                toastMessage = '835';
        }
        else if (objDataRecord.EDI_Type__c == '999 EDI'){
            EDIJSON = EDI999toJSON.parseEDI999toJSON(combinedData); 
                if(String.isEmpty(EDIJSON)){
                    throw new AuraHandledException('Failed to parse EDI 999 file.');
                }
                if(!combinedData.contains('AK9')){
                    throw new AuraHandledException('Upload correct EDI 999 file.');
                }
                EDIType= '_EDI999_';
                toastMessage = '999';
        }
        else{
            throw new AuraHandledException('Invalid EDI_Type.');    
        }
        
        ContentVersion cv = new ContentVersion();
        String fileName = contentVersion.Title;
        
        if (contentVersion.Title.length() > 255) {
            fileName = contentVersion.Title.substring(0, 255);
        }
        
        cv.Title = fileName + EDIType + objDataRecord.Name + '_' + DateTime.Now().format('ddMMMyyyy');
        cv.PathOnClient = cv.Title + '.txt';
        cv.VersionData = Blob.valueOf(EDIJSON);
        insert cv;
        
        List<ContentVersion> cvList = [SELECT ContentDocumentId FROM ContentVersion WHERE Id = :cv.Id];
        
        if (!cvList.isEmpty()) {
            ContentDocumentLink cdl = new ContentDocumentLink();
            cdl.ContentDocumentId = cvList[0].ContentDocumentId;
            cdl.LinkedEntityId = objDataRecord.Id;
            cdl.ShareType = 'V';
            cdl.Visibility = 'AllUsers';
            insert cdl;
        }
        else {
            System.debug('Error: ContentDocumentId not found for ContentVersion.');
        }
        if(String.isNotBlank(toastMessage)){
            return toastMessage;
        }
        return NULL;
    }
    @AuraEnabled
    public static String reconcileEDI835JSON(Data_Staging__c objDataRecord, String EDI835JSON){
        String edi= 'success';
        try {
            EDI835Parsing.PostClaimUpdation(EDI835JSON); 
            objDataRecord.Status__c = '835 EDI Processed';  
            update objDataRecord;
        }
        catch(Exception e){
            ElixirSuite__Exception_Log__c objExp = new ElixirSuite__Exception_Log__c();
            objExp.ElixirSuite__Line_Number__c = e.getLineNumber();
            objExp.ElixirSuite__Stack_Trace_Long__c = 'Error in reconciling JSON:'+ e.getMessage();
            Insert objExp;
            return null;
        }
        return edi;
    }
}