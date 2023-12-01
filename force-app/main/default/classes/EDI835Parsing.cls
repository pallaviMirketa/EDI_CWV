public class EDI835Parsing {
   // Define classes to represent the JSON structure
    public List<Elixir> Elixir;
    
    public class Elixir  {
        //public List<RawData> RawData;
       // public List<Adjustment> adjustments;
        public List<Claim> claims;
    }
    /*
    public class RawData {
    }
    public class Adjustment {
        
    }*/
    public class Claim {
        public String patientClaimControlNumber;
        public String patientClaimStatusCode;
        public Decimal totalClaimChargeAmount;
        public Decimal totalAmountPaid;
        public String payerClaimControlNumber;
        public List<Service> services;
    }
    public class Service {
        public String serviceTypeCode;
        public String serviceCode;
        public Decimal serviceChargeAmt;
        public Decimal providerPaymentAmt;
        public List<ServiceIdentification> serviceIdentification;
        public List<ServiceDate> service;
        public List<Adjust> adjust;
        public List<ServiceSupplementalInfo> serviceSupplementalInfo;
    }
    
    public class ServiceIdentification {
        public String referenceIdentificationQualifier;
        public String referenceIdentification;
    }
    
    public class ServiceDate {
        public String dateTimeQualifier;
        public string serviceDate;
    }
    
    public class Adjust {
        public String claimAdjustmentGroupCode;
        public String adjustmentCodeReason;
        public Decimal adjustmentAmt;
        public String adjustmentCodeReason1;
        public Decimal adjustmentAmt1;
        public String adjustmentCodeReason2;
        public Decimal adjustmentAmt2;
        public String adjustmentCodeReason3;
        public Decimal adjustmentAmt3;
        public String adjustmentCodeReason4;
        public Decimal adjustmentAmt4;
        public String adjustmentCodeReason5;
        public Decimal adjustmentAmt5;
        public String adjustmentCodeReason6;
        public Decimal adjustmentAmt6;
        public String adjustmentCodeReason7;
        public Decimal adjustmentAmt7;
    }
    
    public class ServiceSupplementalInfo {
        public String amountQualifierCode;
        public Decimal serviceLineAllowedAmt;
    }
    
    // Parsing the JSON string and deserialize it into an instance of the Elixir class
    
    public static void PostClaimUpdation(String jsonStr){
        System.debug('eeee');
        EDI835Parsing response = (EDI835Parsing) JSON.deserialize(jsonStr, EDI835Parsing.class);
        ElixirSuite__ERA_Generation__c eraCS = ElixirSuite__ERA_Generation__c.getInstance();
        Boolean manualERA = eraCS.ElixirSuite__Manual_ERA_Posting_Opted__c==null?false:eraCS.ElixirSuite__Manual_ERA_Posting_Opted__c;
        Map<String,List<String>> claimVSEras = new Map<String,List<String>>();
        Map<String,ElixirSuite__ERA_Line_Item__c> eraLineItemsMap = new Map<String,ElixirSuite__ERA_Line_Item__c>();
        Map<String,ElixirSuite__ERA_Line_Item__c> upEraLineItemsMap = new Map<String,ElixirSuite__ERA_Line_Item__c>();
        list<ElixirSuite__EOB__c> eraListToInsert = new list<ElixirSuite__EOB__c>();
        Map<String,ElixirSuite__EOB__c> ERAMap = new Map<String,ElixirSuite__EOB__c>();
        Map<String,ElixirSuite__EOB__c> uniqueERAMap = new Map<String,ElixirSuite__EOB__c>();
        list<ElixirSuite__ERA_Line_Item__c> eraLineItemsToInsert = new list<ElixirSuite__ERA_Line_Item__c>();
        list<ElixirSuite__ERA_Line_Item__c> eraLineItemsToUpdate = new list<ElixirSuite__ERA_Line_Item__c>();
        List<ElixirSuite__Claim_Line_Items__c> claimLineItemsToUpdate = new List<ElixirSuite__Claim_Line_Items__c>();
        List<ElixirSuite__Claim__c> claimsToUpdate = new List<ElixirSuite__Claim__c>();
        List<String> eraNameList = new List<String>();
        String orgsId = (UserInfo.getOrganizationId()).toUpperCase();
        Map<String,String> eraStatusdMap = new Map<String,String>{'1' =>'Process as Primary','2'=>'Processed as Secondary',
            '3' =>'Processed as Tertiary','4' =>'Denied','19' =>'19: Processed as Primary, Forwarded to Additional Payer(s)',
            '20' => '20: Processed as Secondary, Forwarded to Additional Payer(s)','21' => '21: Processed as Tertiary, Forwarded to Additional Payer(s)',
            '22' => '22: Reversal of Previous Payment','23' => '23: Not our Claim, Forwarded to Additional Payer(s)','25' => '25: Predetermination Pricing Only – No Payment'};
                
                Map<String, ElixirSuite__Claim__c> claimMap = new Map<String, ElixirSuite__Claim__c>();
        Map<String, ElixirSuite__Claim_Line_Items__c> claimLineItemsMap = new Map<String, ElixirSuite__Claim_Line_Items__c>();
        ElixirSuite__EOB__c masterEra = new ElixirSuite__EOB__c();
        insert masterEra;
        Integer serial = 0;
        for (EDI835Parsing.Claim jsonClaim : response.Elixir[0].claims) {
            System.debug('Claimm '+jsonClaim);
            decimal TotalCharge = 0;
            decimal TotalAmount = 0;
            TotalCharge =  jsonClaim.totalClaimChargeAmount;
            TotalAmount =  jsonClaim.totalAmountPaid;
            ElixirSuite__EOB__c era;
            Boolean eraLineExist = false;
            era = new ElixirSuite__EOB__c();
            String outputString;
            String uniqueKey;
            If(jsonClaim.services != null){
               
               Boolean notFoundControlNumber = false; 
                for (EDI835Parsing.Service jsonService : jsonClaim.services) {
                    System.debug('jsonService '+jsonService);
                    String inputString;
                    if(String.isNotBlank(jsonClaim.patientClaimControlNumber) && jsonClaim.patientClaimControlNumber != 'NOT FOUND' && (jsonClaim.patientClaimControlNumber.startsWithIgnoreCase('claim') || jsonClaim.patientClaimControlNumber.startsWithIgnoreCase('cs')) ){
                        notFoundControlNumber = true;
                        if(jsonClaim.patientClaimControlNumber.contains('CLAIM')){
                            if(jsonClaim.patientClaimControlNumber.contains(orgsId)){
                              inputString = jsonClaim.patientClaimControlNumber.substringBefore(orgsId);
                            }else{
                             inputString = jsonClaim.patientClaimControlNumber;
                            }
                            if(inputString.contains('-')){
                                String firstWord = inputString.substring(0, 5);
                                String capitalizedFirstWord = firstWord.substring(0, 1).toUpperCase() + firstWord.substring(1).toLowerCase();
                                outputString = capitalizedFirstWord + '-' + inputString.substring(6);
                                uniqueKey = outputString + ';' + string.valueOf(serial);
                            }else{
                                String firstWord = inputString.substring(0, 5);
                                String capitalizedFirstWord = firstWord.substring(0, 1).toUpperCase() + firstWord.substring(1).toLowerCase();
                                outputString = capitalizedFirstWord + '-' + inputString.substring(5); 
                                uniqueKey = outputString + ';' + string.valueOf(serial);
                            }
                        }else{
                            outputString = jsonClaim.patientClaimControlNumber;
                            uniqueKey = outputString + ';' + string.valueOf(serial);
                        }
                       
                        era.ElixirSuite__Total_Charge__c = TotalCharge;
                        era.ElixirSuite__ERA_Status_Code__c = eraStatusdMap.get(jsonClaim.patientClaimStatusCode);
                        era.ElixirSuite__Net_Paid_Amt__c = TotalAmount;
                        era.ElixirSuite__Pcn__c = jsonClaim.patientClaimControlNumber;
                        era.ElixirSuite__Payer_Claim__c = jsonClaim.payerClaimControlNumber;
                        era.ElixirSuite__Payer_ICN__c = jsonClaim.payerClaimControlNumber;
                         
                        if(manualERA){
                            era.ElixirSuite__Manual_ERA__c = true;
                            era.ElixirSuite__Manual_ERA_Status__c = 'ERA Generated';
                        }
                    
                    if(notFoundControlNumber){
                    
                        ElixirSuite__ERA_Line_Item__c eraLineItem = new ElixirSuite__ERA_Line_Item__c();
                        eraLineItem.ElixirSuite__Charge__c = jsonService.serviceChargeAmt;
                        eraLineItem.ElixirSuite__Paid__c = jsonService.providerPaymentAmt;
                        if(jsonService.serviceSupplementalInfo != null){
                            System.debug('serviceIdentification '+jsonService.serviceSupplementalInfo);
                             for (EDI835Parsing.ServiceSupplementalInfo serviceIdentificationinfo : jsonService.serviceSupplementalInfo) {
                                eraLineItem.ElixirSuite__Total_Allowed_Amount__c = serviceIdentificationinfo.serviceLineAllowedAmt;
                             }
                        }else{
                          eraLineItem.ElixirSuite__Total_Allowed_Amount__c = 0; 
                        }
                        System.debug('aaaa ');
                        if(jsonService.service != null){
                            for (EDI835Parsing.ServiceDate service : jsonService.service) {
                                
                            String dateString = service.serviceDate;
                            // String dateString = '';
                            Integer year = Integer.valueOf(dateString.substring(0, 4));
                            Integer month = Integer.valueOf(dateString.substring(4, 6));
                            Integer day = Integer.valueOf(dateString.substring(6, 8));
                            Date d = Date.newInstance(year, month, day);
                            Datetime dt = Datetime.newInstance(d.year(), d.month(), d.day(), 0, 0, 0);
                            eraLineItem.ElixirSuite__From_Dos__c = dt.format('MM/dd/yyyy');
                                
                            }
                      
                        }
                        System.debug('bbbb ');
                        eraLineItem.ElixirSuite__Proc_code__c = jsonService.serviceCode;
                        
                        Decimal PatRes = 0;
                        String patResValue = 'PR';
                        if (jsonService.adjust != null) {
                        List<Object> adjustments = (List<Object>)jsonService.adjust;
                        if(adjustments != null && adjustments.size() > 0){
                            for(Integer i=1 ; i<=adjustments.size() ; i++){
                                EDI835Parsing.Adjust adjust = (EDI835Parsing.Adjust)adjustments[i-1];
                                if(adjust != null){
                                    eraLineItem.put('ElixirSuite__Adjustment_Amount_'+ i + '__c', adjust.adjustmentAmt);
                                    eraLineItem.put('ElixirSuite__Group_'+ i + '__c', adjust.claimAdjustmentGroupCode);
                                    eraLineItem.put('ElixirSuite__Code_'+ i + '__c', adjust.adjustmentCodeReason);
                                    eraLineItem.put('ElixirSuite__Count_of_total_adjustments_used__c', i);
                                    if(adjust.claimAdjustmentGroupCode.containsIgnoreCase(patResValue)){
                                            PatRes = PatRes+ adjust.adjustmentAmt; 
                                   }
                                 }
                            }
                        }
                        }
                        
                        eraLineItem.ElixirSuite__Patient_Responsibility__c = PatRes;
                        if(jsonService.serviceIdentification !=null){
                            System.debug('serviceIdentification '+jsonService.serviceIdentification);
                             for (EDI835Parsing.ServiceIdentification serviceIdentification : jsonService.serviceIdentification) {
                                   System.debug('serviceIdentificationinside for'+serviceIdentification);
                                   System.debug('serviceIdentificationinside '+serviceIdentification.referenceIdentification);
                                if(serviceIdentification.referenceIdentification!=null && serviceIdentification.referenceIdentification!='' && serviceIdentification.referenceIdentification.startsWithIgnoreCase('cl-')){
                                   
                                    String cliKey = serviceIdentification.referenceIdentification;
                                    if(!cliKey.contains('-')){
                                      Integer index1 = eraLineItem.ElixirSuite__chg_Id__c.toLowerCase().lastIndexOf('l');
                                      String numVal = eraLineItem.ElixirSuite__chg_Id__c.subString(index1+1,eraLineItem.ElixirSuite__chg_Id__c.length());
                                      cliKey = 'CL'+'-'+numVal;  
                                    }
                                    String unqiueEraLineKey = uniqueKey + serviceIdentification.referenceIdentification;
                                    eraLineItem.ElixirSuite__Chg_Id__c = unqiueEraLineKey;
                                    eraLineItemsToInsert.add(eraLineItem);
                                    eraLineExist = true;
                                    
                                    eraLineItemsMap.put(unqiueEraLineKey,eraLineItem);
                                    upEraLineItemsMap.put(cliKey,eraLineItem);
                                }
                                 
                            }
                        }
                        
                    
                }
                }
            }
            }
            if(eraLineExist){
                                    era.ElixirSuite__EOB__c = masterEra.Id;
                                    eraListToInsert.add(era); 
                                     System.debug('cmmm '+claimVSEras);
                                    if(claimVSEras == null || (claimVSEras != null && !claimVSEras.containsKey(outputString))){
                                        List<String> CmList = new List<String>();
                                        CmList.add(uniqueKey);  
                                        claimVSEras.put(outputString,CmList);
                                        System.debug('cmmm 2 '+claimVSEras);
                                    }else{
                                        List<String> CmList = claimVSEras.get(outputString); 
                                        CmList.add(uniqueKey);
                                        claimVSEras.put(outputString,CmList);
                                        System.debug('cmmm 3 '+claimVSEras);
                                    }
                                    ERAMap.put(outputString,era);
                                    uniqueERAMap.put(uniqueKey,era);
                                 }
              serial++;
        }
        System.debug('eraListToInsert'+eraListToInsert.size());
         System.debug('eraLineItemsToInsert'+eraLineItemsToInsert);
        if(eraListToInsert.size() > 0){
        insert eraListToInsert;
        }
        if(eraLineItemsToInsert.size() > 0){ 
        insert eraLineItemsToInsert;
        }
        List<ElixirSuite__EOB__c> erasToUpdate = new List<ElixirSuite__EOB__c>();
        Set<Id> procedureIdSet = new Set<Id>();
        ElixirSuite__Master_Transaction__c[] otherTrasnactionLstForChildERA = new List<ElixirSuite__Master_Transaction__c>();
        ElixirSuite__Transactions__c[] toInsertTransaction = new List<ElixirSuite__Transactions__c>();
        Map<Id,ElixirSuite__Payment_Transaction__c> procedurePaymentTransactionMap = new Map<Id,ElixirSuite__Payment_Transaction__c>();
        Map<String,String> procTranMap = new Map<String,String>();
        Map<String,ElixirSuite__EOB__c> updatedPcnERAMap = new Map<String,ElixirSuite__EOB__c>();
        List<ElixirSuite__Payment_Transaction__c> mainPaymentTransactionsToUpdate = new List<ElixirSuite__Payment_Transaction__c>();
        Map<String,ElixirSuite__ERA_Line_Item__c> eliChargeIdMap = new Map<String,ElixirSuite__ERA_Line_Item__c>();
        
        for(ElixirSuite__ERA_Line_Item__c eli : [Select Id, ElixirSuite__chg_Id__c, ElixirSuite__Total_Allowed_Amount__c,ElixirSuite__Charge__c,ElixirSuite__Provider_Adjustment__c, ElixirSuite__Patient_Responsibility__c,ElixirSuite__Other_Insurance_Responsibility__c,ElixirSuite__Total_Adjustment_Amount__c, ElixirSuite__Paid__c,ElixirSuite__Proc_code__c 
                                                 FROM ElixirSuite__ERA_Line_Item__c 
                                                 WHERE ElixirSuite__Chg_Id__c IN :eraLineItemsMap.keySet()  
                                                 WITH SECURITY_ENFORCED
                                                 ORDER BY CreatedDate LIMIT 50000]){
                                                     eliChargeIdMap.put(eli.ElixirSuite__chg_Id__c,eli);
                                                 }
       
        system.debug('eliChargeIdMap--'+eliChargeIdMap);
        for(ElixirSuite__Claim_Line_Items__c cli : [Select Id,ElixirSuite__Procedure__r.Name, ElixirSuite__Procedure__c from ElixirSuite__Claim_Line_Items__c WHERE Name IN: upEraLineItemsMap.keySet() LIMIT 50000]){
            procedureIdSet.add(cli.ElixirSuite__Procedure__c);
        }
        for(ElixirSuite__Procedure__c pro : [SELECT Id, (SELECT Id, ElixirSuite__Actual_Price__c, ElixirSuite__Total_Remaining_Amount__c ,ElixirSuite__Status__c, ElixirSuite__Payment_Adjustments__c, 
                                             ElixirSuite__Total_Received_Amount__c, ElixirSuite__Insurance_Payments__c,ElixirSuite__Patient_Outstanding__c,ElixirSuite__Credit_Amount__c,ElixirSuite__Patient_Responsibility__c, ElixirSuite__ERA_Arrived__c
                                             FROM ElixirSuite__Payment_Transaction__r WHERE ElixirSuite__Master_Transaction__c = null AND ElixirSuite__Payment_Sub_Transaction__c = null LIMIT 1) 
                                             FROM ElixirSuite__Procedure__c WHERE Id IN: procedureIdSet 
                                             WITH SECURITY_ENFORCED
                                             LIMIT 50000]){
                                                 if(pro.ElixirSuite__Payment_Transaction__r.size()>0){
                                                     procedurePaymentTransactionMap.put(pro.Id,pro.ElixirSuite__Payment_Transaction__r[0]);
                                                     procTranMap.put(pro.Id,pro.ElixirSuite__Payment_Transaction__r[0].Id);
                                                 }
                                             } 
        List<ElixirSuite__Claim__c> clmList =  [SELECT Id, Name, ElixirSuite__Claim_Status__c,ElixirSuite__Account__c,ElixirSuite__Posted__c,ElixirSuite__Primary_Paid__c,ElixirSuite__Total_Amount_Paid_By_Insurance__c,ElixirSuite__Total_Charge__c,
                                               (SELECT Id,Name, ElixirSuite__Claim__c, ElixirSuite__Primary_Paid__c, ElixirSuite__CPT_HCPCS_Code__c,ElixirSuite__Total_Billed__c, 
                                               ElixirSuite__Procedure__c, ElixirSuite__Total_Allowed_Amount__c, ElixirSuite__ERA_Received__c, ElixirSuite__Total_Adjustment__c, ElixirSuite__Amount_Paid_by_Insurance__c,ElixirSuite__Diagnosis_Pointer__c 
                                               FROM ElixirSuite__Claim_Line_Items__r LIMIT 30000) FROM ElixirSuite__Claim__c WHERE Name  IN: ERAMap.keyset() OR Id IN:ERAMap.keyset() WITH SECURITY_ENFORCED];
         system.debug('ERAMap--'+ERAMap.keyset());
        system.debug('claimVSEras--'+claimVSEras);
        SObjectType objName1 = ((SObject) Type.forName('ElixirSuite__Claim__c').newInstance()).getSObjectType();
        Map<String,Schema.SObjectField> claimFieldMap = objName1.getDescribe().fields.getMap();
        String amountStatus = 'Amount_Status__c';
        List<ElixirSuite__EOB__c> rt = [Select ElixirSuite__Total_Paid__c,ElixirSuite__Claim__c from ElixirSuite__EOB__c
                                                WHERE ElixirSuite__Claim__c IN:clmList WITH SECURITY_ENFORCED];
        
        Map<String,Decimal> ClaimVSPaidAmt = new Map<String,Decimal>();
        for (ElixirSuite__EOB__c ar : rt)  {
            if(ClaimVSPaidAmt.isEmpty() || ClaimVSPaidAmt.size() == 0){
                ClaimVSPaidAmt.put(ar.ElixirSuite__Claim__c,ar.ElixirSuite__Total_Paid__c);
            }else if(ClaimVSPaidAmt.get(ar.ElixirSuite__Claim__c) == null){
                ClaimVSPaidAmt.put(ar.ElixirSuite__Claim__c,ar.ElixirSuite__Total_Paid__c);    
            }else{
                Decimal d = ClaimVSPaidAmt.get(ar.ElixirSuite__Claim__c);
                d = d+ar.ElixirSuite__Total_Paid__c;
                ClaimVSPaidAmt.put(ar.ElixirSuite__Claim__c,d); 
            }
        }
        System.debug('&&& '+ClaimVSPaidAmt); 
         Map<String,ElixirSuite__Claim__c> updatedClaimpList = new  Map<String,ElixirSuite__Claim__c>();
         Map<String,ElixirSuite__Claim_Line_Items__c> updateClineItemList = new  Map<String,ElixirSuite__Claim_Line_Items__c>();
         Map<String,ElixirSuite__Claim__c> updatedERAList = new  Map<String,ElixirSuite__Claim__c>();
        /*system.debug('Checking--'+ [SELECT Id, Name, ElixirSuite__Claim_Status__c,ElixirSuite__Account__c,ElixirSuite__Posted__c,ElixirSuite__Primary_Paid__c,
                                         (SELECT Id, ElixirSuite__Claim__c, ElixirSuite__Primary_Paid__c, ElixirSuite__CPT_HCPCS_Code__c, Name,ElixirSuite__Total_Billed__c, 
                                          ElixirSuite__Procedure__c, ElixirSuite__Total_Allowed_Amount__c, ElixirSuite__ERA_Received__c, ElixirSuite__Total_Adjustment__c, ElixirSuite__Amount_Paid_by_Insurance__c 
                                          FROM ElixirSuite__Claim_Line_Items__r LIMIT 30000) FROM ElixirSuite__Claim__c Where Name  IN: ERAMap.keyset()]);*/
        for (ElixirSuite__Claim__c cl : clmList) {
                                              system.debug('cl--'+cl);    
                                              String claimName = cl.Name;
                                              String clId = cl.Id;
                                              Boolean Status = false;
                                              if(claimVSEras.containsKey(cl.Name)){
                                              for(String key : claimVSEras.get(cl.Name)){ 
                                                  if(key.contains(claimName) || key.contains(clId)){
                                                  //String clN = (key).substringBefore(';');
                                                  ElixirSuite__EOB__c eraRec;
                                                  eraRec  = uniqueERAMap.get(key);
                                                   System.debug('eraRec '+eraRec);
                                                  Decimal totalAdjstAmt=0;
                                                  eraRec.ElixirSuite__Claim__c = cl.Id;
                                                  eraRec.ElixirSuite__Account__c = cl.ElixirSuite__Account__c;
                                                  eraRec.ElixirSuite__Total_Allowed__c = 0;
                                                  eraRec.ElixirSuite__Total_Paid__c = 0;  
                                                  eraRec.ElixirSuite__Total_Patient_Responsibility__c = 0; 
                                                  eraRec.ElixirSuite__Total_OI_Responsibility__c = 0;
                                                  eraNameList.add(eraRec.Id);
                                                  if(cl.ElixirSuite__Total_Amount_Paid_By_Insurance__c == null){
                                                          cl.ElixirSuite__Total_Amount_Paid_By_Insurance__c = 0; 
                                                  }
                                                  cl.ElixirSuite__Original_Ref_No__c = eraRec.ElixirSuite__Payer_ICN__c;
                                                  cl.ElixirSuite__Manual_ERA__c = manualERA;
                                                  if(Status == false && eraRec.ElixirSuite__ERA_Status_Code__c == 'Denied' && cl.ElixirSuite__Claim_Status__c != 'ERA Received'){
                                                  cl.ElixirSuite__Claim_Status__c = 'Denied';     
                                                  }else if(cl.ElixirSuite__Claim_Status__c != 'ERA Received'){
                                                  cl.ElixirSuite__Claim_Status__c = 'ERA Received';  
                                                   Status = true;   
                                                  }
                                                  cl.EDI_Status__c = '835 JSON Received';
                                                  if(cl.ElixirSuite__Claim_Line_Items__r.size()>0)
                                                  {
                                                      for(ElixirSuite__Claim_Line_Items__c cli : cl.ElixirSuite__Claim_Line_Items__r)
                                                      {
                                                          //if(ClaimsLineItemsMap.containsKey(cli.Id))
                                                          //{
                                                              System.debug('cli '+cli);
                                                              String cliKey = key +cli.Name;
                                                              System.debug('cliKey '+cliKey);
                                                              if(eliChargeIdMap.containsKey(cliKey))
                                                              {
                                                              ElixirSuite__ERA_Line_Item__c eli = eliChargeIdMap.get(cliKey);
                                                               System.debug('eli '+eli);
                                                              if(eli != null){
                                                                  eli.ElixirSuite__Claim_Line_Items__c = cli.Id;
                                                                  eli.ElixirSuite__EOB__c = eraRec.Id;
                                                                  
                                                                  eraRec.ElixirSuite__Total_Paid__c += eli.ElixirSuite__Paid__c;
                                                                  eraRec.ElixirSuite__Total_Allowed__c += eli.ElixirSuite__Total_Allowed_Amount__c;
                                                                  totalAdjstAmt +=  eli.ElixirSuite__Charge__c - eli.ElixirSuite__Paid__c;
                                                                  eraRec.ElixirSuite__Total_Adjustment_Amount__c  = totalAdjstAmt;
                                                                  eraRec.ElixirSuite__Total_Patient_Responsibility__c +=eli.ElixirSuite__Patient_Responsibility__c;
                                                                  eraRec.ElixirSuite__Total_OI_Responsibility__c += eli.ElixirSuite__Total_Allowed_Amount__c - (eli.ElixirSuite__Paid__c + eli.ElixirSuite__Patient_Responsibility__c);
                                                                  eraLineItemsToUpdate.add(eli);
                                                                  if(manualERA == false ){ //Reconciliation will happen only when Auto ERA generation is opted
                                                                      //Payment Transaction Reconciliation Logic
                                                                      //system.debug('after ManualERA'+cli.ElixirSuite__Procedure__c);
                                                                    //  if(eraRec.ElixirSuite__ERA_Status_Code__c == 'Process as Primary' || eraRec.ElixirSuite__ERA_Status_Code__c == 'Denied' || eraRec.ElixirSuite__ERA_Status_Code__c == '19: Processed as Primary, Forwarded to Additional Payer(s)'){
                                                                      if((eraRec.ElixirSuite__ERA_Status_Code__c == 'Process as Primary' || eraRec.ElixirSuite__ERA_Status_Code__c == '19: Processed as Primary, Forwarded to Additional Payer(s)') && cl.ElixirSuite__Posted__c == false){ //|| eraRec.ElixirSuite__ERA_Status_Code__c == 'Denied'     
                                                                      if(procedurePaymentTransactionMap.containsKey(cli.ElixirSuite__Procedure__c)){
                                                                              ElixirSuite__Payment_Transaction__c paymentRecord  = procedurePaymentTransactionMap.get(cli.ElixirSuite__Procedure__c);
                                                                              paymentRecord.ElixirSuite__Patient_Responsibility__c = eli.ElixirSuite__Patient_Responsibility__c;
                                                                              paymentRecord.ElixirSuite__Posted__c = true;
                                                                              paymentRecord.ElixirSuite__Total_Remaining_Amount__c = paymentRecord.ElixirSuite__Total_Remaining_Amount__c - eli.ElixirSuite__Paid__c;
                                                                              
                                                                              if(procedurePaymentTransactionMap.get(cli.ElixirSuite__Procedure__c) != null){
                                                                                  if(cl.ElixirSuite__Posted__c){
                                                                                      //system.debug('Cli.pro'+procTranMap.get(cli.ElixirSuite__Procedure__c) );
                                                                                      ElixirSuite__Transactions__c transactionRec = new ElixirSuite__Transactions__c(ElixirSuite__Amount_Paid__c = cli.ElixirSuite__Total_Billed__c - eli.ElixirSuite__Paid__c,                                                                                        
                                                                                                                                                                     ElixirSuite__Payment_DateTime__c = System.now(),
                                                                                                                                                                     ElixirSuite__Payment_Received_By__c='Insurance',
                                                                                                                                                                     ElixirSuite__Master_Transaction__c = procTranMap.get(cli.ElixirSuite__Procedure__c) 
                                                                                                                                                                    );  
                                                                                      toInsertTransaction.add(transactionRec);
                                                                                      if(eraRec.ElixirSuite__Action_to_be_Taken__c != 'Transfer to Patient'){
                                                                                          
                                                                                          ElixirSuite__Transactions__c transactionRec1 = new ElixirSuite__Transactions__c(ElixirSuite__Amount_Paid__c = eli.ElixirSuite__Provider_Adjustment__c,                                                                                        
                                                                                                                                                                          ElixirSuite__Payment_DateTime__c = System.now(),
                                                                                                                                                                          ElixirSuite__Payment_Received_By__c='Insurance',
                                                                                                                                                                          ElixirSuite__Type_of_Payment__c='Adjustment',
                                                                                                                                                                          ElixirSuite__Master_Transaction__c = procTranMap.get(cli.ElixirSuite__Procedure__c) 
                                                                                                                                                                         );
                                                                                          toInsertTransaction.add(transactionRec1);
                                                                                          
                                                                                      }
                                                                                  }else{
                                                                                      ElixirSuite__Transactions__c transactionRec = new ElixirSuite__Transactions__c(ElixirSuite__Amount_Paid__c = eli.ElixirSuite__Paid__c,                                                                                        
                                                                                                                                                                     ElixirSuite__Payment_DateTime__c = System.now(),
                                                                                                                                                                     ElixirSuite__Payment_Received_By__c='Insurance',
                                                                                                                                                                     ElixirSuite__Master_Transaction__c = procTranMap.get(cli.ElixirSuite__Procedure__c) 
                                                                                                                                                                    );  
                                                                                      toInsertTransaction.add(transactionRec);
                                                                                      
                                                                                      if(eraRec.ElixirSuite__Action_to_be_Taken__c != 'Transfer to Patient'){
                                                                                          
                                                                                          ElixirSuite__Transactions__c transactionRec1 = new ElixirSuite__Transactions__c(ElixirSuite__Amount_Paid__c = eli.ElixirSuite__Provider_Adjustment__c,                                                                                        
                                                                                                                                                                          ElixirSuite__Payment_DateTime__c = System.now(),
                                                                                                                                                                          ElixirSuite__Payment_Received_By__c='Insurance',
                                                                                                                                                                          ElixirSuite__Type_of_Payment__c='Adjustment',
                                                                                                                                                                          ElixirSuite__Master_Transaction__c = procTranMap.get(cli.ElixirSuite__Procedure__c) 
                                                                                                                                                                         );
                                                                                          toInsertTransaction.add(transactionRec1);
                                                                                          
                                                                                      }
                                                                                  }
                                                                                  
                                                                              }
                                                                          }
                                                                          
                                                                          //ClaimLineItem Reconcilaation Summary
                                                                          cli.ElixirSuite__Primary_Billed__c= eli.ElixirSuite__Charge__c;
                                                                          cli.ElixirSuite__Primary_Allowed__c= eli.ElixirSuite__total_allowed_amount__c;
                                                                          cli.ElixirSuite__Primary_Paid__c= eli.ElixirSuite__Paid__c;
                                                                          cli.ElixirSuite__Primary_Patient_Responsibility__c= eli.ElixirSuite__Patient_Responsibility__c;
                                                                          cli.ElixirSuite__Primary_Other_Insurance_Responsibility__c=eli.ElixirSuite__Other_Insurance_Responsibility__c;
                                                                          cli.ElixirSuite__Total_Allowed_Amount__c = eli.ElixirSuite__Total_Allowed_Amount__c;
                                                                          cli.ElixirSuite__Total_Adjustment__c = eli.ElixirSuite__Total_Adjustment_Amount__c;
                                                                          cli.ElixirSuite__Total_Billed__c= eli.ElixirSuite__Charge__c;
                                                                          //  cli.ElixirSuite__Primary_Adjustment__c= eli.ElixirSuite__Total_Adjustment_Amount__c;
                                                                          cli.ElixirSuite__Primary_Adjustment__c=   eli.ElixirSuite__Charge__c - eli.ElixirSuite__Paid__c;
                                                                          cli.ElixirSuite__Total_Paid__c= eli.ElixirSuite__Paid__c;
                                                                          //  if(eraRec.ElixirSuite__Action_to_be_Taken__c != 'Adjustment Writeoff'){
                                                                          //    cli.ElixirSuite__Total_Adjustment__c= (eli.ElixirSuite__Charge__c - eli.ElixirSuite__Paid__c) - eli.ElixirSuite__Patient_Responsibility__c;
                                                                          //}
                                                                          cli.ElixirSuite__Total_Adjustment__c= (eli.ElixirSuite__Charge__c - eli.ElixirSuite__Paid__c) - eli.ElixirSuite__Patient_Responsibility__c;
                                                                          cli.ElixirSuite__Total_Patient_Responsibility__c=eli.ElixirSuite__Patient_Responsibility__c;
                                                                           updateClineItemList.put(cli.Id,cli);
                                                                      }
                                                                  }
                                                              }
                                                             
                                                          
                                                          //}
                                                      }
                                                          if(claimFieldMap.containsKey(amountStatus.toLowerCase())){
                                                              if((!ClaimVSPaidAmt.isEmpty() || ClaimVSPaidAmt.size() > 0) && ClaimVSPaidAmt.containsKey(cl.Id)){
                                                                  Decimal d = ClaimVSPaidAmt.get(cl.Id);
                                                                  d = d+eraRec.ElixirSuite__Total_Paid__c;
                                                                  ClaimVSPaidAmt.put(cl.Id,d); 
                                                                  
                                                              }else if((!ClaimVSPaidAmt.isEmpty() || ClaimVSPaidAmt.size() > 0) && !ClaimVSPaidAmt.containsKey(cl.Id)){
                                                                  ClaimVSPaidAmt.put(cl.Id,eraRec.ElixirSuite__Total_Paid__c);    
                                                              }else{
                                                                  ClaimVSPaidAmt.put(cl.Id,eraRec.ElixirSuite__Total_Paid__c); 
                                                              }
                                                              if(cl.ElixirSuite__Total_Charge__c <= ClaimVSPaidAmt.get(cl.Id)){
                                                                  cl.put('Amount_Status__c','Paid');
                                                              }else if(ClaimVSPaidAmt.get(cl.Id) <= 0) {
                                                                  cl.put('Amount_Status__c','Not Paid');     
                                                              }else if(ClaimVSPaidAmt.get(cl.Id) < cl.ElixirSuite__Total_Charge__c && ClaimVSPaidAmt.get(cl.Id) > 0){
                                                                  cl.put('Amount_Status__c','Partially Paid');   
                                                              }
                                                              }
                                                          cl.ElixirSuite__Total_Amount_Paid_By_Insurance__c = eraRec.ElixirSuite__Total_Paid__c;
                                                      }
                                                  }
                                                  
                                                  //system.debug('eraNameList '+eraNameList);
                                                 /*for(ElixirSuite__EOB__c era: [Select Id,Name,ElixirSuite__Pcn__c,ElixirSuite__EOB__r.Name,ElixirSuite__EOB__r.ElixirSuite__Payment_Method__c,ElixirSuite__Claim__r.Name From ElixirSuite__EOB__c where Id IN :eraNameList
                                                                                WITH SECURITY_ENFORCED
                                                                                ORDER BY CreatedDate ASC LIMIT 50000]){
                                                                                    //system.debug('era '+era);
                                                                                    updatedPcnERAMap.put(era.ElixirSuite__Claim__r.Name,era);
                                                                                }*/
                                                  //system.debug('updatedPcnERAMap '+updatedPcnERAMap);
                                                  if(manualERA == false ){ //Reconciliation will happen only when Auto ERA generation is opted
                                                    //  if(eraRec.ElixirSuite__ERA_Status_Code__c == 'Process as Primary' || eraRec.ElixirSuite__ERA_Status_Code__c == 'Denied' || eraRec.ElixirSuite__ERA_Status_Code__c == '19: Processed as Primary, Forwarded to Additional Payer(s)'){
                                                      	
                                                      if((eraRec.ElixirSuite__ERA_Status_Code__c == 'Process as Primary' || eraRec.ElixirSuite__ERA_Status_Code__c == '19: Processed as Primary, Forwarded to Additional Payer(s)') && cl.ElixirSuite__Posted__c == false){ //|| eraRec.ElixirSuite__ERA_Status_Code__c == 'Denied'     
                                                      if(eraRec.ElixirSuite__Net_Paid_Amt__c!=null && eraRec.ElixirSuite__Total_Paid__c!=null)
                                                          {
                                                              Decimal intrstOrLateFilingCharges = eraRec.ElixirSuite__Net_Paid_Amt__c - eraRec.ElixirSuite__Total_Paid__c;
                                                              //system.debug('intrstOrLateFilingCharges '+intrstOrLateFilingCharges);
                                                              if(intrstOrLateFilingCharges != 0 ){
                                                                  ElixirSuite__Master_Transaction__c otherTransaction = new ElixirSuite__Master_Transaction__c(
                                                                      ElixirSuite__Account__c = eraRec.ElixirSuite__Account__c,
                                                                      ElixirSuite__Allocated_Amount__c = 0,
                                                                      ElixirSuite__Reason_Of_Payment__c  = 'Interest/Late Filing Charges', 
                                                                      //  ElixirSuite__Payment_Notes__c = (updatedPcnERAMap.get(cl.Name)).ElixirSuite__EOB__r.Name + (updatedPcnERAMap.get(cl.Name)).Name  + cl.Name,   
                                                                      //  ElixirSuite__Mode_of_Payment__c = (updatedPcnERAMap.get(cl.Name)).ElixirSuite__EOB__r.ElixirSuite__Payment_Method__c,
                                                                      ElixirSuite__Payment_Received_By__c = 'Insurance',
                                                                      ElixirSuite__Transaction_Date__c = System.today(),
                                                                      ElixirSuite__Total_Amount_Paid__c = intrstOrLateFilingCharges,                                              
                                                                      ElixirSuite__Interest_Late_Filling_Charges__c = intrstOrLateFilingCharges
                                                                  ); 
                                                                  otherTrasnactionLstForChildERA.add(otherTransaction);
                                                              }
                                                          }
                                                          ElixirSuite__Master_Transaction__c otherTransaction_Static = new ElixirSuite__Master_Transaction__c(
                                                              ElixirSuite__Account__c = eraRec.ElixirSuite__Account__c,
                                                              ElixirSuite__Allocated_Amount__c = eraRec.ElixirSuite__Total_Paid__c,
                                                              ElixirSuite__Reason_Of_Payment__c  = 'ERA/EOB Payment',          
                                                              // ElixirSuite__Payment_Notes__c = (updatedPcnERAMap.get(cl.Name)).ElixirSuite__EOB__r.Name + (updatedPcnERAMap.get(cl.Name)).Name  + cl.Name, 
                                                              //  ElixirSuite__Mode_of_Payment__c = (updatedPcnERAMap.get(cl.Name)).ElixirSuite__EOB__r.ElixirSuite__Payment_Method__c,
                                                              ElixirSuite__Payment_Received_By__c = 'Insurance',
                                                              ElixirSuite__Transaction_Date__c = System.today(),
                                                              ElixirSuite__Total_Amount_Paid__c = eraRec.ElixirSuite__Total_Paid__c,
                                                              ElixirSuite__Refrence_Key__c = eraRec.Id
                                                          ); 
                                                          otherTrasnactionLstForChildERA.add(otherTransaction_Static);
                                                          
                                                          //Claim Reconcillation Summary
                                                          cl.ElixirSuite__Primary_Billed__c= eraRec.ElixirSuite__Total_Charge__c;
                                                          cl.ElixirSuite__Primary_Allowed__c= eraRec.ElixirSuite__Total_Allowed__c;
                                                          cl.ElixirSuite__Primary_Paid__c= eraRec.ElixirSuite__Total_Paid__c;
                                                          if(cl.ElixirSuite__Posted__c){
                                                              ElixirSuite__Master_Transaction__c diffAmtsObj = new ElixirSuite__Master_Transaction__c(
                                                                  ElixirSuite__Account__c =  eraRec.ElixirSuite__Account__c,
                                                                  ElixirSuite__Reason_Of_Payment__c  = 'ERA/EOB Payment',          
                                                                  //  ElixirSuite__Mode_of_Payment__c = (updatedPcnERAMap.get(cl.Name)).ElixirSuite__EOB__r.ElixirSuite__Payment_Method__c,
                                                                  ElixirSuite__Payment_Received_By__c = 'Insurance',
                                                                  ElixirSuite__Transaction_Date__c = System.today(),
                                                                  ElixirSuite__Total_Amount_Paid__c = cl.ElixirSuite__Primary_Paid__c - eraRec.ElixirSuite__Net_Paid_Amt__c
                                                              );
                                                              
                                                              otherTrasnactionLstForChildERA.add(diffAmtsObj);
                                                          }
                                                          cl.ElixirSuite__Primary_Patient_Responsibility__c= eraRec.ElixirSuite__Total_Patient_Responsibility__c;
                                                          cl.ElixirSuite__Interest_Late_filing_charges__c= eraRec.ElixirSuite__Net_Paid_Amt__c - eraRec.ElixirSuite__Total_Paid__c;
                                                          cl.ElixirSuite__Primary_Adjustment__c= eraRec.ElixirSuite__Total_Adjustment_Amount__c;
                                                          cl.ElixirSuite__Total_Billed__c= eraRec.ElixirSuite__Total_Charge__c;
                                                          cl.ElixirSuite__Total_Paid__c = eraRec.ElixirSuite__Net_Paid_Amt__c;
                                                          cl.ElixirSuite__Posted__c = true;
                                                          //   if(eraRec.ElixirSuite__Action_to_be_Taken__c != 'Adjustment Writeoff'){
                                                          //    cl.ElixirSuite__Total_Adjustment__c= (eraRec.ElixirSuite__Total_Charge__c-eraRec.ElixirSuite__Net_Paid_Amt__c) - eraRec.ElixirSuite__Total_Patient_Responsibility__c;
                                                          //}
                                                          cl.ElixirSuite__Total_Adjustment__c= (eraRec.ElixirSuite__Total_Charge__c-eraRec.ElixirSuite__Net_Paid_Amt__c) - eraRec.ElixirSuite__Total_Patient_Responsibility__c;
                                                          cl.ElixirSuite__Total_Patient_Responsibility_Primary__c = eraRec.ElixirSuite__Total_Patient_Responsibility__c;
                                                          cl.ElixirSuite__Primary_Other_Insurance_Responsibility__c= eraRec.ElixirSuite__Total_OI_Responsibility__c;
                                                          eraRec.ElixirSuite__Primary_Posted__c = true;
                                                      }
                                                  }
                                                  
                                                  
                                                  erasToUpdate.add(eraRec);
                                                  System.debug('erasToUpdate '+erasToUpdate);
                                                  // claimLineItemsToUpdate.add(cli);
                                                 
                                              
                                          
                                              }
                                              }
                                               updatedClaimpList.put(cl.Id,cl);
                                              }
    }
        //system.debug('eraLineItemsToInsert '+eraLineItemsToInsert);         
        //system.debug('eraListToInsert '+eraListToInsert);
        //system.debug('claimLineItemsToUpdate '+claimLineItemsToUpdate);
        //system.debug('claimsToUpdate '+claimsToUpdate);
         System.debug('erasToUpdate '+erasToUpdate);
        if(erasToUpdate != null && erasToUpdate.size()>0){
            update erasToUpdate;
        }
        if(eraLineItemsToUpdate != null && eraLineItemsToUpdate.size()>0){
            update eraLineItemsToUpdate;
        }
        if(updatedClaimpList != null && updatedClaimpList.size()>0){
            update updatedClaimpList.values();
        }
        if(updateClineItemList != null && updateClineItemList.size()>0){
            update updateClineItemList.values();
        }
        if(toInsertTransaction != null && toInsertTransaction.size() >0){
            insert toInsertTransaction ;
        }
        if(otherTrasnactionLstForChildERA != null && otherTrasnactionLstForChildERA.size() >0){
            insert otherTrasnactionLstForChildERA;
        }
        
        if(manualERA == false){
            if(procedurePaymentTransactionMap != null && procedurePaymentTransactionMap.size() >0 ) {
                Database.update(procedurePaymentTransactionMap.values(),false);
            }
        }  
    }

}