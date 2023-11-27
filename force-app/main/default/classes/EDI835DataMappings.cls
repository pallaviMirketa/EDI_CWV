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
            when else { return ''; }
        }
    }
    public static String getISAUsageIndicatorText(String usageIndctr) {
        switch on usageIndctr {
            when 'P' {return 'Production'; }
            when 'T' { return 'Testing'; }
            when 'U' { return 'Informational or Educational'; }
            when else { return ''; }
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
            when else { return ''; }
        }
    }
    public static String getNM1SegmentCodes(String value) {
        switch on value {
            when '1' { return 'Person'; }
            when '2' { return 'Non-Person Entity'; }
            when '34' { return 'Social Security Number'; }
            when 'MI' { return 'Member Identification Number'; }
            when 'II' { return 'Employers Identification Number (EIN)'; }
            when 'XX' { return 'Health Maintenance Organization (HMO) Policy Number'; }
            when 'MR' { return 'Medical Record Number'; }
            when 'FI' { return 'Federal Taxpayers Identification Number'; }
            when 'PN' { return 'Pension Claim Number'; }
            when 'SY' { return 'Social Security Number'; }
            when '1W' { return 'Individual Relationship Identifier (IRI)'; }
            when 'ZH' { return 'Unique Physician Identification Number (UPIN)'; }
            when 'PQ' { return 'Payer Identification'; }
            when 'QC' { return 'Patient'; }
            when '82' { return 'Other Non Person Entity'; }
            when '74' { return 'Corrected Patient or Insured'; }
            when 'PR' { return 'Payor'; }
            when 'PE' { return 'Payee'; }
            when '1P' { return 'Person'; }
            when '2P' { return 'Partnership'; }
            when '3P' { return 'Corporation'; }
            when '4P' { return 'Non-Person Entity'; }
            when '6P' { return 'Government Agency'; }
            when '71' { return 'Party'; }
            when '72' { return 'Service Provider'; }
            when '41' { return 'Name of the referring physician'; }
            when 'FA' { return 'Facility'; }
            when 'IL' { return 'Insured or Subscriber'; }
            when 'TQ' { return 'Treatment Authorization Code'; }
            when else { return ''; }
        }
    }
    public static String getPaymentMethod(String paymentMethodCode) {
        switch on paymentMethodCode {
            when 'C' { return 'adjustment or a credit'; }
            when 'D' { return 'debit transaction'; }
            when 'H' { return 'Automated Clearing House (ACH) CCD+'; }
            when 'I' { return 'Electronic funds transfer or similar transaction'; }
            when 'P' {return 'payment is being made to the payee' ;}
            when else { return ''; }
        }
    }
    public static String getTS3FacilityTypeCode(String code){
        switch on code{
            when '01' { return 'Hospital'; }
            when '02' { return 'Professional office'; }
            when '03' { return 'Home health agency'; }
            when '04' { return 'Skilled nursing facility'; }
            when '05' { return 'Residential care facility'; }
            when '06' { return 'Outpatient clinic'; }
            when '07' { return 'Ambulance service'; }
            when '08' { return 'Laboratory'; }
            when '09' { return 'Pharmacy'; }
            when '10' { return 'Durable medical equipment provider'; }
            when '11' { return 'Other healthcare provider'; }
            when '96' { return 'Unknown or not specified'; }
            when '97' { return 'Not applicable'; }
            when '98' { return 'Foreign healthcare provider'; }
            when '99' { return 'Healthcare provider not identified'; }
            when else { return ''; }
        }
    }
    public static String getCLPFacilityTypeCode(String facilityTypeCode) {
        switch on facilityTypeCode {
            when '01' { return 'Original Claim'; }
            when '02' { return 'Amended Claim'; }
            when '03' { return 'Void Claim'; }
            when '04' { return 'Replacement Claim'; }
            when '05' { return 'Resubmission Claim'; }
            when '06' { return 'Supplemental Claim'; }
            when '07' { return 'Reversal Claim'; }
            when '08' { return 'Appeal Claim'; }
            when '09' { return 'Duplicate Claim'; }
            when '10' { return 'Information Only Claim'; }
            when '11' { return 'Inquiry Claim'; }
            when '12' { return 'Correction Claim'; }
            when '13' { return 'Predetermination Claim'; }
            when '14' { return 'Preauthorization Claim'; }
            when '15' { return 'Post-Payment Adjustment Claim'; }
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
            when '1' { return 'First claim for this service in this episode of care'; }
            when '2' { return 'Subsequent claim for this service in this episode of care'; }
            when '3' { return 'Last claim for this service in this episode of care'; }
            when '4' { return 'Single claim for this service in this episode of care'; }
            when '5' { return 'Claim for a new episode of care'; }
            when '6' { return 'Claim for an episode of care with a different diagnosis'; }
            when '7' { return 'Claim for a different service in this episode of care'; }
            when '8' { return 'Claim for a service that is not related to the primary diagnosis'; }
            when '9' { return 'Other'; }
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
            when '1' { return 'Represents a unique trace identifier'; }
            when '2' { return 'Denotes a previously assigned reference number'; }
            when '3' { return 'Indicates a Cancellation Request'; }
            when '4' { return 'Represents a Return Request'; }
            when '5' { return 'Denotes a Change Request'; }
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
            when '067' { return 'Document or Reference Date'; }
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
            when 'PQ' { return 'Payer Identification'; }
            when '1K' { return 'Agriculture Department Loan Number'; }
            when '1S' { return 'Case Number'; }
            when '2U' { return 'Medicare Claim Number'; }
            when '3H' { return 'Patients Medicaid Number'; }
            when '4A' { return 'Hospitals Internal Billing Number'; }
            when '6R' { return 'Shipper\'s Identification Number'; }
            when '7R' { return 'Carriers Pro Number'; }
            when '9A' { return 'Repriced Claim Number'; }
            when 'AA' { return 'American Bankers Association (ABA) Routing Number'; }
            when 'AI' { return 'American Institute of Certified Public Accountants (AICPA) Certificate Number'; }
            when 'AP' { return 'American Petroleum Institute (API) Number'; }
            when 'BB' { return 'Service Identification Number'; }
            when 'BM' { return 'Borrowers Loan Number'; }
            when 'BT' { return 'Bank Transit Number'; }
            when 'CA' { return 'Cancelled Purchase Order Number'; }
            when 'CD' { return 'Certificate of Deposit (CD) Number'; }
            when 'CK' { return 'Check Number'; }
            when 'CN' { return 'Contract Number'; }
            when 'CO' { return 'Credit Card Number'; }
            when 'CR' { return 'Credit Reference Number'; }
            when 'CU' { return 'Customer Number'; }
            when 'CV' { return 'Customer Vendor Number'; }
            when 'EA' { return 'Employer Identification Number (EIN)'; }
            when 'EM' { return 'Employee Number'; }
            when 'EN' { return 'Enrollment Number'; }
            when 'EQ' { return 'Equipment Number'; }
            when 'EV' { return 'Event Number'; }
            when 'F8' { return 'Shipping Account Number'; }
            when 'FN' { return 'Financial Account Number'; }
            when 'FP' { return 'Federal Provider Number (FPN)'; }
            when 'FR' { return 'Federal Reserve District Number'; }
            when 'FT' { return 'Federal Taxpayer Identification Number (FTIN)'; }
            when 'G1' { return 'Medicare Claim Number'; }
            when 'G3' { return 'Medicaid Claim Number'; }
            when 'GB' { return 'Government Bill of Lading Number'; }
            when 'HC' { return 'Healthcare Provider Identifier (NPI)'; }
            when 'HI' { return 'Health Insurance Claim Number (HICN)'; }
            when 'HP' { return 'Hospital Provider Number'; }
            when 'HPI' { return 'Hospital Provider Index'; }
            when 'IG' { return 'Investment Grade'; }
            when 'IN' { return 'Invoice Number'; }
            when 'LI' { return 'Loan Number'; }
            when 'LU' { return 'Line Item Unique Identifier'; }
            when 'MD' { return 'Medical Record Number'; }
            when 'MN' { return 'Member Number'; }
            when 'MR' { return 'Medicaid Recipient Identification Number (MRIN)'; }
            when 'MS' { return 'Master Account Number'; }
            when 'MT' { return 'Medicare Beneficiary Identifier (MBI)'; }
            when 'MV' { return 'Motor Vehicle Identification Number (VIN)'; }
            when 'NA' { return 'National Association of Insurance Commissioners (NAIC) Identifier'; }
            when 'NC' { return 'National Council for Prescription Drug Programs (NCPDP) Number'; }
            when 'NE' { return 'National Provider Identifier (NPI)'; }
            when 'NP' { return 'National Provider Identifier (NPI)'; }
            when 'NR' { return 'National Provider Identifier (NPI)'; }
            when 'NT' { return 'National Drug Code (NDC)'; }
            when 'NU' { return 'National Uniform Claim Committee (NUCC) Procedure Code'; }
            when 'OA' { return 'Order Acknowledgment Number'; }
            when 'OC' { return 'Original Purchase Order Number'; }
            when 'OG' { return 'On-line Position Activity Number'; }
            when 'ON' { return 'Order Number'; }
            when 'OT' { return 'Other'; }
            when 'P4' { return 'Price List Number'; }
            when 'P5' { return 'Property List Number'; }
            when 'PA' { return 'Patient Account Number'; }
            when 'PC' { return 'Policy Number'; }
            when 'PM' { return 'Priority Mail Number'; }
            when 'PN' { return 'Part Number'; }
            when 'PO' { return 'Purchase Order Number'; }
            when 'PP' { return 'Purchase Order Number'; }
            when 'PR' { return 'Prescription Number'; }
            when 'PT' { return 'Patient Number'; }
            when 'PV' { return 'Provider Number'; }
            when 'PY' { return 'Payer Number'; }
            when 'R3' { return 'Real Estate Contract Number'; }
            when 'RA' { return 'Receiving Advice'; }
            when 'RB' { return 'Requisition Number'; }
            when 'RN' { return 'Registered Nurse (RN) License Number'; }
            when 'RR' { return 'Routing Number'; }
            when 'RT' { return 'Return Merchandise Authorization Number'; }
            when 'SA' { return 'Sales Agreement Number'; }
            when 'SE' { return 'Serial Number'; }
            when 'SN' { return 'Serial Number'; }
            when 'SP' { return 'State Provider Number'; }
            when 'SR' { return 'State Registration Number'; }
            when 'SS' { return 'Social Security Number (SSN)'; }
            when 'ST' { return 'State Taxpayer Identification Number (STIN)'; }
            when 'SV' { return 'Service Provider Number'; }
            when 'SW' { return 'Social Security Number'; }
            when 'TA' { return 'Taxpayer Identification Number (TIN)'; }
            when 'TJ' { return 'Federal Taxpayer Identification Number'; }
            when 'TN' { return 'Transaction Number'; }
            when 'TP' { return 'Taxpayer Identification Number (TIN)'; }
            when 'VN' { return 'Vendor Number'; }
            when 'VP' { return 'Vendor Number'; }
            when 'VR' { return 'Vendor Reference Number'; }
            when 'VY' { return 'Vessel Name'; }
            when 'XC' { return 'Cross Reference Number'; }
            when 'XP' { return 'Expiration Date'; }
            when 'XX' { return 'Not Available'; }
            when 'ZZ' { return 'Mutually Defined'; }
            when else { return ''; }
            
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
            when '1' { return 'Paid in full'; }
            when '2' { return 'Denied'; }
            when '3' { return 'Partially paid'; }
            when '4' { return 'Duplicate'; }
            when '5' { return 'Exceeds policy limits'; }
            when '6' { return 'Benefits exhausted'; }
            when '7' { return 'Not covered'; }
            when '8' { return 'Requires further review'; }
            when '9' { return 'Pending'; }
            when '10' { return 'Referenced to another plan'; }
            when '11' { return 'Investigative denial'; }
            when '12' { return 'Payment pending review'; }
            when '13' { return 'Predetermination not met'; }
            when '14' { return 'Benefits limited'; }
            when '15' { return 'Not eligible for this service'; }
            when '16' { return 'Coordination of benefits required'; }
            when '17' { return 'Frequency exceeds policy limits'; }
            when '18' { return 'Time limits exceed'; }
            when '19' { return 'Prior authorization required'; }
            when '20' { return 'Provider not participating'; }
            when '21' { return 'Requires medical justification'; }
            when '22' { return 'Duplicate claim'; }
            when '23' { return 'Services not medically necessary'; }
            when '98' { return 'Other'; }
            when else { return ''; }
        }
    }
    public static String getCASandMOAGroupCode(String strAdjustGroupCode){
        switch on strAdjustGroupCode  {
            when 'CO' { return 'Contractual Obligations'; }
            when 'CR' { return 'Corrections and Reversals'; }
            when 'OA' { return 'Other Adjustments'; }
            when 'PI' { return 'Payer Initiated Reductions'; }
            when 'PR' { return 'Patient Responsibility'; }
            when 'A0' { return 'Medicare Primary, No MSP Record'; }
            when 'A1' { return 'Medicare Primary, MSP Adjudicated'; }
            when 'A2' { return 'Medicare Primary, MSP Billed'; }
            when 'A3' { return 'Medicare Primary, MSP Paid'; }
            when 'MA01' { return 'Medicare Secondary Adjustment'; }
            when 'MB' { return 'Medicare Blood Deductible'; }
            when 'MC' { return 'Medicare Lifetime Reserve'; }
            when else { return ''; }
        }
    }
    public static String getAdjustmentReason(String strAdjustReason){
        switch on strAdjustReason  {
            when '1' { return 'COB Adjustment - Primary Payer'; }
            when '2' { return 'Coinsurance Adjustment'; }
            when '3' { return 'Lifetime Maximum Reached'; }
            when '4' { return 'Deductible Adjustment'; }
            when '5' { return 'Frequency Limitation Exceeded'; }
            when '6' { return 'Non-Covered Service or Item'; }
            when '7' { return 'Prior Authorization Required'; }
            when '8' { return 'Coordination of Benefits (COB) Adjustment - Other Payer'; }
            when '9' { return 'Health Maintenance Organization (HMO) Capitation Adjustment'; }
            when '10' { return 'Preferred Provider Organization (PPO) Discount'; }
            when '11' { return 'Non-Participating Provider Adjustment'; }
            when '12' { return 'Non-Covered Charge Adjustment'; }
            when '13' { return 'Patient Responsibility Adjustment'; }
            when '14' { return 'Other Contractual Adjustment'; }
            when '15' { return 'Non-Covered Service by Contract'; }
            when '16' { return 'Medicare Secondary Payer (MSP) Adjustment'; }
            when '17' { return 'Duplicate Submission'; }
            when '18' { return 'Other Contractual Adjustment'; }
            when '19' { return 'Non-Covered Charge by Contract'; }
            when '20' { return 'Withhold Payment'; }
            when '21' { return 'Contractual Overpayment Adjustment'; }
            when '22' { return 'Coordination of Benefits Adjustment'; }
            when '23' { return 'Prior Payment Adjustment'; }
            when '24' { return 'Internal Revenue Service (IRS) Levy Adjustment'; }
            when '25' { return 'Claim Adjustment'; }
            when '26' { return 'Withhold Payment - Pending Further Review'; }
            when '27' { return 'Claim Adjustment - Denied'; }
            when '28' { return 'Claim Adjustment - Approved'; }
            when '29' { return 'Withhold Payment'; }
            when '30' { return 'Claim Adjustment - Corrected'; }
            when '31' { return 'Claim Adjustment - Suspended'; }
            when '32' { return 'Claim Adjustment - Reversed'; }
            when '33' { return 'Claim Adjustment - Void'; }
            when '34' { return 'Claim Adjustment - Finalized'; }
            when '35' { return 'Claim Adjustment - Pending'; }
            when '36' { return 'Claim Adjustment - Reopened'; }
            when '37' { return 'Claim Adjustment - Closed'; }
            when '38' { return 'Claim Adjustment - Approved - Pending Payment'; }
            when '39' { return 'Claim Adjustment - Denied - Pending Review'; }
            when '40' { return 'Claim Adjustment - Appeal Approved'; }
            when '41' { return 'Claim Adjustment - Appeal Denied'; }
            when '42' { return 'Deductible Adjustment'; }
            when '43' { return 'Claim Adjustment - Processed'; }
            when '44' { return 'Claim Adjustment - Not Processed'; }
            when '45' { return 'Payment Adjustment'; }
            when '46' { return 'Payment Adjustment - Overpayment'; }
            when '47' { return 'Payment Adjustment - Underpayment'; }
            when '48' { return 'Payment Adjustment - Duplicate Payment'; }
            when '49' { return 'Payment Adjustment - Void Payment'; }
            when '50' { return 'Payment Adjustment - Corrected Payment'; }
            when '51' { return 'Payment Adjustment - Suspended Payment'; }
            when '52' { return 'Payment Adjustment - Reversed Payment'; }
            when '53' { return 'Payment Adjustment - Finalized Payment'; }
            when '54' { return 'Payment Adjustment - Pending Payment'; }
            when '55' { return 'Payment Adjustment - Reopened Payment'; }
            when '56' { return 'Payment Adjustment - Closed Payment'; }
            when '57' { return 'Payment Adjustment - Approved - Pending Disbursement'; }
            when '58' { return 'Payment Adjustment - Denied - Pending Review'; }
            when '59' { return 'Payment Adjustment - Appeal Approved'; }
            when '60' { return 'Payment Adjustment - Appeal Denied'; }
            when '61' { return 'Withhold Adjustment'; }
            when '62' { return 'Withhold Adjustment - Overpayment'; }
            when '63' { return 'Withhold Adjustment - Underpayment'; }
            when '64' { return 'Withhold Adjustment - Duplicate Withhold'; }
            when '65' { return 'Withhold Adjustment - Void Withhold'; }
            when '66' { return 'Withhold Adjustment - Corrected Withhold'; }
            when '67' { return 'Withhold Adjustment - Suspended Withhold'; }
            when '68' { return 'Withhold Adjustment - Reversed Withhold'; }
            when '69' { return 'Withhold Adjustment - Finalized Withhold'; }
            when '70' { return 'Withhold Adjustment - Pending Withhold'; }
            when '71' { return 'Withhold Adjustment - Reopened Withhold'; }
            when '72' { return 'Withhold Adjustment - Closed Withhold'; }
            when '73' { return 'Withhold Adjustment - Approved - Pending Release'; }
            when '74' { return 'Withhold Adjustment - Denied - Pending Review'; }
            when '75' { return 'Withhold Adjustment - Appeal Approved'; }
            when '76' { return 'Withhold Adjustment - Appeal Denied'; }
            when '77' { return 'Other Adjustment Remark'; }
            when '78' { return 'Contractual Adjustment Remark'; }
            when '79' { return 'Payment Remark'; }
            when '80' { return 'Coordination of Benefits (COB) Adjustment - Primary Payer'; }
            when '81' { return 'Coinsurance Adjustment'; }
            when '82' { return 'Lifetime Maximum Reached'; }
            when '83' { return 'Deductible Adjustment'; }
            when '84' { return 'Frequency Limitation Exceeded'; }
            when '85' { return 'Non-Covered Service or Item'; }
            when '86' { return 'Prior Authorization Required'; }
            when '87' { return 'Coordination of Benefits (COB) Adjustment - Other Payer'; }
            when '88' { return 'Health Maintenance Organization (HMO) Cap'; }
            when '141' { return 'Non-Covered Service or Item'; }
            when '104' { return 'Contractual Adjustment'; }
            when '267' { return 'MSP Crossover Adjustment - Conditional Payment'; }
            when 'A8' { return 'COB Adjustment - Secondary Payer'; }
            when '258' { return 'COB Adjustment - Other Payer'; }
            when '253' { return 'Withhold Adjustment'; }
            when 'PR' { return 'Payment Remark'; }
            when 'CR' { return 'Contractual Adjustment Remark'; }
            when 'OA' { return 'Other Adjustment Remark'; }
            when 'PI' { return 'Payment Information'; }
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
            when '47' { return 'Experimental or investigational adjustment amount'; }
            when '48' { return 'Fraud or abuse adjustment amount'; }
            when '49' { return 'Medical necessity adjustment amount'; }
            when '50' { return 'Patient responsibility amount'; }
            when '51' { return 'Precertification or authorization adjustment amount'; }
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
            when 'HC' { return 'Healthcare'; }
            when 'RX' { return 'Prescription'; }
            when 'HE' { return 'Claim Payment Remark'; }
            when 'EB' { return 'Explanation of Benefits Remark'; }
            when 'RA' { return 'Remittance Advice Remark'; }
            when 'AR' { return 'Authorization Remark'; }
            when 'RE' { return 'Referral Remark'; }
            when 'PR' { return 'Precertification Remark'; }
            when 'UR' { return 'Utilization Review Remark'; }
            when 'PA' { return 'Prior Authorization Remark'; }
            when 'QA' { return 'Quality Assurance Remark'; }
            when 'FR' { return 'Fraud Remark'; }
            when 'AB' { return 'Abuse Remark'; }
            when 'OA' { return 'Other Remark'; }
            when 'ZZ' { return 'Mutually Defined'; }
            when else { return ''; }
        }
    }   
    public static String getGSTransactionTypeCodeText(String value) {
        switch on value{
            when 'X' { return 'Accredited Standards Committee X12 (ASC X12)'; }
            when 'D' { return 'United Nations or EDIFACT'; }
            when 'F' { return 'Finance Industry Standards Association (FISA)'; }
            when 'I' { return 'Data Interchange Standards Association (DISA)'; }
            when 'T' { return 'Transportation Data Coordinating Committee (TDCC)'; }
            when else { return ''; }
        }
    }
    public static String getSecurityInfoQualifierText(String securityCode) {
        switch on securityCode {
            when '00' { return 'No Security Information'; }
            when '01' { return 'Password'; }
            when '02' { return 'Digital Certificate'; }
            when '03' { return 'Kerberos'; }
            when '04' { return 'Public or Private Key Pair'; }
            when else { return ''; }
        }
    }
    public static String getAuthorizationType(String authCode) {
        switch on authCode {
            when '00' { return 'No Authorization Information Present'; }
            when '01' { return 'Password'; }
            when '02' { return 'Secured Certificate'; }
            when '03' { return 'Kerberos'; }
            when '04' { return 'SSL (Secure Socket Layer)'; }
            when '05' { return 'S or MIME (Secure or Multipurpose Internet Mail Extensions)'; }
            when '06' { return 'TLS (Transport Layer Security)'; }
            when '07' { return 'SSH (Secure Shell)'; }
            when else { return ''; }
        }
    }
    public static String getackRequestedText(String authCode) {
        switch on authCode {
            when '0' { return 'No acknowledgment is requested'; }
            when '1' { return 'An acknowledgment is requested'; }
            when else { return ''; }
        }
    }
    public static String getBPRIdentificationType(String code) {
        switch on code {
            when '01' { return 'American Bankers Association (ABA) Transit Routing Number'; }
            when '02' { return 'Society for Worldwide Interbank Financial Telecommunication (SWIFT) ID'; }
            when '03' { return 'Clearing House Interbank Payments System (CHIPS) Participant ID'; }
            when '04' { return 'Canadian Payments Association routing number'; }
            when '05' { return 'Electronic Transaction Identifiers (ETI)'; }
            when '06' { return 'National Clearing Code'; }
            when '07' { return 'German Bankleitzahl (BLZ) Code'; }
            when '08' { return 'Australian Bank State Branch (BSB) Code'; }
            when '09' { return 'Swiss Clearing Code'; }
            when '10' { return 'Indian Financial System Code (IFSC)'; }
            when else { return ''; }
        }
    }
    public static String getN1IdentificationCode(String code) {
        switch on code {
            when 'FI' { return 'Federal Taxpayer Identification Number'; }
            when 'XV' { return 'Health Care Financing Administration'; }
            when 'MI' { return 'Member Identification Number'; }
            when 'NF' { return 'National Association of Insurance Commissioners Company Code'; }
            when 'SY' { return 'Social Security Number'; }
            when 'ZZ' { return 'Mutually Defined'; }
            when 'NI' { return 'National Association of Insurance Commissioners (NAIC) Identification'; }
            when 'PR' { return 'Payer'; }
            when 'PE' { return 'Payee'; }
            when '41' { return 'Name of the referring physician'; }
            when 'FA' { return 'Facility'; }
            when 'IL' { return 'Insured or Subscriber'; }
            when 'TQ' { return 'Treatment Authorization Code'; }
            when '1P' { return 'Person'; }
            when '2P' { return 'Partnership'; }
            when '3P' { return 'Corporation'; }
            when '4P' { return 'Non-Person Entity'; }
            when '6P' { return 'Government Agency'; }
            when '71' { return 'Party'; }
            when '72' { return 'Service Provider'; }
            when 'XX' { return 'Health Care Financing Administration National Provider Identifier (NPI)'; }
            when else { return ''; }
        }
    }
    public static String getPERContactFunctionCodeText(String code) {
        switch on code {
            when 'AA' { return 'Assistant'; }
            when 'AC' { return 'Accountant'; }
            when 'AD' { return 'Authorized Representative'; }
            when 'AE' { return 'Associate Engineer'; }
            when 'AG' { return 'Agent'; }
            when 'AH' { return 'Authorizing Party'; }
            when 'AI' { return 'Additional Individual'; }
            when 'AL' { return 'Alternative Individual'; }
            when 'AM' { return 'Alternate Accountant'; }
            when 'AN' { return 'Additional Contact'; }
            when 'AP' { return 'Account Payable Contact'; }
            when 'AQ' { return 'Additional Authorized Representative'; }
            when 'AR' { return 'Additional Representative'; }
            when 'AS' { return 'Assistant to'; }
            when 'AT' { return 'Authorized Technician'; }
            when 'AU' { return 'Author'; }
            when 'AZ' { return 'Additional Contact Name'; }
            when 'BE' { return 'Beneficiary'; }
            when 'BL' { return 'Shipper\'s Contact'; }
            when 'BR' { return 'Brokers Contact or Buyer'; }
            when 'BS' { return 'Buying Group Staff'; }
            when 'BU' { return 'Backup Contact'; }
            when 'CA' { return 'Contact'; }
            when 'CB' { return 'Combined Office or Plant Representative'; }
            when 'CC' { return 'Contact to Call'; }
            when 'CI' { return 'Consultant'; }
            when 'CL' { return 'Complainant'; }
            when 'CN' { return 'Consignee\'s Contact or Contact'; }
            when 'CO' { return 'Company Officer'; }
            when 'CP' { return 'Contact Person'; }
            when 'CR' { return 'Carrier'; }
            when 'CS' { return 'Case Worker'; }
            when 'CT' { return 'Contact Person'; }
            when 'CU' { return 'Customer'; }
            when 'CX' { return 'Contact Person'; }
            when 'CZ' { return 'Certified Public Accountant (CPA)'; }
            when 'DA' { return 'Data Recipient'; }
            when 'DE' { return 'Designated Associate Engineer'; }
            when 'DG' { return 'Designated Underwriter'; }
            when 'DH' { return 'Designated Representative'; }
            when 'DI' { return 'Designated Individual'; }
            when 'DL' { return 'Delivery Department'; }
            when 'DM' { return 'Decision Maker'; }
            when 'DN' { return 'Distributor'; }
            when 'DP' { return 'Designated Person'; }
            when 'DR' { return 'Director'; }
            when 'DS' { return 'Decision Support'; }
            when 'DU' { return 'Designee'; }
            when 'DV' { return 'Developer'; }
            when 'EA' { return 'Employee'; }
            when 'EC' { return 'Emergency Contact'; }
            when 'EE' { return 'Engineering Department'; }
            when 'EF' { return 'Estate Contact'; }
            when 'EG' { return 'Engineer'; }
            when 'EM' { return 'Emergency'; }
            when 'EN' { return 'Engineer of Record'; }
            when 'EO' { return 'Educational Officer'; }
            when 'EP' { return 'Exchange Partner'; }
            when 'ER' { return 'Emergency Room'; }
            when 'ES' { return 'Expert or Scientist'; }
            when 'EV' { return 'Evaluator'; }
            when 'EX' { return 'Exchange Manager, Executor of Estate, Exporter\'s Contact'; }
            when 'FA' { return 'Facsimile'; }
            when 'FI' { return 'Financial Institution Contact'; }
            when 'FO' { return 'Financial Officer'; }
            when 'FP' { return 'Financial Person'; }
            when 'FR' { return 'Filer'; }
            when 'FS' { return 'Fiduciary'; }
            when 'GA' { return 'General Partner'; }
            when 'GC' { return 'General Contractor'; }
            when 'GE' { return 'General Engineer'; }
            when 'GN' { return 'General Information'; }
            when 'GR' { return 'Group Manager'; }
            when 'GS' { return 'General Supervisor'; }
            when 'GU' { return 'Guardian'; }
            when 'HC' { return 'Health Care Provider'; }
            when 'HR' { return 'Human Resources Contact'; }
            when 'IA' { return 'Injured Party'; }
            when 'IC' { return 'In Charge Person'; }
            when 'ID' { return 'Internal Contact'; }
            when 'II' { return 'Insured or Subscriber'; }
            when 'IM' { return 'Importer'; }
            when 'IN' { return 'Informant, Interested Party'; }
            when 'IP' { return 'Individual to Receive Purchase Order, Insured Party'; }
            when 'IS' { return 'Information Services Contact'; }
            when 'IT' { return 'Investor'; }
            when 'IU' { return 'Internal Use'; }
            when 'JV' { return 'Joint Venture'; }
            when 'LD' { return 'Limited Partner'; }
            when 'LE' { return 'Legal Counsel'; }
            when 'LR' { return 'Legal Representative, Lender'; }
            when 'LS' { return 'Landlord'; }
            when 'LT' { return 'Land Trustee'; }
            when 'MA' { return 'Manager'; }
            when 'MB' { return 'Member'; }
            when 'MC' { return 'Manager of Sales'; }
            when 'ME' { return 'Maintenance Engineer'; }
            when 'MR' { return 'Member of the Firm'; }
            when 'MS' { return 'Managing Partner'; }
            when 'MU' { return 'Mutual Company'; }
            when 'MV' { return 'Master Servicer'; }
            when 'MW' { return 'Master of the Work'; }
            when 'MX' { return 'Master Beneficiary'; }
            when 'NA' { return 'Notary'; }
            when 'NC' { return 'Notice Contact'; }
            when 'NP' { return 'Name Partner'; }
            when 'NS' { return 'Nurse'; }
            when 'NU' { return 'Nursing Department'; }
            when 'OA' { return 'Office Automation'; }
            when 'OC' { return 'Officer, Originating Carrier'; }
            when 'OE' { return 'Officer of the Company'; }
            when 'OP' { return 'Owner Partner'; }
            when 'OV' { return 'Owner'; }
            when 'PA' { return 'Paralegal'; }
            when 'PB' { return 'Publisher'; }
            when 'PC' { return 'Partner'; }
            when 'PD' { return 'Payee'; }
            when 'PE' { return 'Payor'; }
            when 'PG' { return 'Programming'; }
            when 'PH' { return 'Pharmacist'; }
            when 'PI' { return 'Personal Representative'; }
            when 'PL' { return 'Principal Investigator'; }
            when 'PM' { return 'Project Manager'; }
            when 'PN' { return 'Person'; }
            when 'PO' { return 'Purchasing Contact'; }
            when 'PP' { return 'Person to Pick Up Parts, Purchasing Party'; }
            when 'PR' { return 'Payer, President'; }
            when 'PS' { return 'Personnel Supervisor'; }
            when 'PT' { return 'Partner Technical'; }
            when 'PU' { return 'Pick Up Person'; }
            when 'PY' { return 'Payroll Department'; }
            when 'QA' { return 'Quality Assurance Contact'; }
            when 'QB' { return 'Quantity Buyer'; }
            when 'QC' { return 'Quality Control'; }
            when 'QD' { return 'Quality Control Department'; }
            when 'QO' { return 'Quantity Owner'; }
            when 'RA' { return 'Receptionist'; }
            when 'RB' { return 'Receiving'; }
            when 'RE' { return 'Receiver, Recipient'; }
            when 'RF' { return 'Referral'; }
            when 'RG' { return 'Regional Contact'; }
            when 'RH' { return 'Recipient'; }
            when 'RI' { return 'Reference Individual'; }
            when 'RM' { return 'Registered Mail'; }
            when 'RP' { return 'Representative, Responsible Party'; }
            when 'RQ' { return 'Requestor'; }
            when 'RR' { return 'Release Recipient'; }
            when 'RS' { return 'Regulatory Services'; }
            when 'RT' { return 'Regional Contact'; }
            when 'RU' { return 'Responsible Union'; }
            when 'RW' { return 'Regional Welding'; }
            when 'RY' { return 'Referral Yard'; }
            when 'SA' { return 'Sales Representative, Shipper\'s Agent'; }
            when 'SB' { return 'Shipping Contact'; }
            when 'SC' { return 'Shipper\'s Contact'; }
            when 'SD' { return 'Shipment Delivery'; }
            when 'SE' { return 'Seals Data Contact, Second Engineer'; }
            when 'SH' { return 'Secretary'; }
            when 'SI' { return 'Shipper'; }
            when 'SK' { return 'Shipper\'s Sales Representative'; }
            when 'SL' { return 'Sale'; }
            when 'SM' { return 'Senior Manager'; }
            when 'SN' { return 'Shipper\'s Credit Department'; }
            when 'SO' { return 'State Officer'; }
            when 'SP' { return 'Sales'; }
            when 'SQ' { return 'Supervisor - Quoting'; }
            when 'SR' { return 'Service Bureau'; }
            when 'SS' { return 'Seller'; }
            when 'ST' { return 'Survey Team'; }
            when 'SU' { return 'Subscriber, Supervisor, Supplier'; }
            when 'TA' { return 'Testing'; }
            when 'TC' { return 'Technical Contact'; }
            when 'TE' { return 'Technical'; }
            when 'TH' { return 'Trustee'; }
            when 'TI' { return 'Title Company'; }
            when 'TL' { return 'Trustee for the Lender'; }
            when 'TO' { return 'Technical Officer, Terminal Operator'; }
            when 'TP' { return 'Third Party'; }
            when 'TR' { return 'Trading Partner'; }
            when 'TS' { return 'Technical Support Contact'; }
            when 'TU' { return 'Transportation Officer'; }
            when 'TV' { return 'Treasurer'; }
            when 'TX' { return 'Taxpayer'; }
            when 'TZ' { return 'Telecommunications Manager'; }
            when 'UC' { return 'Union Representative'; }
            when 'UL' { return 'Ultimate Parent'; }
            when 'UM' { return 'Underwriting Department'; }
            when 'UN' { return 'Unknown'; }
            when 'UR' { return 'Underwriter'; }
            when 'VA' { return 'Vendor'; }
            when 'VC' { return 'Vendor Contact'; }
            when 'VI' { return 'Vendor Information'; }
            when 'VL' { return 'Violator'; }
            when 'VO' { return 'Vendor of Record'; }
            when 'VP' { return 'Vice President'; }
            when 'VR' { return 'Verification'; }
            when 'WH' { return 'Warehouse'; }
            when 'WI' { return 'Within'; }
            when 'WR' { return 'Writer'; }
            when 'WU' { return 'Withholding Agent'; }
            when 'XI' { return 'Executor'; }
            when 'XM' { return 'Executive Manager'; }
            when 'XS' { return 'X-Ray Specialist'; }
            when 'YR' { return 'Yard Person'; }
            when else { return ''; }
        }
    }
    public static String getcreditDebitFlagText(String code) {
        switch on code {
            when 'C' { return 'Credit'; }
            when 'D' { return 'Debit'; }
            when else { return ''; }
        }
    }
    public static String getpaymentMethodCodeText(String code) {
        switch on code {
            when 'ACH' { return 'Automated Clearing House (ACH) - Electronic Fund Transfer'; }
            when 'BOP' { return 'Balance of Payment'; }
            when 'CHK' { return 'Paper Check'; }
            when 'FWT' { return 'Federal Withholding Tax (FWT)'; }
            when 'NON' { return 'No Payment Made or Non-Payment Data'; }
            when else { return ''; }
        }
    }    
}