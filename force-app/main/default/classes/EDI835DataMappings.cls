public class EDI835DataMappings {
   public static String getISACode(String isaValue) {
        switch on isaValue {
            when 'ZZ' {return 'Mutually Defined'; }
            when '01' { return 'DUNS (Dun & Bradstreet) Number'; }
            when '02' { return 'SCAC (Standard Carrier Alpha Code)'; }
            when '08' { return 'UCC EDI Communications ID'; }
            when '12' { return 'Phone Number'; }
            when '14' { return 'DUNS+4'; }
            when '20' { return 'Health Industry Number (HIN)'; }
            when '27' { return 'Carrier-assigned number'; }
            when '28' { return 'Fiscal Intermediary Identification'; }
            when '29' { return 'Medicare Provider and Supplier Identification'; }
            when '30' { return 'US Federal Tax Identification Number'; }
            when '31' { return 'National Association of Insurance Commissioners Company Code (NAIC)'; }
            when else { return 'Unknown Identifier'; }
        }
    }
    public static String getGSSegmentCodes(String codeText) {
        switch on codeText {
            when 'BE' { return 'Benefit Enrollment'; }
            when 'FA' { return 'Food and Drug Administration (FDA) Regulatory Transaction'; }
            when 'GH' { return 'Application Advice'; }
            when 'HB' { return 'Eligibility, Coverage, or Benefit Information'; }
            when 'HP' { return 'Health Care Claim Payment Advice'; }
            when 'HR' { return 'Health Care Claim Status Request'; }
            when 'HS' { return 'Health Care Claim Status Notification'; }
            when 'RA' { return 'Remittance Advice'; }
            when 'SH' { return 'Health Care Services Review Information'; }
            when 'TH' { return 'Health Care Claim'; }
            when else { return 'Unknown Transaction Code'; }
        }
    }
    public static String getNM1ContactCode(String value) {
        switch on value {
            when 'PR' { return 'Payor'; }
            when 'PE' { return 'Payee'; }
            when else { return ''; }
        }
    }
    public static String getPaymentMethod(String paymentMethodCode) {
        switch on paymentMethodCode {
            when 'C' { return 'Check'; }
            when 'D' { return 'Electronic Funds Transfer (EFT)'; }
            when 'H' { return 'Automated Clearing House (ACH) CCD+'; }
            when 'I' { return 'Credit Card'; }
            when 'R' { return 'Reserved for Future Use'; }
            when 'W' { return 'Wire Transfer'; }
            when else { return ''; }
        }
    }
    public static String getFacilityTypeCode(String facilityTypeCode) {
        switch on facilityTypeCode {
            when '11' { return 'Hospital'; }
            when '22' { return 'Clinic'; }
            when '33' { return 'Nursing Home'; }
            when '44' { return 'Home Health'; }
            when '55' { return 'Hospice'; }
            when '66' { return 'Ambulance'; }
            when '77' { return 'Other'; }
            when else { return ''; }
        }
    }
    public static String getPaymentFormat(String paymentFormatCode) {
        switch on paymentFormatCode {
            when 'ACH' { return 'Automated Clearing House'; }
            when 'CCP' { return 'Cash Concentration and Disbursement or Corporate Trade Exchange'; }
            when 'CTX' { return 'Corporate Trade Exchange'; }
            when 'CCD' { return 'Corporate Credit or Debit'; }
            when 'POP' { return 'Point-of-Purchase entry'; }
            when 'PPD' { return 'Prearranged Payment and Deposit Entry'; }
            when 'WEB' { return 'Internet-initiated payment'; }
            when else { return ''; }
        }
    }
    public static String getClaimFrequencyCode(String claimFrequencyCode) {
        switch on claimFrequencyCode {
            when '1' { return 'Original Claim'; }
            when '7' { return 'Replacement of Prior Claim'; }
            when '8' { return 'Void/Cancel of Prior Claim'; }
            when '9' { return 'Final Adjustment (Adjudication)'; }
            when 'A' { return 'Adjustment of Prior Claim'; }
            when 'B' { return 'Rebilled Original Claim'; }
            when 'C' { return 'Corrected Claim'; }
            when 'D' { return 'Referral'; }
            when 'E' { return 'Claim Reopened'; }
            when 'F' { return 'Void/Cancel of Claim Reopened'; }
            when else { return ''; }
        }
    }
    public static String getAccNumberQualifier(String accountNumberQualifier) {
        switch on accountNumberQualifier {
            when 'DA' { return 'Demand Deposit Account'; }
            when 'SG' { return 'Savings Account'; }
            when 'SA' { return 'Savings Account'; }
            when 'MS' { return 'Money Market Savings Account'; }
            when 'CA' { return 'Checking Account'; }
            when 'SAJ' { return 'Savings Account for Joint'; }
            when 'DAC' { return 'Demand Deposit Account for Collection'; }
            when 'SAC' { return 'Savings Account for Collection'; }
            when else { return ''; }
            
        }
    }
    public static String getTRNCode(String traceTypeCode) {
        switch on traceTypeCode {
            when '1' { return 'Current Transaction Trace'; }
            when '2' { return 'Correction or Replacement of Prior Transaction Trace'; }
            when '3' { return 'Referral Trace'; }
            when '4' { return 'Void of Prior Payment Trace'; }
            when '5' { return 'Reversal of Prior Payment or Refund Trace'; }
            when '6' { return 'Administrative Request Trace'; }
            when '7' { return 'Reversal of Administrative Request Trace'; }
            when else { return ''; }
        }
    }
    public static String getDTMDateType(String dateTimeQualifier) {
        switch on dateTimeQualifier {
            when '036' { return 'Expiration date'; }
            when '050' { return 'Received date'; }
            when '059' { return 'Processed date'; }
            when '100' { return 'Statement from date'; }
            when '101' { return 'Statement to date'; }
            when '102' { return 'Service date'; }
            when '125' { return 'Submission date'; }
            when '173' { return 'Claim received date'; }
            when '232' { return 'Date of service'; }
            when '233' { return 'Date of last service'; }
            when '277' { return 'Service start date'; }
            when '278' { return 'Service end date'; }
            when '337' { return 'Time'; }
            when '373' { return 'Date'; }
            when '472' { return 'Date of claim submission'; }
            when '623' { return 'Time code'; }
            when 'ZZZ' { return 'Mutually defined'; }
            when '011' { return 'Shipment Requested'; }
            when '063' { return 'Requested Ship Date'; }
            when '090' { return 'Effective Date'; }
            when '194' { return 'Expiration Date'; }
            when '370' { return 'Last Maintenance Date'; }
            when '405' { return 'Date Shipped'; }
            when '067' { return 'Document/Reference Date'; }
            when '038' { return 'Estimated Delivery Date'; }
            when '037' { return 'Cancel Date'; }
            when '051' { return 'Delivery Requested'; }
            when '166' { return 'Date of Birth'; }
            when '169' { return 'Production Run'; }
            when else { return ''; }
        }
    }
    public static String getREFInfo(String referenceCode) {
        switch on referenceCode {
            when 'EV' { return 'Event Identification'; }
            when 'CE' { return 'Claim Adjustment'; } // ask Aniruddha
            when '2U' { return 'Medicaid Provider Number'; }
            when '1C' { return 'Primary Care Provider (PCP) Identification'; }
            when 'G2' { return 'Provider Commercial Number'; }
            when 'IG' { return 'Patient Control Number'; }
            when 'N7' { return 'Payor Claim Control Number'; }
            when 'LU' { return 'Secondary Payor Provider Number'; }
            when 'XV' { return 'Receiver Identification Number'; }
            when 'FY' { return 'State Control Number'; }
            when 'EA' { return 'Electronic Attachment Control Number'; }
            when 'SY' { return 'Social Security Number'; }
            when 'DP' { return 'Department Number'; }
            when 'IA' { return 'Internal Vendor Number'; }
            when 'ON' { return 'Order Number'; }
            when 'CR' { return 'Contract Number'; }
            when 'ZZ' { return 'Mutually Defined'; }
            when 'TN' { return 'Transaction Reference Number'; }
            when 'DI' { return 'Distributor Invoice Number'; }
            when 'CN' { return 'Customer Reference Number'; }
            when 'TJ' { return 'Federal Tax Payee ID number'; }
            when 'PQ' { return 'Payer Identification'; }
            when 'HPI' { return 'Healthcare Provider Information'; }
            when 'HCP' { return 'Healthcare Claim Payment Information'; }
            when else {return '';}
        }    
    }
    public static String getPERInfo(String contactFunctionCode) {
        switch on contactFunctionCode {
            when 'EM' { return 'Electronic Mail'; }
            when 'EX' { return 'Extension'; }
            when 'FX' { return 'Fax'; }
            when 'HP' { return 'Home Phone'; }
            when 'TE' { return 'Telephone'; }
            when 'MD' { return 'Mobile Phone'; }
            when 'XO' { return 'Telex'; }
            when 'TQ' { return 'Telephone Extension'; }
            when 'FQ' { return 'Fax Extension'; }
            when 'CP' { return 'Cellular Phone'; }
            when 'MT' { return 'Modem'; }
            when 'CX' { return 'Provider Relations'; }
            when 'BL' { return 'Billing Office'; }
            when 'IC' { return 'Information Contact'; }
            when 'RP' { return 'Payor Relations'; }
            when 'TP' { return 'Technical Contact'; }
            when 'UR' { return 'Utilization Review'; }
            when else { return ''; }
        }
    }
    public static String getClaimStatusDescription(String value) {
        switch on value {
            when '1' { return 'Paid'; }
            when '2' { return 'Denied'; }
            when '3' { return 'Pending'; }
            when '4' { return 'Pending Partial Payment'; }
            when '19' { return 'Claim Adjusted'; }
            when '20' { return 'Zero Payment'; }
            when '21' { return 'Predetermination Pricing Only'; }
            when '22' { return 'Not Found'; }
            when '23' { return 'Processed as Primary'; }
            when '24' { return 'Processed as Secondary'; }
            when '25' { return 'Benefits of Another Policy'; }
            when '26' { return 'No Coverage'; }
            when '27' { return 'Reduced Benefits'; }
            when '28' { return 'Forwarded to Additional Payer'; }
            when '29' { return 'Forwarded to Primary Payer'; }
            when '31' { return 'Claim Paid in Full'; }
            when '32' { return 'Claim Denied'; }
            when '33' { return 'Claim Denied - Info is Required for Adjudication'; }
            when '34' { return 'Claim Pending'; }
            when '35' { return 'Claim Pending - Info is Required for Adjudication'; }
            when else { return ''; }
        }
    }
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
    public static String getNM108Code(String identificationCodeQualifier) {
        switch on identificationCodeQualifier {
            when '34' { return 'Social Security Number'; }
            when 'MI' { return 'Member Identification Number'; }
            when 'II' { return 'Employer\'s Identification Number (EIN)'; }
            when 'XX' { return 'Health Maintenance Organization (HMO) Policy Number'; }
            when 'MR' { return 'Medical Record Number'; }
            when 'FI' { return 'Federal Taxpayer\'s Identification Number'; }
            when 'PN' { return 'Pension Claim Number'; }
            when 'SY' { return 'Social Security Number'; }
            when '1W' { return 'Individual Relationship Identifier (IRI)'; }
            when 'ZH' { return 'Unique Physician Identification Number (UPIN)'; }
            when 'PQ' { return 'Payer Identification'; }
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
    public static String getpatientClaimIndicatorText(String value) {
        switch on value {
            when '11' { return 'Other Non-Federal Programs'; }
            when '12' { return 'Preferred Provider Organization (PPO)'; }
            when '13' { return 'Point of Service (POS)'; }
            when '14' { return 'Exclusive Provider Organization (EPO)'; }
            when '15' { return 'Indemnity Insurance'; }
            when '16' { return 'Health Maintenance Organization (HMO)'; }
            when '17' { return 'Dental Maintenance Organization (DMO)'; }
            when 'AM' { return 'Automobile Medical'; }
            when 'BL' { return 'Blue Cross/Blue Shield'; }
            when 'CH' { return 'Champus'; }
            when 'CI' { return 'Commercial Insurance Company'; }
            when 'DS' { return 'Disability'; }
            when 'FI' { return 'Federal Employees Program (FEP)'; }
            when 'HM' { return 'Health Maintenance Organization Medicare Risk'; }
            when 'LM' { return 'Liability Medical'; }
            when 'MA' { return 'Medicare Part A'; }
            when 'MB' { return 'Medicare Part B'; }
            when 'MC' { return 'Medicaid'; }
            when 'OF' { return 'Other Federal Program'; }
            when 'TV' { return 'Title V'; }
            when 'VA' { return 'Veterans Affairs Plan'; }
            when else { return ''; }
        }
    }
    public static String getHealthCareRemarkCodes(String value) {
        switch on value{
            when 'HE' { return 'Healthcare'; }
            when 'RX' { return 'Prescription'; }
            when else { return ''; }
        }
    }    
}