public class EDIDataMappings{
    // ISA Segment
    public static final String AuthInfoQualifier_1 = '00';
    public static final String SecurityInfoQualifier_3 = '00';
    public static final String SecurityInfo_4 = '';
    public static final String SenderIDQualifier_5 = 'ZZ';
    public static final String ReceiverIDQualifier_7 = 'ZZ';
    public static final String InterchangeSenderID = '75225' + ' '.repeat(10);
    public static final String InterchangeReceiverID_8 = '100000'  + ' '.repeat(9);
    public static final String InterchangeControlStandId_11 = '>';
    public static final String InterchangeControlVersionNumber_12 = '00501';
    public static final String InterchangeControlNumber_13 = '000000001';
    public static final String AcknowledgementRequested_14 = '1';
    public static final String UsageIndicator_15Producttion = 'P';
    //public static final String UsageIndicator_15Test = 'T';
    public static final String ComponentElementSeparator_16 = ':';
    //GS Segment
    public static final String GroupControlNumber_6 = '1';
    public static final String transactionTypeCode_7 = 'X';
    public static final String VersionAndRelease_8 = '005010X222A1';
    public static final String applicationCode = '75225';
    public static final String applicationReceiverCode = '77033';
    //ST Segment
    //healthCareClaim transactionSetIdentifierCode
    public static final String transactionSetIdentifierCode_01 = '837';
    public static final String Transactionsetcontrol_02 = '0001';
    public static final String Implementation_Convention_Reference03 = '005010X222A1';
    //NM1 Segment
    public static final String EntityIdentifierCode = '44';
    public static final String EntityTypeQualifier = '2';
    //BHT Segment
    public static final String hierarchicalStructureCode = '0019';
    public static final String transactionSetPurposeCode ='00';
    public static final String originatorApplicationTransactionID = '1';
    public static final String claimID = 'CH';
    //HL Segment
    public static final String hierarchicalIDNumber = '1'; 
    public static final String hierarchicalLevelCode =  '20';
    public static final String hierarchicalChildCode = '1';
    //PRV Segment
    public static final String providerCode = 'BI';
    public static final String referenceIdentificationQualifier = 'PXC';
    //REF
    public static final String referenceIdQualifierREF = 'EI';
    //PER
    public static final String contactFunctionCode_01 = 'IC';
    public static final String ResponseContactName_02 = 'Melvin Barry';
    public static final String CommunicationNumberQualifier_03 = 'TE';
    public static final String ResponseContactCommunicationNumber_04 = '2026732286';
    //SBRHL Segment
    public static final String HierarchicalParentIDNumber_02 = '1';
    public static final String HierarchicalLevelCode_03 = '22';
    public static final String HierarchicalChildCode_04 = '0';
    //SBR Segment
    public static String PayerResponsibilitySequenceNumberCode_01 = 'P';
    public static String IndividualRelationshipCode_02 = '18';
    public static String ClaimFilingIndicatorCode_09 = 'ZZ';
    //CLM Segment
    public static final String FacilityCodeQualifier = 'B';
    public static final String ClaimFrequencyTypeCode = '1';
    public static final String ProviderorSupplierSignatureIndicator = 'Y';
    public static final String AssignmentorPlanParticipationCode = 'A';
    public static final String BenefitsAssignmentCertificationIndicator = 'Y';
    public static final String ReleaseofInformationCode = 'Y';
    //HI Segment
    public static final String CodeListQualifierCode = 'ABK';
    //SV1 Segment
    public static final String ProductorServiceIDQualifier_01 = 'HC';
    public static final String UnitorBasisforMeasurementCode_03 = 'UN';
    
    public static final String numberofTransactionSetsIncluded = '1';
    public static final String groupControlNumber = '1';
    //DTP Segment
    public static final String DateTimeQualifier_01 = '472'; 
    public static final String DateTimePeriodFormatQualifier_02 = 'D8';
    //IEA Segment
    public static final String numberofIncludedFunctionalGroups = '1';
    public static final String interchangeControlNumber = '000000001';
    //DMG Segment
    public static final String dateTimePeriodFormatQualifier = 'D8';
    
    public static String getAdjustmentReason(String strAdjustGroupCode){
        switch on strAdjustGroupCode  {
            when 'CO16'{ return 'Contractual Obligations - Claim/service lacks information or has submission/billing error(s).'; }
            when 'CO8'{ return 'Contractual Obligations - The procedure code is inconsistent with the provider type/specialty (taxonomy)'; }
            when 'CO18'{ return 'Contractual Obligations - Exact duplicate claim/service'; }
            when 'CO258' { return 'Contractual Obligations - Claim/service not covered when patient is in custody/incarcerated. Applicable federal, state or local authority may cover the claim/service.'; }
            when 'CO267' { return 'Contractual Obligations - Claim/service spans multiple months. '; } 
            when 'CO253'{ return 'Contractual Obligations - Sequestration - reduction in federal payment.'; }
            when 'CO45'{ return 'Contractual Obligations - Charge exceeds fee schedule/maximum allowable or contracted/legislated fee arrangement.'; }
            when 'COA8'{ return 'Contractual Obligations - Ungroupable DRG(Patients with an invalid or non-existent ICD-10-CM code).';}
            when 'PR2'{ return 'Patient Responsibility - Coinsurance Amount.'; }
            when else { return ''; }
        }
    }
    public static String getFormatText(String strFormatIndentifier){
        switch on strFormatIndentifier  {
            when 'N782' { return 'The beneficiary deductible and coinsurance amounts have been combined'; }
            when 'N479' { return 'Claim Payment Adjustment Remark'; }
            when 'N480' { return 'Explanation of Benefits Remark - Coordination of Benefits'; }
            when 'N481' { return 'Remittance Advice Remark - Provider Payment'; }
            when 'N482' { return 'Explanation of Benefits Remark - Provider Adjustment'; }
            when 'N483' { return 'Remittance Advice Remark - Provider Withholding'; }
            when 'N484' { return 'Explanation of Benefits Remark - Patient Responsibility'; }
            when 'N485' { return 'Remittance Advice Remark - Patient Payment'; }
            when 'N486' { return 'Explanation of Benefits Remark - Other'; }
            when 'N487' { return 'Remittance Advice Remark - Other'; }
            when 'N488' { return 'Explanation of Benefits Remark - Coordination of Benefits - Medicare Secondary Payer'; }
            when 'N489' { return 'Remittance Advice Remark - Coordination of Benefits - Medicare Secondary Payer'; }
            when 'N490' { return 'Explanation of Benefits Remark - No Payment Due - Coordination of Benefits'; }
            when 'N491' { return 'Remittance Advice Remark - No Payment Due - Coordination of Benefits'; }
            when 'N492' { return 'Explanation of Benefits Remark - Claim Denied'; }
            when 'N493' { return 'Remittance Advice Remark - Claim Denied'; }
            when 'N494' { return 'Explanation of Benefits Remark - Claim Referred to Other Payer'; }
            when 'N495' { return 'Remittance Advice Remark - Claim Referred to Other Payer'; }
            when 'N496' { return 'Explanation of Benefits Remark - Claim Held for Further Information'; }
            when 'N497' { return 'Remittance Advice Remark - Claim Held for Further Information'; }
            when 'N498' { return 'Explanation of Benefits Remark - Claim Pending'; }
            when 'N499' { return 'Remittance Advice Remark - Claim Pending'; }
            when 'ZZ' { return 'Mutually Defined'; }
            when else { return ''; }
        }
    }
    public static String getAmountText(String amountQualifierCode){
        switch on amountQualifierCode  {
            when '23' { return 'Allowed amount'; }
            when '24' { return 'Amount due'; }
            when '32' { return 'Amount paid'; }
            when '42' { return 'Contractual adjustment amount'; }
            when '43' { return 'Coordination of benefits adjustment amount'; }
            when '44' { return 'Deductible amount'; }
            when '45' { return 'Discount amount'; }
            when '46' { return 'Eligibility adjustment amount'; }
            when '47' { return 'Experimental/investigational adjustment amount'; }
            when '48' { return 'Fraud or abuse adjustment amount'; }
            when '49' { return 'Medical necessity adjustment amount'; }
            when '50' { return 'Patient responsibility amount'; }
            when '51' { return 'Precertification/authorization adjustment amount'; }
            when '52' { return 'Provider contract adjustment amount'; }
            when '53' { return 'Reasonable and customary adjustment amount'; }
            when '54' { return 'Timely filing adjustment amount'; }
            when '55' { return 'Other adjustment amount'; }
            when 'AU' { return 'Coverage Amount'; }
            when 'B6' { return 'Allowed - Actual'; }
            when 'C8' { return 'Taxable Amount'; }
            when 'D2' { return 'Withholding Amount'; }
            when 'D4' { return 'Discount Taken'; }
            when 'DK' { return 'Amount Disputed'; }
            when 'E1' { return 'Estimated Amount Due'; }
            when 'FQ' { return 'Finance Charge'; }
            when 'G6' { return 'Amount Billed'; }
            when 'H6' { return 'Unit Price'; }
            when 'H8' { return 'Quantity'; }
            when 'J7' { return 'Amount Received'; }
            when 'M7' { return 'Amount Charged'; }
            when 'P2' { return 'Payment Amount Due'; }
            when 'R4' { return 'Amount Owing'; }
            when 'T5' { return 'Amount Credited'; }
            when 'TE' { return 'Amount to be Expensed'; }
            when 'ZZZ' { return 'Mutually Defined'; }
            when else { return ''; }
        }
    }
}