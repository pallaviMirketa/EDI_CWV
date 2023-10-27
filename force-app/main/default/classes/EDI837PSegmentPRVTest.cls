@istest
public class EDI837PSegmentPRVTest {
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
        User usr = EDI837PSegmentPRVTest.createTestUser('Jacob', 'Smith'); 
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
                ElixirSuite__Provider_Code__c = '1275903700',
                ElixirSuite__Provider_Taxonomy__c = '123456789'
                
            );
            insert testProvider; 
            Test.startTest();
            String result = EDI837PSegmentPRV.generatePRVSegment(testProvider);
            String result1 = EDI837PSegmentPRV.generatePRVSegment(null);
            Test.stopTest();
        }
        
    }
}