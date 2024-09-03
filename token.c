static char *tokenStrings[40] = {"EOFnum", "ANDnum", "ASSGNnum",
                                 "DECLARATIONSnum", "DOTnum", "ENDDECLARATIONSnum",
                                 "EQUALnum", "GTnum", "IDnum", "INTnum", "LBRACnum",
                                 "LPARENnum", "METHODnum", "NEnum", "ORnum", "PROGRAMnum",
                                 "RBRACnum", "RPARENnum", "SEMInum", "VALnum", "WHILEnum",
                                 "CLASSnum", "COMMAnum", "DIVIDEnum", "ELSEnum", "EQnum",
                                 "GEnum", "ICONSTnum", "IFnum", "LBRACEnum", "LEnum", "LTnum",
                                 "MINUSnum", "NOTnum", "PLUSnum", "RBRACEnum", "RETURNnum",
                                 "SCONSTnum", "TIMESnum", "VOIDnum"};

char *getTokenString(int type)
{
    return tokenStrings[type];
}