public class EDI837PSegmentSE {
public static String generatSESegment(integer count){
        String SE = 'SE';
        SE += '*' + count;
        SE += '*' + EDIDataMappings.Transactionsetcontrol_02;
        SE += '~';
        return SE + '\n';
}
}