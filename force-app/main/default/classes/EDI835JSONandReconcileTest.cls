@isTest
public class EDI835JSONandReconcileTest {
    @isTest
    public static void getJSONtoReconcile(){
        Data_Staging__c objDataRecord  = new Data_Staging__c(
            Status__c = '835 EDI Received'
        );
        insert objDataRecord;
        Blob fileData = Blob.valueOf('ISA*00*          *00*          *ZZ*12202          *ZZ*12804          *231107*0915*^*00501*032059464*0*P*:~ GS*HP*12202*12804*20231107*0915*1*X*005010X221A1~ ST*835*0001~ BPR*I*80.91*C*ACH*CCP*01*081517693*DA*152302017081*1205296137**01*044000037*DA*371853208*20231108~ TRN*1*887877325*1205296137~ REF*EV*1935740~ DTM*405*20231107~ N1*PR*NOVITAS SOLUTIONS, INC.~ N3*PO BOX 3413~ N4*MECHANICSBURG*PA*170551852~ REF*2U*12202~ PER*CX**TE*8772358073~    PER*BL*NOVITAS SOLUTIONS, INC. EDI SERVICES*TE*8772358073*EX*1*EM*WEBSITEEDI@NOVITAS-SOLUTIONS.COM~ N1*PE*COMMUNITY WELLNES VENT*XX*1275903700~ N3*1930 MLK JR AVE SE~ N4*WASHINGTON*DC*200207006~ REF*TJ*474923631~ LX*1~ CLP*CLAIM1873*1*103.2*80.91*20.64*MB*1923298291710*11*1~ NM1*QC*1*JEFFERSON*DEJUAN****MI*1AR9MV2PQ54~ NM1*82*1******XX*1568402600~ MOA***MA01~ DTM*050*20231025~ SVC*HC:90846*103.2*80.91**1~ DTM*472*20230905~ CAS*CO*253*1.65~     CAS*PR*2*20.64~ REF*LU*11~ REF*6R*CL-1996~ AMT*B6*103.2~ SE*29*0001~ GE*1*1~ IEA*1*032059464~');
        
        ContentVersion testContentVersion = new ContentVersion(
            Title = 'EDI_835_Test_File',
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
        
        Test.startTest();
        EDI835JSONandReconcile.getJSONtoReconcile(objDataRecord.Id);
        Test.stopTest();
    }
    
}