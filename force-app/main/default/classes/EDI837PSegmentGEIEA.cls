public class EDI837PSegmentGEIEA {
    public static string genrateGEAndIEASegments(){
        try{
            String footerSection = '';
            footerSection += generateGESegment();
            footerSection += generateIEASegment();
            
            System.debug(footerSection);
            return footerSection;
        }    
        catch(exception e){
            ElixirSuite__Exception_Log__c objExp = new ElixirSuite__Exception_Log__c();
            objExp.ElixirSuite__Stack_Trace_Long__c = 'EDI837p: Error ocuured GE and IEA Segment.' +  e.getMessage();
            Insert objExp;
            return null;
        }
    }
    public static String generateGESegment(){
        try{
        String GE = 'GE';
        GE += '*' + EDIDataMappings.numberofTransactionSetsIncluded;
        GE += '*' + EDIDataMappings.groupControlNumber;
        GE += '~';
        return GE + '\n';
        }    
        catch(exception e){
            ElixirSuite__Exception_Log__c objExp = new ElixirSuite__Exception_Log__c();
            objExp.ElixirSuite__Stack_Trace_Long__c = 'EDI837p: Error ocuured GE Segment.' +  e.getMessage();
            Insert objExp;
            return null;
        }
    }
    public static String generateIEASegment(){
        try{
        String IEA = 'IEA';
        IEA += '*' + EDIDataMappings.numberofIncludedFunctionalGroups;
        IEA += '*' + EDIDataMappings.interchangeControlNumber;
        IEA += '~';
        return IEA + '\n';
        }    
        catch(exception e){
            ElixirSuite__Exception_Log__c objExp = new ElixirSuite__Exception_Log__c();
            objExp.ElixirSuite__Stack_Trace_Long__c = 'EDI837p: Error ocuured IEA Segment.' +  e.getMessage();
            Insert objExp;
            return null;
        }
    }
}