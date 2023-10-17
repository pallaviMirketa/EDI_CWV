public class EDI837PSegmentNM1N3N4 {
    public static Map<String,String> generateNM1N3N4Segment(Organization objOrg, ElixirSuite__CMS_1500_Claim_Generation__c objClaim1500){
        Map<String,String> NM1N3N4Data = new Map<String,String>();
        try{
            //Submitter - only NM1 Segment
            String NM1Submitter = EDI837PSegmentNM1N3N4.generateNM1Segment('41','2',objOrg.Name,'','46','75225');// 6 Parameters for NM1 Segment
            NM1N3N4Data.put('41', NM1Submitter );
            //Receiver - only NM1 Segment
            String NM1Receiver = EDI837PSegmentNM1N3N4.generateNM1Segment('40','2','DCMHRS','','46','100000');
            NM1N3N4Data.put('40', NM1Receiver );
            //Billing Provider -NM1, N3, N4 Segments
            String NM1BillingProvider = EDI837PSegmentNM1N3N4.generateNM1Segment('85','2',objOrg.Name,'','XX',objClaim1500.ElixirSuite__Billing_Provider_NPI__c);
            String N3BillingProvider = EDI837PSegmentNM1N3N4.generateN3Segment(objClaim1500.ElixirSuite__Billing_Provider_Address__c);
            String N4BillingProvider = EDI837PSegmentNM1N3N4.generateN4Segment(objClaim1500.ElixirSuite__Billing_Provider_City__c, 
                                                                               objClaim1500.ElixirSuite__Billing_Provider_State__c,
                                                                               objClaim1500.ElixirSuite__Billing_Provider_Zipcode__c);
            NM1N3N4Data.put('85', (NM1BillingProvider + N3BillingProvider + N4BillingProvider));
            return NM1N3N4Data;
        } 
        catch(exception e){
            ElixirSuite__Exception_Log__c objExp = new ElixirSuite__Exception_Log__c();
            objExp.ElixirSuite__Stack_Trace_Long__c = 'EDI837p: Error ocuured NM1 Segment.' +  e.getMessage();
            Insert objExp;
            return null;
        }
    }
    public static String generateNM1Segment(String IDCode, String typeQualifier, String orgName, String firstName,String codeQualifier, String submitterId){
        String NM1 = 'NM1';
        NM1 += '*' + IDCode; //101- Entity Identifier
        NM1 += '*' + typeQualifier; //102- Entity Type Qualifier
        NM1 += '*' + orgName; //103- Organization Name or Last Name
        NM1 += '*' + firstName; //first name - 104
        NM1 += '*'; //middle name -105
        NM1 += '*'; //prefix- 106
        NM1 += '*'; //suffix- 107
        NM1 += '*' + codeQualifier; //108- Identification Code Qualifier
        NM1 += '*' + submitterId; // 109- Submitter Identifier 
        NM1 += '~';
        
        return NM1 + '\n';
    }
    public static String generateN3Segment(String address1){
        String N3 = 'N3';
        N3 += '*' +  address1;
        N3 += '~';
        return N3 + '\n';
    }
    public static String generateN4Segment(String City, String State, String Zipcode){
        String N4 = 'N4';
        N4 += '*' +  City;
        N4 += '*' +  State;
        N4 += '*' +  Zipcode;
        N4 += '~';
        return N4 + '\n';
    }
}