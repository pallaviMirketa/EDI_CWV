global class EDI837PSendEmailBatch implements Database.Batchable<sObject>,Schedulable {
    global Database.QueryLocator start(Database.BatchableContext context){
        string query = 'SELECT Id,ElixirSuite__Payor__r.Id From ElixirSuite__Claim__c where ElixirSuite__Claim_Status__c = \'Ready to Submit\' and ElixirSuite__Payor__r.name = \'DBH Local\'';
        return Database.getQueryLocator(query);       
    }
    global void execute(Database.BatchableContext context, List<sObject> objectList) {
        String EDI837P = EDIEDI837PHandler.generateEDI837PMessage(objectList);
        
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
 
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        email.setToAddresses(new String[] { 'ashutosh.singh@mirketa.com','vaishnavi.garg@mirketa.com','udhay.kumar@mirketa.com','pallavi.verma@mirketa.com','bhupati.sneha@mirketa.com'});
		email.setSubject('EDI_837P File - Claims Ready for Submission');
        email.setPlainTextBody('Hi Team,\n\nPlease find the EDI_837P file in the attachments.\n\nRegards,\nHealth Care IT Team');
        // Create an attachment
        Messaging.EmailFileAttachment attachment = new Messaging.EmailFileAttachment();
        attachment.setFileName(cv.Title+'.txt'); // Set the file name
        attachment.setBody(cv.VersionData); // Set the attachment content
        attachment.setContentType('text/csv');
        attachment.setInline(false);
        email.setFileAttachments(new Messaging.EmailFileAttachment[] { attachment });
        // Send the email
         Messaging.SendEmailResult[] result = Messaging.sendEmail(new Messaging.SingleEmailMessage[] { email });
           
    }
    global void finish(Database.BatchableContext context) {        
    }
    global void execute(SchedulableContext sc) { 
        EDI837PSendEmailBatch batch = new EDI837PSendEmailBatch();
        Database.executeBatch(batch);
        
    }
}