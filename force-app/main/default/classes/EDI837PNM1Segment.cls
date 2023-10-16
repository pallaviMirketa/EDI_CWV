public class EDI837PNM1Segment {
    public static String generateNM1Segment(List<ElixirSuite__Claim__c> lstClaim,Organization objOrg, String identifierCode){
      /* try{
            switch on(identifierCode){
                when identifierCode = '40'{ //Rec
                   String NM1Receiver = EDI837PNM1Segment.generateNM1Segment(lstClaim);// 9 Parameters for NM1 Segment
                    return NM1Receiver;
                }
                  when identifierCode = '85'{
                   String NM1Provider = EDI837PNM1Segment.generateN3Segment(lstClaim);
                    //N3
                    //N4
                    return NM1+N3+N4;
                }
            }
             
        }
        catch(exception e){
            ElixirSuite__Exception_Log__c objExp = new ElixirSuite__Exception_Log__c();
            objExp.ElixirSuite__Stack_Trace_Long__c = 'EDI837p: Error ocuured NM1 Segment.' +  e.getMessage();
            Insert objExp;
            return null;
        }
    }
        
        public static String generateNM1Segment(String IDCode, String typeQualifier, Organization objOrg, String firstName,
                                                String codeQualifier, String submitterId){
         String NM1 = 'NM1';
            NM1 += '*' + IDCode; //101- Entity Identifier
            NM1 += '*' + typeQualifier; //102- Entity Type Qualifier
            NM1 += '*' + objOrg.Name; //103- Organization Name or Last Name
            NM1 += '*' + firstName; //first name - 104
            NM1 += '*'; //middle name -105
            NM1 += '*'; //prefix- 106
            NM1 += '*'; //suffix- 107
            NM1 += '*' + codeQualifier; //108- Identification Code Qualifier
            NM1 += '*' + submitterId; // 109- Submitter Identifier 
                                                    
            return NM1;
    }
      public static String generateN3Segment(String address1, String address2){
         String N3 = 'N3';
         N3 += '*' +  address1;*/
         return null;
      }
}