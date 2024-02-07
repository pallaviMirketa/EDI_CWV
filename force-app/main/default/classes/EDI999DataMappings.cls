public class EDI999DataMappings {
    public static String getIK3SegmentDescription(String isaValue) {
        switch on isaValue {
            when 'ISA' {return ' Interchange Control Header'; }
            when 'GS' { return 'Functional Group Header'; }
            when 'ST' { return 'Transaction Set Header'; }
            when 'BHT' { return 'Beginning of Hierarchical Transaction'; }
            when 'NM1' { return 'Individual or Organizational Name'; }
            when 'N3' { return 'Street Address'; }
            when 'N4' { return 'City, State, and ZIP'; }
            when 'PER' { return 'Administrative Communications Contact'; }
            when 'HL' { return 'Fiscal Intermediary Identification'; }
            when 'REF' { return 'Reference Identification'; }
            when 'CLM' {return 'Claim Information'; }
            when 'SBR' { return 'US Federal Tax Identification Number'; }
            when 'DMG' { return 'Demographic'; }
            when 'SV1' { return 'Service Line Information';}
            when 'DTP' { return 'Date or Time Period'; }
            when 'PRV' { return 'Provider'; }
            when 'LX' { return 'Number of claims'; }
            when else { return ''; }
        }
    }
    public static String getErrorMessage(String errorCode) {
        switch on errorCode {
            when '1' { return 'Unrecognized segment';  }
            when '2' { return 'Unexpected segment'; }
            when '3' { return 'Required segment missing'; }
            when '4' {return 'Loop occurs too many times'; }
            when '5' { return 'Segment not in defined transaction set'; }
            when '6' { return 'Segment has data in invalid field'; }
            when '7' { return 'Segment not in proper sequence'; }
            when '8' { return 'Segment has data element errors'; }
            when '9' { return 'Implementation - defined error'; }
            when else { return ''; }
        }
    }
        public static String getAcknowledgementCode(String value) {
        switch on value {
            when 'A' { return 'Accepted';  }
            when 'E' { return 'Accepted with Errors'; }
            when 'R' { return 'Rejected'; }
            when 'P' {return 'Partially Accepted'; }
            when else { return ''; }
        }
    }
}