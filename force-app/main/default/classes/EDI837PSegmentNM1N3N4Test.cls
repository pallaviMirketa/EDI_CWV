@isTest
public class EDI837PSegmentNM1N3N4Test {
    @isTest
    public static void generateNM1N3N4SegmentTest(){
        Organization objOrg =  [SELECT Id, Name, Address, Phone, Fax FROM Organization];
        
        ElixirSuite__CMS_1500_Claim_Generation__c testClaim1500  =new ElixirSuite__CMS_1500_Claim_Generation__c(
            ElixirSuite__Billing_Provider_NPI__c = '123',
            ElixirSuite__Billing_Provider_Address__c = 'street',
            ElixirSuite__Billing_Provider_City__c = 'dexter',
            ElixirSuite__Billing_Provider_State__c = 'CA',
            ElixirSuite__Billing_Provider_Zipcode__c = '7575'
        );
        insert testClaim1500;
        Test.startTest();
        EDI837PSegmentNM1N3N4.generateNM1N3N4Segment(objOrg, testClaim1500);
        EDI837PSegmentNM1N3N4.generateNM1N3N4Segment(null, testClaim1500);
        Test.stopTest();
    }
    
}