public class EDI835JSONandReconcile{
    @AuraEnabled
    public static void getJSONtoReconcile(Id recordId){
        String combinedData = '';
        String EDIJSON = '';
        String EDIType = '';
        
        Data_Staging__c objDataRecord = [SELECT Id, Name, Status__c, EDI_Type__c FROM Data_Staging__c WHERE Id =: recordId ];
        
        List<ContentDocumentLink> contentDocumentLink = [SELECT Id, ContentDocumentId, ContentDocument.Title, ContentDocument.FileExtension, ContentDocument.Description, ContentDocument.LatestPublishedVersionId FROM ContentDocumentLink WHERE  LinkedEntityId = :objDataRecord.Id   limit 1  ];
        ContentDocument contentDocument = [SELECT Id, Title, FileExtension, Description, LatestPublishedVersionId, LatestPublishedVersion.VersionData FROM ContentDocument WHERE Id =: contentDocumentLink[0].ContentDocumentId];
        ContentVersion contentVersion = [SELECT Id, Title,VersionData FROM ContentVersion WHERE ContentDocumentId = :contentDocument.Id];
        
        if (contentDocumentLink.isEmpty()) {
            throw new AuraHandledException('Upload an EDI File.');    
        }        
        
        List<Blob> fileDataList = new List<Blob>();
        fileDataList.add(contentVersion.VersionData);
        if(fileDataList.size() > 0 ) {
            for(Blob data : fileDataList) {
                combinedData = data.toString();
            }
        }
        if(objDataRecord.EDI_Type__c == '835 EDI'){
            if (objDataRecord.Status__c == '837P EDI Received' || objDataRecord.Status__c == 'Is Download' || objDataRecord.Status__c == '835 EDI Processed' ) {
                throw new AuraHandledException('Status should be: 835 EDI Received'); 
            }
            if (!contentVersion.Title.startsWith('era')) {
                throw new AuraHandledException('File name should start with era');    
            }
            EDIJSON = EDI835toJSON.parseEDItoJSON(combinedData); 
            EDIType= '_EDI835_';
            objDataRecord.Status__c = '835 EDI Processed';  
            update objDataRecord;
            try {
                Json835Response.PostClaimUpdation(EDIJSON); 
            }
            catch(Exception e){
                ElixirSuite__Exception_Log__c objExp = new ElixirSuite__Exception_Log__c();
                objExp.ElixirSuite__Stack_Trace_Long__c = 'Error in reconciling JSON:'+ e.getMessage();
                Insert objExp;
            }
            
        }
        else if (objDataRecord.EDI_Type__c == '999 EDI'){
            if(!combinedData.contains('AK9')){
                throw new AuraHandledException('Upload correct EDI 999 file.');
            }
            EDIJSON = EDI999toJSON.parseEDI999toJSON(combinedData);  
            EDIType= '_EDI999_';
        } 
        else{
            throw new AuraHandledException('Check the EDI Type field.');
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
    }
}