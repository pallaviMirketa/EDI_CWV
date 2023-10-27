public class EDI837PSegmentGEIEA {
    public static string genrateGEAndIEASegments(){
        
        String footerSection = '';
        footerSection += generateGESegment();
        footerSection += generateIEASegment();
        
        return footerSection;
    }    

    public static String generateGESegment(){
        String GE = 'GE';
        GE += '*' + EDIDataMappings.numberofTransactionSetsIncluded;
        GE += '*' + EDIDataMappings.groupControlNumber;
        GE += '~';
        return GE + '\n';
        
        /* catch(exception e){
    ElixirSuite__Exception_Log__c objExp = new ElixirSuite__Exception_Log__c();
    objExp.ElixirSuite__Stack_Trace_Long__c = 'EDI837p: Error ocuured GE Segment.' +  e.getMessage();
    Insert objExp;
    return null;
    }*/
    }
    public static String generateIEASegment(){
        String IEA = 'IEA';
        IEA += '*' + EDIDataMappings.numberofIncludedFunctionalGroups;
        IEA += '*' + EDIDataMappings.interchangeControlNumber;
        IEA += '~';
        return IEA + '\n';
        
        /*catch(exception e){
    ElixirSuite__Exception_Log__c objExp = new ElixirSuite__Exception_Log__c();
    objExp.ElixirSuite__Stack_Trace_Long__c = 'EDI837p: Error ocuured IEA Segment.' +  e.getMessage();
    Insert objExp;
    return null;
    }*/
    }
}