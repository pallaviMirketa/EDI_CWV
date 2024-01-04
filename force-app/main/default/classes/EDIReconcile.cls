public class EDIReconcile {
    @InvocableMethod(label='Get JSON to Reconcile' description='Retrieves JSON data for reconciliation')
    public static void getJSONtoReconcile(List<Id> recordIds) {
        try{
            for (Id recordId : recordIds) {
                getJSONtoReconcile835and999(recordId);
            }
        }catch(exception e){
            ElixirSuite__Exception_Log__c objExp = new ElixirSuite__Exception_Log__c();
            objExp.ElixirSuite__Line_Number__c = e.getLineNumber();
            objExp.ElixirSuite__Stack_Trace_Long__c = 'Error in reconciling JSON:'+ e.getMessage();
            Insert objExp;
        }
    }
    public static void getJSONtoReconcile835and999(Id recordId) {
        String combinedData = '';
        String EDIJSON = '';
        String EDIType = '';
        try{ 
            Data_Staging__c objDataRecord = [SELECT Id, Name, Status__c, EDI_Type__c
                                             FROM Data_Staging__c
                                             WHERE Id =: recordId ];
            
            
            List<ContentDocumentLink> contentDocumentLink = [SELECT Id, ContentDocumentId, ContentDocument.Title,
                                                             ContentDocument.FileExtension, ContentDocument.Description,
                                                             ContentDocument.LatestPublishedVersionId
                                                             FROM ContentDocumentLink
                                                             WHERE  LinkedEntityId = :objDataRecord.Id   limit 1  ];
            ContentDocument contentDocument = [SELECT Id, Title, FileExtension, Description, LatestPublishedVersionId,
                                               LatestPublishedVersion.VersionData
                                               FROM ContentDocument
                                               WHERE Id =: contentDocumentLink[0].ContentDocumentId];
            
            ContentVersion contentVersion  = [SELECT Id, Title,VersionData
                                              FROM ContentVersion
                                              WHERE ContentDocumentId = :contentDocument.Id];
            
            List<Blob> fileDataList = new List<Blob>();
            fileDataList.add(contentVersion.VersionData);
            
            if(fileDataList.size() > 0 ) {
                for(Blob data : fileDataList) {
                    combinedData = data.toString();
                }
            }
            
            EDIJSON = EDI835toJSON.parseEDItoJSON(combinedData);
            try{
                Json835Response.PostClaimUpdation(EDIJSON);
            }catch(Exception e){
                ElixirSuite__Exception_Log__c objExp = new ElixirSuite__Exception_Log__c();
                objExp.ElixirSuite__Line_Number__c = e.getLineNumber();
                objExp.ElixirSuite__Stack_Trace_Long__c = 'Error in Reconcilation Claims '+ e.getMessage();
                Insert objExp;
            }
            ContentVersion cv = new ContentVersion();
            String fileName = contentVersion.Title;
            
            if (contentVersion.Title.length() > 255) {
                fileName = contentVersion.Title.substring(0, 255);
            }
            cv.Title = fileName + '_EDI835_' + objDataRecord.Name + '_' + DateTime.now().format('ddMMMyyyy');
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
        } catch(Exception e){
            ElixirSuite__Exception_Log__c objExp = new ElixirSuite__Exception_Log__c();
            objExp.ElixirSuite__Line_Number__c = e.getLineNumber();
            objExp.ElixirSuite__Stack_Trace_Long__c = 'Error in Parsing JSON'+ e.getMessage();
            Insert objExp;
        }
    }
    
}