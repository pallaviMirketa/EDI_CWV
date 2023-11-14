public class EDI835JSONandReconcile{
    @AuraEnabled
    public static void getJSONtoReconcile(Id recordId){
        String combinedData = '';
        System.debug('recordId '+recordId);
        Data_Staging__c objDataRecord = [SELECT Id, Status__c FROM Data_Staging__c 
                                         WHERE Id =: recordId 
                                         AND Status__c = '835 EDI Received'];
        
        ContentDocumentLink contentDocumentLink = [SELECT Id, ContentDocumentId, ContentDocument.Title, ContentDocument.FileExtension, ContentDocument.Description, ContentDocument.LatestPublishedVersionId FROM ContentDocumentLink WHERE LinkedEntityId = :objDataRecord.Id limit 1  ];
        ContentDocument contentDocument = [SELECT Id, Title, FileExtension, Description, LatestPublishedVersionId, LatestPublishedVersion.VersionData FROM ContentDocument WHERE Id =: contentDocumentLink.ContentDocumentId];
        ContentVersion contentVersion = [SELECT Id, VersionData FROM ContentVersion WHERE ContentDocumentId = :contentDocument.Id];
        System.debug('contentVersion '+ contentVersion); 
        List<Blob> fileDataList = new List<Blob>();
        fileDataList.add(contentVersion.VersionData);
        if(fileDataList.size() > 0) {
            for(Blob data : fileDataList) {
                combinedData = data.toString();
            }
        }
        String EDI835JSON = EDI835toJSON.parseEDItoJSON(combinedData);
        ContentVersion cv = new ContentVersion();
        cv.Title = 'EDI_835_JSON_File_' + DateTime.Now().format('dd-MMM-yy HH:mm:ss');
        cv.PathOnClient = cv.Title + '.txt';
        cv.VersionData = Blob.valueOf(EDI835JSON);
        insert cv;
        
        List<ContentVersion> cvList = [SELECT ContentDocumentId FROM ContentVersion WHERE Id = :cv.Id];
        System.debug('cvList '+ cvList);
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
        //objDataRecord.Status__c = '835 EDI Processed';  
        //update objDataRecord;
        System.debug('EDI835JSON '+  EDI835JSON);
        try {Json835Response.PostClaimUpdation(EDI835JSON); }
        catch(Exception e){
            ElixirSuite__Exception_Log__c objExp = new ElixirSuite__Exception_Log__c();
            objExp.ElixirSuite__Stack_Trace_Long__c = 'Error in reconciling JSON:'+ e.getMessage();
            Insert objExp;
        }
    }
}