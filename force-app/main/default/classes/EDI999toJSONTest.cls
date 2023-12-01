@isTest
public class EDI999toJSONTest {
    @istest
    public static void parseEDI999toJSONTest(){
        String str999= 'ISA*00*          *00*          *ZZ*11111          *ZZ*1234567        *210315*1457*^*00501*000000001*0*P*:~GS*FA*XXXXX*XXXXXXX*210315*1457*0*X*005010X231A1~ST*999*0002*005010X231A1~AK1*HC*101*005010X222A1~AK2*837*0021~IK3*SBR*16**8~IK4*9*1032*7*BI~IK5*R*5~AK9*R*1*1*0~SE*8*0002~GE*1*0~IEA*1*000000001~';
        Test.startTest();
        String edi999Json = EDI999toJSON.parseEDI999toJSON(str999); 
        Test.stopTest();
        System.assertEquals(true, edi999Json.Contains('Elixir'));    }
}