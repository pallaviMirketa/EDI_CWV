@isTest
public class EDI837SegmentSBRTest {
    @isTest
    public static void generateSBRSegmentTest(){
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
        Test.startTest();
        EDI837PSegmentSBR.generateSBRSegment(testInsurance);
        EDI837PSegmentSBR.generateSBRSegment(null);
        Test.stopTest();
    }
}