public class EDIDataMappings{
    // ISA Segment
    public static final String AuthInfoQualifier_1 = '00';
    public static final String SecurityInfoQualifier_3 = '00';
    public static final String SecurityInfo_4 = '';
    public static final String SenderIDQualifier_5 = 'ZZ';
    public static final String ReceiverIDQualifier_7 = 'ZZ';
    public static final String InterchangeSenderID = '75225' + ' '.repeat(10);
    public static final String InterchangeReceiverID_8 = '100000         ';
    public static final String InterchangeControlStandId_11 = '>';
    public static final String InterchangeControlVersionNumber_12 = '00501';
    public static final String InterchangeControlNumber_13 = '000000001';
    public static final String AcknowledgementRequested_14 = '1';
    public static final String UsageIndicator_15 = 'P';
    public static final String ComponentElementSeparator_16 = ':';
    //GS Segment
    public static final String GroupControlNumber_6 = '1';
    public static final String transactionTypeCode_7 = 'X';
    public static final String VersionAndRelease_8 = '005010X222A1';
    public static final String applicationCode = '75225';
    public static final String applicationReceiverCode = '77033';
    //ST Segment
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
    public static final String contactFunctionCode = 'IC';
    public static final String submitterContactName = 'Melvin Barry';
    public static final String communicationNumberQualifier = '2026732286';
    //CLM Segment
    public static final String FacilityTypeCode = '11';
    public static final String FacilityCodeQualifier = 'B';
    public static final String ClaimFrequencyTypeCode = '1';
    public static final String ProviderorSupplierSignatureIndicator = 'Y';
    public static final String AssignmentorPlanParticipationCode = 'A';
    public static final String BenefitsAssignmentCertificationIndicator = 'Y';
    public static final String ReleaseofInformationCode = 'Y';

    
}