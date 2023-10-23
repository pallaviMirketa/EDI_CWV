@isTest
public class EDI837PSegmentLXSV1DTPTest {
    public static User createTestUser( String fName, String lName)
    {
        Profile pf = [SELECT Id FROM Profile WHERE Name = 'System Administrator'];
        UserRole ur = new UserRole(Name = 'Independent Reviewer');
        insert ur;
        User testUser= new User(
            FirstName = fName,
            LastName = lName,
            Username = 'jacobSmith@sf.com',
            Email = 'jacobSmith@email.com',
            Alias = 'UAlias',
            TimeZoneSidKey = 'GMT',
            LocaleSidKey = 'en_US',
            EmailEncodingKey = 'UTF-8',
            ProfileId = pf.Id, // Replace with a valid ProfileId
            LanguageLocaleKey = 'en_US',
            UserRoleId = ur.Id
        );
        insert testUser;
        return testUser;
    }
    
    @istest
    public static void setuptestData() {
        User usr = EDI837PSegmentLXSV1DTPTest.createTestUser('Jacob', 'Smith'); 
        System.runAs(usr)
        {
            Account testAccount = new Account(
                Name = 'Martin Luther',
                ElixirSuite__First_Name__c = 'Martin',
                ElixirSuite__Last_Name__c = 'Luther',
                ElixirSuite__Email_Id__c = 'Martinluther@gmail.com',
                ElixirSuite__Gender__c = 'Male',
                ElixirSuite__Current_Status_Of_Patient__c = 'Patients In Review',
                ElixirSuite__Stage__c = 'Pre Admission'
            );
            insert testAccount;
            
            Id templateProviderRecordTypeId = Schema.SObjectType.ElixirSuite__Provider__c.getRecordTypeInfosByDeveloperName().get('Template_Provider').getRecordTypeId();
            
            ElixirSuite__Provider__c testProvider = new ElixirSuite__Provider__c(
                Name = 'COMMUNITY WELLNESS VENTURES, LLC',
                RecordTypeId = templateProviderRecordTypeId,
                User__c = usr.Id,
                ElixirSuite__Account__c = testAccount.Id,
                ElixirSuite__Provider_Code__c = '1275903700'
                
            );
            insert testProvider; 
            
            ElixirSuite__Provider__c testProvider1 = new ElixirSuite__Provider__c(
                Name = 'Rizwan Malik',
                RecordTypeId = templateProviderRecordTypeId,
                User__c = usr.Id,
                ElixirSuite__Account__c = testAccount.Id,
                ElixirSuite__Provider_Code__c = '1568402609'
                
            );
            insert testProvider1;
            
            Id templateDiagnosisRecordTypeId = Schema.SObjectType.ElixirSuite__ICD_Codes__c.getRecordTypeInfosByDeveloperName().get('Template_Diagnosis_Code').getRecordTypeId();
            ElixirSuite__ICD_Codes__c testDiagnosis = new ElixirSuite__ICD_Codes__c(
                ElixirSuite__Account__c = testAccount.Id,
                RecordTypeId = templateDiagnosisRecordTypeId,
                Name = 'H0036',
                ElixirSuite__Diagnosis_Type__c = 'Primary',
                ElixirSuite__Code_Description1__c = 'Headache',
                ElixirSuite__Effective_Date__c = Date.today(),
                ElixirSuite__Active__c = true,
                ElixirSuite__Version__c = 'ICD 10'
            );
            insert testDiagnosis;
            
            Id templateProcedureRecordTypeId = Schema.SObjectType.ElixirSuite__Procedure__c.getRecordTypeInfosByDeveloperName().get('Template_Procedure').getRecordTypeId();
            ElixirSuite__Procedure__c testProcedure = new ElixirSuite__Procedure__c(
                RecordTypeId = templateProcedureRecordTypeId,
                Name = '90791',
                ElixirSuite__Account__c = testAccount.Id,
                ElixirSuite__ICD_Codes__c = testDiagnosis.Id,
                ElixirSuite__Code_Category__c = 'HCPCS Level 1',
                ElixirSuite__Active__c = true,
                ElixirSuite__Version__c = 'ICD 10',
                ElixirSuite__From_Date__c = Date.today(),
                ElixirSuite__Start_Time__c = DateTime.now(),
                ElixirSuite__Billable__c = 'Yes'
                
            );
            insert testProcedure;
            
            ElixirSuite__Payor__c testPayer = new ElixirSuite__Payor__c(
                ElixirSuite__Procedure__c = testProcedure.id,
                Name = 'Medicare Part B',
                ElixirSuite__Payer_Code__c = '12202'
            );
            insert testPayer;
            
            ElixirSuite__VOB__c testInsurance = new ElixirSuite__VOB__c(
                ElixirSuite__Account__c = testAccount.Id,
                ElixirSuite__Payer__c = testPayer.Id,
                ElixirSuite__Status__c = 'Active',
                ElixirSuite__Set_Default_VOB__c = 'Yes',
                ElixirSuite__Member_Id__c = '73001234000'
                
            );
            insert testInsurance;
            
            ElixirSuite__Visits__c visit = new ElixirSuite__Visits__c(
                ElixirSuite__Account__c = testAccount.Id,
                Supervising_Provider__c = testProvider.Id,
                ElixirSuite__Visit_Start__c = DateTime.now(),
                ElixirSuite__Visit_End__c = DateTime.now().addMinutes(15),
                ElixirSuite__Status__c = 'Active',
                Encounter_Type__c = 'Diagnostic Assessment',
                Diagnosis__c = testDiagnosis.Id,
                Service_Type__c = 'MCO - DIAGNOSTIC ASSESSMENT',
                PatientProcedureIDs__c = testProcedure.Id,
                Service_Location__c = 'Residential Substance Abuse Treatment Facility – 55'
            );
            insert visit;
            
            ElixirSuite__Procedure_Diagnosis__c testProcDiagnosis = new ElixirSuite__Procedure_Diagnosis__c(
                ElixirSuite__Account__c = testAccount.Id,
                ElixirSuite__Care_Episode__c = visit.Id,
                ElixirSuite__ICD_Codes__c = testDiagnosis.Id,
                ElixirSuite__Procedure__c = testProcedure.Id
            );
            insert testProcDiagnosis;
            
            ElixirSuite__Claim__c testClaim = new ElixirSuite__Claim__c(
                ElixirSuite__Account__c = testAccount.Id,
            	Care_Episode__c = visit.Id,
                ElixirSuite__Payor__c = testPayer.Id
            );
            insert testClaim;
            
             ElixirSuite__Claim_Line_Items__c claimLineItem = new ElixirSuite__Claim_Line_Items__c(
                 ElixirSuite__Procedure__c = testProcedure.Id,
                 ElixirSuite__ICD_Codes__c = testDiagnosis.Id,
                 ElixirSuite__Place_of_Service__c = '11',
                 ElixirSuite__Procedure_Charge__c = 111.11,
                 ElixirSuite__Days_Units__c = 10,
                 ElixirSuite__Diagnosis_Pointer__c = 'A',
                 ElixirSuite__Modifier_1__c = 'AM',
                 ElixirSuite__Modifier_2__c = 'GT'
             );
            claimLineItem.ElixirSuite__Claim__c = testClaim.Id;
            insert claimLineItem;
            Test.startTest();
            ElixirSuite__Claim__c objClaim = [Select Id,Name, ElixirSuite__Total_Charge__c,(Select ElixirSuite__CPT_HCPCS_Code__c,ElixirSuite__Diagnosis_Pointer__c,ElixirSuite__Days_Units__c,ElixirSuite__Procedure_Charge__c,ElixirSuite__Modifier_1__c,ElixirSuite__Modifier_2__c,ElixirSuite__Place_of_Service__c,ElixirSuite__From_Date_Of_Service__c from ElixirSuite__Claim_Line_Items__r ) from ElixirSuite__Claim__c where Id=:testClaim.Id];
            String result = EDI837PSegmentLXSV1DTP.generateLXSV1DTPSegment(objClaim);
            String result1 = EDI837PSegmentLXSV1DTP.generateLXSV1DTPSegment(null);
            Test.stopTest();
        }
        
    }
}