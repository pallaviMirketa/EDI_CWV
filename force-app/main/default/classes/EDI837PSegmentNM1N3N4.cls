public class EDI837PSegmentNM1N3N4 {
    public static Map<String,String> generateNM1N3N4Segment(Organization objOrg, ElixirSuite__CMS_1500_Claim_Generation__c objClaim1500,
                                                            ElixirSuite__Claim__c objClaim ){
        Map<String,String> NM1N3N4Data = new Map<String,String>();
        try{
            //Submitter - only NM1 Segment
            
            String NM1Submitter = EDI837PSegmentNM1N3N4.generateNM1Segment(EDIDataMappings.submitterEntityIdentifierCode,
                                                                           EDIDataMappings.submitterEntityTypeQualifier,
                                                                           objOrg.Name,'','','','',
                                                                           EDIDataMappings.submitterIdentificationCodeQualifier,
                                                                           EDIDataMappings.submitterIdentifier);
            NM1N3N4Data.put('41', NM1Submitter );
            
            //Receiver - only NM1 Segment
            String NM1Receiver = EDI837PSegmentNM1N3N4.generateNM1Segment(EDIDataMappings.recieverEntityIdentifierCode,
                                                                          EDIDataMappings.recieverEntityTypeQualifier,
                                                                          EDIDataMappings.recieverName,'','','','',
                                                                          EDIDataMappings.recieverIdentificationCodeQualifier,
                                                                          EDIDataMappings.recieverPrimaryIdentifier);
            NM1N3N4Data.put('40', NM1Receiver );
            
            //Billing Provider -NM1, N3, N4 Segments
            String NM1BillingProvider = EDI837PSegmentNM1N3N4.generateNM1Segment(EDIDataMappings.billingProviderEntityIdentifierCode,
                                                                                 EDIDataMappings.billingProviderEntityTypeQualifier,
                                                                                 objOrg.Name,'','','','',
                                                                                 EDIDataMappings.billingProviderIdentificationCodeQualifier,
                                                                                 objClaim1500.ElixirSuite__Billing_Provider_NPI__c);
            
            String N3BillingProvider = EDI837PSegmentNM1N3N4.generateN3Segment(objClaim1500.ElixirSuite__Billing_Provider_Address__c);
            String N4BillingProvider = EDI837PSegmentNM1N3N4.generateN4Segment(objClaim1500.ElixirSuite__Billing_Provider_City__c, 
                                                                               objClaim1500.ElixirSuite__Billing_Provider_State__c,
                                                                               objClaim1500.ElixirSuite__Billing_Provider_Zipcode__c);
          
            NM1N3N4Data.put('85', (NM1BillingProvider + N3BillingProvider + N4BillingProvider));
            System.debug('Provider : ' + NM1N3N4Data.get('85'));
            
            //Subscriber Details
            System.debug('lastname '+objClaim.ElixirSuite__VOB_lookup__r.ElixirSuite__Insured_Last_Name__c);
            String NM1Subscriber = EDI837PSegmentNM1N3N4.generateNM1Segment(EDIDataMappings.subscriberEntityIdentifierCode,
                                                                            EDIDataMappings.subscriberEntityTypeQualifier,
                                                                            objClaim.ElixirSuite__VOB_lookup__r.ElixirSuite__Insured_Last_Name__c,
                                                                            objClaim.ElixirSuite__VOB_lookup__r.ElixirSuite__Insured_First_name__c, '',
                                                                            '','',
                                                                            EDIDataMappings.subscriberIdentificationCodeQualifier,
                                                                            EDIDataMappings.subscriberPrimaryIdentifier);//SSN
            String N3Subscriber = '';
            String N4Subscriber = '';
            if(objClaim.ElixirSuite__VOB_lookup__r.ElixirSuite__Insured_Address__c != null){
                 N3Subscriber = EDI837PSegmentNM1N3N4.generateN3Segment(objClaim.ElixirSuite__VOB_lookup__r.ElixirSuite__Insured_Address__c);
            }
            if(objClaim.ElixirSuite__VOB_lookup__r.ElixirSuite__Insured_City__c != null){
             N4Subscriber = EDI837PSegmentNM1N3N4.generateN4Segment(objClaim.ElixirSuite__VOB_lookup__r.ElixirSuite__Insured_City__c,
                                                                           objClaim.ElixirSuite__VOB_lookup__r.ElixirSuite__Insured_State__c,
                                                                           String.Valueof(objClaim.ElixirSuite__VOB_lookup__r.ElixirSuite__Insured_Zipcode__c));
            } 
            NM1N3N4Data.put('IL', (NM1Subscriber + N3Subscriber + N4Subscriber));
            
            //Payor Details
            String NM1Payor = EDI837PSegmentNM1N3N4.generateNM1Segment(EDIDataMappings.payorEntityIdentifierCode,
                                                                       EDIDataMappings.payorEntityTypeQualifier,
                                                                       EDIDataMappings.payorName,
                                                                       '','','','',
                                                                       EDIDataMappings.payorIdentificationCodeQualifier,
                                                                       objClaim.ElixirSuite__Payor__r.ElixirSuite__Payer_Code__c);
            NM1N3N4Data.put('PR', NM1Payor );
            
            //Rendering Provider Details
              String NM1RenderingProvider = '';
              String RenderingProviderName = EDIDataUtils.analyze(objClaim.Rendering_Provider_First__c, 35) + ' ' + EDIDataUtils.analyze(objClaim.Rendering_Provider_Last__c, 60);
            if(objClaim.Rendering_Provider_First__c != null && objClaim.Rendering_Provider_Last__c != null){
               NM1RenderingProvider = EDI837PSegmentNM1N3N4.generateNM1Segment('82','1',RenderingProviderName.trim(),
                                                                                       '','' ,'','','XX',
                                                                                       objClaim.Rendering_Provider_NPI__c);
            }
            NM1N3N4Data.put('82', NM1RenderingProvider );
            
            System.debug('NM1N3N4Data '+ NM1N3N4Data);
            return NM1N3N4Data; 
            
        } 
        catch(exception e){
            ElixirSuite__Exception_Log__c objExp = new ElixirSuite__Exception_Log__c();
            objExp.ElixirSuite__Stack_Trace_Long__c = 'EDI837p: Error occurred NM1 Segment.' +  e.getMessage();
            Insert objExp;
            return null;
        }
    }
    public static String generateNM1Segment(String IDCode, String typeQualifier, String lastName, String firstName, String middleName, String prefix,
                                            String suffix, String codeQualifier, String submitterId){
        String NM1 = 'NM1';
        NM1 += '*' + IDCode; //101- Entity Identifier
        NM1 += '*' + typeQualifier; //102- Entity Type Qualifier
        NM1 += '*' + EDIDataUtils.analyze(lastName, 60); //103- Organization Name or Last Name
        NM1 += '*' + EDIDataUtils.analyze(firstName, 35); //first name - 104
        NM1 += '*' + EDIDataUtils.analyze(middleName, 25); //middle name -105
        NM1 += '*' + EDIDataUtils.analyze(prefix, 10); //prefix- 106
        NM1 += '*' + EDIDataUtils.analyze(suffix, 10); //suffix- 107
        NM1 += '*' + EDIDataUtils.analyze(codeQualifier, 2); //108- Identification Code Qualifier
        NM1 += '*' + EDIDataUtils.analyze(submitterId, 80); // 109- Submitter Identifier 
        NM1 += '~';
        
        return NM1 + '\n';
    }
    public static String generateN3Segment(String address1){
        String N3 = 'N3';
        N3 += '*' + EDIDataUtils.analyze(address1, 55);
        N3 += '~';
        return N3 + '\n';
    }
    public static String generateN4Segment(String City, String State, String Zipcode){
        String N4 = 'N4';
        N4 += '*' +  EDIDataUtils.analyze(City, 30);
        N4 += '*' +  EDIDataUtils.analyze(State, 2);
        N4 += '*' +  EDIDataUtils.analyze(Zipcode, 15);
        N4 += '~';
        return N4 + '\n';
    }
}