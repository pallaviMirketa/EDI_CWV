global class EDI837PSendEmailBatch implements Database.Batchable<sObject>, Schedulable{
    global Database.QueryLocator start(Database.BatchableContext context){
        string query = 'SELECT Id,Name,ElixirSuite__Total_Charge__c,ElixirSuite__Place_of_Service__c,ElixirSuite__Diagnosis_A__c,ElixirSuite__Diagnosis_B__c,';
        query += 'ElixirSuite__Diagnosis_C__c, ElixirSuite__Diagnosis_D__c, ElixirSuite__Diagnosis_E__c ,ElixirSuite__Diagnosis_F__c,EDI_Email_sent__c,';
        query += 'ElixirSuite__Diagnosis_G__c, ElixirSuite__Diagnosis_H__c,ElixirSuite__Payor__r.Id,ElixirSuite__Insured_Sex__c,ElixirSuite__Insured_DOB__c From ElixirSuite__Claim__c where ElixirSuite__Payor__r.name = \'DBH Local\' and EDI_Email_sent__c = False order by CreatedDate desc';
        return Database.getQueryLocator(query);       
    }
    global void execute(Database.BatchableContext context, List<sObject> objectList) {
        Set<Id> claimIds = new Set<Id>();
        for(sObject s :objectList){
            ElixirSuite__Claim__c claim = (ElixirSuite__Claim__c)s;
            claimIds.add(claim.Id);
        }        
        String EDI837P = EDI837PHandler.generateEDI837PMessage(claimIds);
        
        ContentVersion cv = new ContentVersion();
        cv.Title = 'EDI_837P_' + Datetime.now().format('dd-MMM-yyyy');
        cv.PathOnClient = cv.Title + '.txt';
        cv.VersionData = Blob.valueOf(EDI837P);
        insert cv;
        
        //--------------Insertion in data staging object-----------------------------//
        Data_Staging__c DataStaging = new Data_Staging__c();
        DataStaging.Date__c= system.now();
        DataStaging.Status__c = '837P EDI Received';
        DataStaging.EDI_Type__c = 	'837P EDI';
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
        
        //-----------Fetching the emails from custom settings---------------------//
        EDI_Recipient_Emails__c emailAddress = EDI_Recipient_Emails__c.getInstance();
        
        if (emailAddress != null) {
            String[] toAddresses = emailAddress.Recipient_Email_Ids__c.split(',');
            if (toAddresses.size() > 0) {
                Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                email.setToAddresses(toAddresses);
                email.setSenderDisplayName('Claim EDI');
                email.setSubject('EDI_837P File');
                email.setPlainTextBody('Hi Team,\n\nPlease find the EDI_837P file in the attachments.\n\nRegards,\nHealth Care IT Team');
                //-----------Create an attachment--------------------//
                Messaging.EmailFileAttachment attachment = new Messaging.EmailFileAttachment();
                attachment.setFileName(cv.Title + '.txt'); // Set the file name
                attachment.setBody(cv.VersionData); // Set the attachment content
                attachment.setContentType('text/csv');
                attachment.setInline(false);
                email.setFileAttachments(new Messaging.EmailFileAttachment[] { attachment });
                //---------------Send the email-------------------//
                Messaging.SendEmailResult[] result = Messaging.sendEmail(new Messaging.SingleEmailMessage[] { email });
                if (result[0].isSuccess()){
                    List<ElixirSuite__Claim__c> claimToUpdateList = new List<ElixirSuite__Claim__c>();
                    for (Id claimId : claimIds) {
                        claimToUpdateList.add(new ElixirSuite__Claim__c(Id = claimId, EDI_Email_sent__c = true));
                    }
                    if (!claimToUpdateList.isEmpty()) {
                        update claimToUpdateList;
                    }
                }
                else {
                    String emailError = 'Error sending email: '+ result[0].getErrors()[0].getMessage();
                    ElixirSuite__Exception_Log__c objExp = new ElixirSuite__Exception_Log__c();
                    objExp.ElixirSuite__Stack_Trace_Long__c = emailError;
                }
                
            } else {
                String emailAddressError = 'No email addresses found in custom settings.';
                ElixirSuite__Exception_Log__c objExp = new ElixirSuite__Exception_Log__c();
                objExp.ElixirSuite__Stack_Trace_Long__c = emailAddressError;
            }
        } else {
            String customSettingError = 'Custom settings not found. ';
            ElixirSuite__Exception_Log__c objExp = new ElixirSuite__Exception_Log__c();
            objExp.ElixirSuite__Stack_Trace_Long__c = customSettingError;
        }
        
    }
    global void finish(Database.BatchableContext context) {
        
    }
    //----------Schedule the Batch class------------------//
    public static void scheduleBatch() {
        String cronExpression = '0 30 19 ? * FRI';    //  Every Friday at 7:30 PM    
        //---------Schedule the job----------------//
        System.schedule('EDI837PSendEmailBatchFile', cronExpression, new EDI837PSendEmailBatch());
    }
    global void execute(SchedulableContext sc) { 
        EDI837PSendEmailBatch batch = new EDI837PSendEmailBatch();
        Database.executeBatch(batch);
        
    }
}