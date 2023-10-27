global class EDI837PSendEmailBatch implements Database.Batchable<sObject>{
    global Database.QueryLocator start(Database.BatchableContext context){
        string query = 'SELECT Id,Name,ElixirSuite__Total_Charge__c,ElixirSuite__Place_of_Service__c,ElixirSuite__Diagnosis_A__c,ElixirSuite__Diagnosis_B__c,';
        query += 'ElixirSuite__Diagnosis_C__c, ElixirSuite__Diagnosis_D__c, ElixirSuite__Diagnosis_E__c ,ElixirSuite__Diagnosis_F__c,';
        query += 'ElixirSuite__Diagnosis_G__c, ElixirSuite__Diagnosis_H__c,ElixirSuite__Payor__r.Id,ElixirSuite__Insured_Sex__c,ElixirSuite__Insured_DOB__c From ElixirSuite__Claim__c where ElixirSuite__Claim_Status__c = \'Ready to Submit\' and ElixirSuite__VOB_lookup__r.ElixirSuite__Payer__r.name = \'DBH Local\' and CreatedDate >= 2023-09-20T00:00:00Z  order by CreatedDate desc';
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
        
        //-----------Fetching the emails from custom settings
        EDI_Recipient_Emails__c emailAddress = EDI_Recipient_Emails__c.getInstance();
        
        if (emailAddress != null) {
            String[] toAddresses = emailAddress.Recipient_Email_Ids__c.split(',');
            if (toAddresses.size() > 0) {
                Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                email.setToAddresses(toAddresses);
                email.setSubject('EDI_837P File - Claims Ready for Submission');
                email.setPlainTextBody('Hi Team,\n\nPlease find the EDI_837P file in the attachments.\n\nRegards,\nHealth Care IT Team');
                //-----------Create an attachment
                Messaging.EmailFileAttachment attachment = new Messaging.EmailFileAttachment();
                attachment.setFileName(cv.Title + '.txt'); // Set the file name
                attachment.setBody(cv.VersionData); // Set the attachment content
                attachment.setContentType('text/csv');
                attachment.setInline(false);
                email.setFileAttachments(new Messaging.EmailFileAttachment[] { attachment });
                //----------Send the email
                Messaging.SendEmailResult[] result = Messaging.sendEmail(new Messaging.SingleEmailMessage[] { email });
                /*if (result[0].isSuccess()){
                    List<ElixirSuite__Claim__c> claimToUpdateList = new List<ElixirSuite__Claim__c>();
                    for (Id claimId : claimIds) {
                        claimToUpdateList.add(new ElixirSuite__Claim__c(Id = claimId, EDI_Email_sent__c = true));
                    }
                    if (!claimToUpdateList.isEmpty()) {
                        update claimToUpdateList;
                    }
                }
                else {
                    System.debug('Error sending email: ' + result[0].getErrors()[0].getMessage());
                }*/
                
            } else {
                System.debug('No email addresses found in custom settings.');
            }
        } else {
            System.debug('Custom settings not found.');
        }
        
    }
    global void finish(Database.BatchableContext context) {
        
    }
    /*public static void scheduleBatch() {
        String cronExpression = '0 0 0,6,12,18 * * ?';    // Runs at midnight, 6 AM, 12 PM, and 6 PM every day    
        // Schedule the job
        System.schedule('EDI837PSendEmailBatchSchedule', cronExpression, new EDI837PSendEmailBatch());
    }
    global void execute(SchedulableContext sc) { 
        scheduleBatch();
        
    }*/
}