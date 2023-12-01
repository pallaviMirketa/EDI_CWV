@isTest
public class EDIParserTest {
    @isTest
    public static void getJSONtoReconcileCase1(){
        //--------------------account insertion
        Account patient = new Account();
        patient.name = 'Test Patient';
        patient.ElixirSuite__Email_Id__c = 'kj@gmail.com';
        patient.ElixirSuite__Patient_s_Birth_Date__c = System.today().addyears(-20);
        patient.ElixirSuite__MRN_Number__c = 1234567;
        patient.ElixirSuite__First_Name__c ='fname';
        patient.ElixirSuite__Last_Name__c ='lname';
        patient.ElixirSuite__SSN__c ='1234';
        patient.ElixirSuite__Gender__c='Male';
        patient.Phone ='9919850735';
        patient.BillingPostalCode='27440';
        insert patient;
        
        Id paymntTxnRecordTypeId = Schema.SObjectType.ElixirSuite__Payment_Transaction__c.getRecordTypeInfosByDeveloperName().get('Insurance_Payment').getRecordTypeId();
        
         //--------------------procedure insertion
        ElixirSuite__Procedure__c procedure2 = new ElixirSuite__Procedure__c();
        procedure2.Name = 'Test Procedure';
        procedure2.ElixirSuite__CPT_HCPCS_Code__c = '12345';
        procedure2.ElixirSuite__From_Date__c = System.today();
        procedure2.ElixirSuite__To_Date__c = System.today().addDays(1);
        procedure2.ElixirSuite__Account__c =  patient.Id;
        insert procedure2;
        
        //--------------------transaction insertion
        ElixirSuite__Payment_Transaction__c payTran = new ElixirSuite__Payment_Transaction__c();
        payTran.ElixirSuite__Actual_Price__c = 500;
        payTran.ElixirSuite__Procedure__c = procedure2.Id;
        payTran.ElixirSuite__Cpt_Codes__c = 'CPT100';
        payTran.ElixirSuite__Insurance_Payments__c = 200;
        payTran.ElixirSuite__Account__c = patient.Id;
        payTran.ElixirSuite__Total_Remaining_Amount__c = 40;
        payTran.RecordTypeId = paymntTxnRecordTypeId;
        payTran.ElixirSuite__Patient_Payments__c = 100;
        payTran.ElixirSuite__Payment_Adjustments__c = 10;
        insert payTran;
        
        //---------------------------------claim insertion
        ElixirSuite__Claim__c claimRecord = new ElixirSuite__Claim__c();
        claimRecord.ElixirSuite__claim_status__c = 'Clearing house accepted';
        claimRecord.ElixirSuite__Account__c = patient.Id;
        claimRecord.ElixirSuite__pcn__c = 'John';
        claimRecord.ElixirSuite__patient_first_Name__c = 'David';
        claimRecord.ElixirSuite__patient_last_Name__c = 'Beckam';
        claimRecord.ElixirSuite__npi__c = '1831234939';
        claimRecord.ElixirSuite__payer_id__c = '20413';
        claimRecord.ElixirSuite__other_payer_name__c = 'LIC';
        claimRecord.ElixirSuite__Insured_s_ID_Number__c = '1232';
        claimRecord.ElixirSuite__patient_dob__c = System.today().addYears(-40);
        claimRecord.ElixirSuite__patient_sex__c = 'M';
        claimRecord.ElixirSuite__insured_s_name__c = 'David';
        claimRecord.ElixirSuite__insured_s_name__c = 'Beckam';
        claimRecord.ElixirSuite__payer_order__c = 'Primary';
        claimRecord.ElixirSuite__patient_s_address__c = 'Noida';
        claimRecord.ElixirSuite__patient_s_city__c = 'Noida';
        claimRecord.ElixirSuite__patient_country_code__c = 'IN';
        claimRecord.ElixirSuite__patient_s_state__c = 'UP';
        claimRecord.ElixirSuite__patient_s_zipcode__c = 201301;
        claimRecord.ElixirSuite__Patient_Relationship_to_Insured__c = 'Father';
        claimRecord.ElixirSuite__insured_address__c = 'Noida';
        claimRecord.ElixirSuite__insured_city__c = 'Noida';
        claimRecord.ElixirSuite__insured_country_code__c = 'IN';
        claimRecord.ElixirSuite__insured_state__c = 'UP';
        claimRecord.ElixirSuite__insured_zipcode__c = 201301;
        claimRecord.ElixirSuite__employment_related__c = 'No';
        claimRecord.ElixirSuite__Auto_Accident_Related__c = 'No';
        claimRecord.ElixirSuite__insured_dob__c = System.today().addYears(-10);
        claimRecord.ElixirSuite__insured_sex__c = 'M';
        claimRecord.ElixirSuite__Place_of_Service__c = 'Delhi';
        claimRecord.ElixirSuite__bill_taxid__c = '123656789';
        claimRecord.ElixirSuite__Billing_Provider_Tax_ID_Type__c = 'E';
        claimRecord.ElixirSuite__Accept_Assignment__c = 'Y';
        claimRecord.ElixirSuite__total_charge__c = 900;
        claimRecord.ElixirSuite__amount_paid__c = 0;
        claimRecord.ElixirSuite__Billing_Provider_Name__c = 'ATHENA';
        claimRecord.ElixirSuite__Billing_Provider_Address_1__c = 'Watertown';
        claimRecord.ElixirSuite__Billing_Provider_State__c = 'CA';
        claimRecord.ElixirSuite__Billing_Provider_Zip__c = '232329998';
        claimRecord.ElixirSuite__Bill_Phone__c = '4152155300';
        claimRecord.ElixirSuite__Billing_Provider_City__c = 'Watertown';
        claimRecord.ElixirSuite__Diag_1__c = 'B86';
        claimRecord.ElixirSuite__Posted__c = false;
        insert claimRecord;
        
        //--------------------claim line item insertion
        ElixirSuite__Claim_Line_Items__c rec = new ElixirSuite__Claim_Line_Items__c();
        rec.ElixirSuite__CPT_HCPCS_Code__c = '38525';
        rec.ElixirSuite__Days_Units__c = 2;
        rec.ElixirSuite__From_Date__c = System.today().adddays(-10);
        rec.ElixirSuite__To_Date__c = System.today().adddays(-8);
        rec.ElixirSuite__procedure_charge__c = 900;
        rec.ElixirSuite__diag_ref__c = 'A';
        rec.ElixirSuite__claim__c = claimRecord.Id;
        rec.ElixirSuite__Procedure__c = procedure2.Id;
        insert rec;
        
        ElixirSuite__Claim__c claimRec = [Select id, Name from ElixirSuite__Claim__c where ElixirSuite__Account__c =: patient.Id LIMIT 1];
        ElixirSuite__Claim_Line_Items__c cliRec = [Select id, Name from ElixirSuite__Claim_Line_Items__c where ElixirSuite__Claim__c =: claimRec.Id LIMIT 1];
        
        String ClName = claimRec.Name;
        String CliName = cliRec.Name;
        
        
        claimRecord.ElixirSuite__Posted__c =false;
        update claimRecord;        
        
        Data_Staging__c objDataRecord  = new Data_Staging__c(
            Status__c = '835 EDI Received',
            EDI_Type__c = '835 EDI'
        );
        insert objDataRecord;
        
        String test = 'ISA*00*          *00*          *ZZ*12202          *ZZ*12804          *231107*0915*^*00501*032059464*0*P*:~ GS*HP*12202*12804*20231107*0915*1*X*005010X221A1~ ST*835*0001~ BPR*I*80.91*C*ACH*CCP*01*081517693*DA*152302017081*1205296137**01*044000037*DA*371853208*20231108~ TRN*1*887877325*1205296137~ REF*EV*1935740~ DTM*405*20231107~ N1*PR*NOVITAS SOLUTIONS, INC.~ N3*PO BOX 3413~ N4*MECHANICSBURG*PA*170551852~ REF*2U*12202~ PER*CX**TE*8772358073~    PER*BL*NOVITAS SOLUTIONS, INC. EDI SERVICES*TE*8772358073*EX*1*EM*WEBSITEEDI@NOVITAS-SOLUTIONS.COM~ N1*PE*COMMUNITY WELLNES VENT*XX*1275903700~ N3*1930 MLK JR AVE SE~ N4*WASHINGTON*DC*200207006~ REF*TJ*474923631~ LX*1~ CLP*' + ClName+ '*1*103.2*80.91*20.64*MB*1923298291710*11*1~ NM1*QC*1*JEFFERSON*DEJUAN****MI*1AR9MV2PQ54~ NM1*82*1******XX*1568402600~ MOA***MA01~ DTM*050*20231025~ SVC*HC:90846*103.2*80.91**1~ DTM*472*20230905~ CAS*CO*253*1.65~     CAS*PR*2*20.64~ REF*LU*11~ REF*6R*' + CliName + '~ AMT*B6*103.2~ SE*29*0001~ GE*1*1~ IEA*1*032059464~';
        Blob fileData = Blob.valueOf(test);
        
        //    Blob fileData = Blob.valueOf('ISA*00*          *00*          *ZZ*12202          *ZZ*12804          *231107*0915*^*00501*032059464*0*P*:~ GS*HP*12202*12804*20231107*0915*1*X*005010X221A1~ ST*835*0001~ BPR*I*80.91*C*ACH*CCP*01*081517693*DA*152302017081*1205296137**01*044000037*DA*371853208*20231108~ TRN*1*887877325*1205296137~ REF*EV*1935740~ DTM*405*20231107~ N1*PR*NOVITAS SOLUTIONS, INC.~ N3*PO BOX 3413~ N4*MECHANICSBURG*PA*170551852~ REF*2U*12202~ PER*CX**TE*8772358073~    PER*BL*NOVITAS SOLUTIONS, INC. EDI SERVICES*TE*8772358073*EX*1*EM*WEBSITEEDI@NOVITAS-SOLUTIONS.COM~ N1*PE*COMMUNITY WELLNES VENT*XX*1275903700~ N3*1930 MLK JR AVE SE~ N4*WASHINGTON*DC*200207006~ REF*TJ*474923631~ LX*1~ CLP*CLAIM1873*1*103.2*80.91*20.64*MB*1923298291710*11*1~ NM1*QC*1*JEFFERSON*DEJUAN****MI*1AR9MV2PQ54~ NM1*82*1******XX*1568402600~ MOA***MA01~ DTM*050*20231025~ SVC*HC:90846*103.2*80.91**1~ DTM*472*20230905~ CAS*CO*253*1.65~     CAS*PR*2*20.64~ REF*LU*11~ REF*6R*CL-1996~ AMT*B6*103.2~ SE*29*0001~ GE*1*1~ IEA*1*032059464~');
        
        ContentVersion testContentVersion = new ContentVersion(
            Title = 'era_EDI_835_Test_File',
            VersionData = fileData,
            PathOnClient = 'EDI_835_Test_File.txt',
            Description = 'Test Description'
        );
        insert testContentVersion;
        
        testContentVersion = [SELECT Id, ContentDocumentId FROM ContentVersion WHERE Id = :testContentVersion.Id LIMIT 1];
        
        ContentDocumentLink testContentDocumentLink = new ContentDocumentLink(
            ContentDocumentId = testContentVersion.ContentDocumentId,
            LinkedEntityId = objDataRecord.Id,
            ShareType = 'V',
            Visibility = 'AllUsers'
        );
        insert testContentDocumentLink;
        
        System.Test.startTest();
        EDIParser.getJSONtoReconcile(objDataRecord.Id);
        EDIParser.reconcileEDI835JSON(null, null);
        System.Test.stopTest();
    }
    
    @isTest
    public static void getJSONtoReconcileCase2(){
        
        //--------------------account insertion
        Account patient = new Account();
        patient.name = 'Test Patient';
        patient.ElixirSuite__Email_Id__c = 'kj@gmail.com';
        patient.ElixirSuite__Patient_s_Birth_Date__c = System.today().addyears(-20);
        patient.ElixirSuite__MRN_Number__c = 1234567;
        patient.ElixirSuite__First_Name__c ='fname';
        patient.ElixirSuite__Last_Name__c ='lname';
        patient.ElixirSuite__SSN__c ='1234';
        patient.ElixirSuite__Gender__c='Male';
        patient.Phone ='9919850735';
        patient.BillingPostalCode='27440';
        insert patient;
        
        Id paymntTxnRecordTypeId = Schema.SObjectType.ElixirSuite__Payment_Transaction__c.getRecordTypeInfosByDeveloperName().get('Insurance_Payment').getRecordTypeId();
        
        //--------------------procedure insertion
        ElixirSuite__Procedure__c procedure2 = new ElixirSuite__Procedure__c();
        procedure2.Name = 'Test Procedure';
        procedure2.ElixirSuite__CPT_HCPCS_Code__c = '12345';
        procedure2.ElixirSuite__From_Date__c = System.today();
        procedure2.ElixirSuite__To_Date__c = System.today().addDays(1);
        procedure2.ElixirSuite__Account__c =  patient.Id;
        insert procedure2;
        
        //--------------------transaction insertion
        ElixirSuite__Payment_Transaction__c payTran = new ElixirSuite__Payment_Transaction__c();
        payTran.ElixirSuite__Actual_Price__c = 500;
        payTran.ElixirSuite__Procedure__c = procedure2.Id;
        payTran.ElixirSuite__Cpt_Codes__c = 'CPT100';
        payTran.ElixirSuite__Insurance_Payments__c = 200;
        payTran.ElixirSuite__Account__c = patient.Id;
        payTran.ElixirSuite__Total_Remaining_Amount__c = 40;
        payTran.RecordTypeId = paymntTxnRecordTypeId;
        payTran.ElixirSuite__Patient_Payments__c = 100;
        payTran.ElixirSuite__Payment_Adjustments__c = 10;
        insert payTran;
        
        //---------------------------------claim insertion
        ElixirSuite__Claim__c claimRecord = new ElixirSuite__Claim__c();
        claimRecord.ElixirSuite__claim_status__c = 'Clearing house accepted';
        claimRecord.ElixirSuite__Account__c = patient.Id;
        claimRecord.ElixirSuite__pcn__c = 'John';
        claimRecord.ElixirSuite__patient_first_Name__c = 'David';
        claimRecord.ElixirSuite__patient_last_Name__c = 'Beckam';
        claimRecord.ElixirSuite__npi__c = '1831234939';
        claimRecord.ElixirSuite__payer_id__c = '20413';
        claimRecord.ElixirSuite__other_payer_name__c = 'LIC';
        claimRecord.ElixirSuite__Insured_s_ID_Number__c = '1232';
        claimRecord.ElixirSuite__patient_dob__c = System.today().addYears(-40);
        claimRecord.ElixirSuite__patient_sex__c = 'M';
        claimRecord.ElixirSuite__insured_s_name__c = 'David';
        claimRecord.ElixirSuite__insured_s_name__c = 'Beckam';
        claimRecord.ElixirSuite__payer_order__c = 'Primary';
        claimRecord.ElixirSuite__patient_s_address__c = 'Noida';
        claimRecord.ElixirSuite__patient_s_city__c = 'Noida';
        claimRecord.ElixirSuite__patient_country_code__c = 'IN';
        claimRecord.ElixirSuite__patient_s_state__c = 'UP';
        claimRecord.ElixirSuite__patient_s_zipcode__c = 201301;
        claimRecord.ElixirSuite__Patient_Relationship_to_Insured__c = 'Father';
        claimRecord.ElixirSuite__insured_address__c = 'Noida';
        claimRecord.ElixirSuite__insured_city__c = 'Noida';
        claimRecord.ElixirSuite__insured_country_code__c = 'IN';
        claimRecord.ElixirSuite__insured_state__c = 'UP';
        claimRecord.ElixirSuite__insured_zipcode__c = 201301;
        claimRecord.ElixirSuite__employment_related__c = 'No';
        claimRecord.ElixirSuite__Auto_Accident_Related__c = 'No';
        claimRecord.ElixirSuite__insured_dob__c = System.today().addYears(-10);
        claimRecord.ElixirSuite__insured_sex__c = 'M';
        claimRecord.ElixirSuite__Place_of_Service__c = 'Delhi';
        claimRecord.ElixirSuite__bill_taxid__c = '123656789';
        claimRecord.ElixirSuite__Billing_Provider_Tax_ID_Type__c = 'E';
        claimRecord.ElixirSuite__Accept_Assignment__c = 'Y';
        claimRecord.ElixirSuite__total_charge__c = 900;
        claimRecord.ElixirSuite__amount_paid__c = 0;
        claimRecord.ElixirSuite__Billing_Provider_Name__c = 'ATHENA';
        claimRecord.ElixirSuite__Billing_Provider_Address_1__c = 'Watertown';
        claimRecord.ElixirSuite__Billing_Provider_State__c = 'CA';
        claimRecord.ElixirSuite__Billing_Provider_Zip__c = '232329998';
        claimRecord.ElixirSuite__Bill_Phone__c = '4152155300';
        claimRecord.ElixirSuite__Billing_Provider_City__c = 'Watertown';
        claimRecord.ElixirSuite__Diag_1__c = 'B86';
        claimRecord.ElixirSuite__Posted__c = false;
        insert claimRecord;
        
        //--------------------claim line item insertion
        ElixirSuite__Claim_Line_Items__c rec = new ElixirSuite__Claim_Line_Items__c();
        rec.ElixirSuite__CPT_HCPCS_Code__c = '38525';
        rec.ElixirSuite__Days_Units__c = 2;
        rec.ElixirSuite__From_Date__c = System.today().adddays(-10);
        rec.ElixirSuite__To_Date__c = System.today().adddays(-8);
        rec.ElixirSuite__procedure_charge__c = 900;
        rec.ElixirSuite__diag_ref__c = 'A';
        rec.ElixirSuite__claim__c = claimRecord.Id;
        rec.ElixirSuite__Procedure__c = procedure2.Id;
        insert rec;
        
        ElixirSuite__Claim__c claimRec = [Select id, Name from ElixirSuite__Claim__c where ElixirSuite__Account__c =: patient.Id LIMIT 1];
        ElixirSuite__Claim_Line_Items__c cliRec = [Select id, Name from ElixirSuite__Claim_Line_Items__c where ElixirSuite__Claim__c =: claimRec.Id LIMIT 1];
        
        String ClName = claimRec.Name;
        ClName = ClName.replaceAll('-', '');
        String CliName = cliRec.Name;
        CliName = CliName.replaceAll('-', '');
        
        
        claimRecord.ElixirSuite__Posted__c =false;
        update claimRecord;
        
        Data_Staging__c objDataRecord2  = new Data_Staging__c(
            Status__c = 'Is Download',
            EDI_Type__c = '999 EDI'
        );
        insert objDataRecord2;
        Blob fileData = Blob.valueOf('ISA*00**00**ZZ*SENDERID*ZZ*RECEIVERID*180101*2359*U*00401*000000001*0*T*:~ GS*FA*SENDERID*RECEIVERID*20180101*2359*1*X*004010~ ST*999*0001~ AK1*HC*121~ AK2*837*987654*A*E*004010X098A1~ AK5*A~ AK2*850*123456*A~ AK5*R*2/5:20,4/7:30~ AK9*E*2*2*1~ SE*8*0001~ GE*1*1~ IEA*1*000000001~ 		');        
        ContentVersion testContentVersion = new ContentVersion(
            Title = 'era_EDI_999_Test_File',
            VersionData = fileData,
            PathOnClient = 'EDI_999_Test_File.txt',
            Description = 'Test Description'
        );
        insert testContentVersion;
        
        testContentVersion = [SELECT Id, ContentDocumentId FROM ContentVersion WHERE Id = :testContentVersion.Id LIMIT 1];
        
        ContentDocumentLink testContentDocumentLink = new ContentDocumentLink(
            ContentDocumentId = testContentVersion.ContentDocumentId,
            LinkedEntityId = objDataRecord2.Id,
            ShareType = 'V',
            Visibility = 'AllUsers'
        );
        insert testContentDocumentLink;
        
        Test.startTest();
        EDIParser.getJSONtoReconcile(objDataRecord2.Id);
        EDIParser.reconcileEDI835JSON(null, null);
        Test.stopTest();
    }
}