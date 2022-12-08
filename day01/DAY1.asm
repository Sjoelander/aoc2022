         YREGS
DAY1     CSECT
         STM   R14,R12,12(R13)         
         LR    R12,R15                 
         USING DAY1,R12
         ST    R13,SAVE+4              
         LR    R14,R13
         LA    R13,SAVE               
         ST    R13,8(,R14)             
         OPEN  (IN01,INPUT)
IN01READ GET   IN01,INREC 
         LA    R3,IN01READ 
         CLC   INREC,=C'     '
         BE    NEWELF
         TRT   INREC,SPACETAB
         BZ    NOSPACES
         LA    R2,INREC
         SR    R1,R2
         AHI   R1,-1
         EX    R1,PACKREC
         B     ADDSUM
NOSPACES PACK  CAL,INREC
ADDSUM   AP    CALSUM,CAL      
         B     IN01READ
CLEANUP  EQU   *
         BAL   R3,NEWELF
         CLOSE IN01
         UNPK  WTOTEXT,MAXSUM
         OI    WTOTEXT+6,X'F0'
         BAL   R3,WTOROUT
         AP    MAXSUM,MAXSUM2
         AP    MAXSUM,MAXSUM3
         UNPK  WTOTEXT,MAXSUM
         OI    WTOTEXT+6,X'F0'  
         BAL   R3,WTOROUT
RETURN   L     R13,SAVE+4             
         LM    R14,R12,12(R13)         
         LA    R15,0                  
         BR    R14
NEWELF   EQU   * 
         CP    CALSUM,MAXSUM
         BNH   CHKSUM2
         ZAP   MAXSUM3,MAXSUM2
         ZAP   MAXSUM2,MAXSUM
         ZAP   MAXSUM,CALSUM
         B     RESET
CHKSUM2  EQU   * 
         CP    CALSUM,MAXSUM2
         BNH   CHKSUM3
         ZAP   MAXSUM3,MAXSUM2
         ZAP   MAXSUM2,CALSUM
         B     RESET
CHKSUM3  EQU   *
         CP    CALSUM,MAXSUM3
         BNH   RESET
         ZAP   MAXSUM3,CALSUM 
RESET    ZAP   CALSUM,=P'0'
         BR    R3
PACKREC  PACK  CAL,0(0,R2)         
WTOROUT  EQU   *
         WTO   MF=(E,WTOBLOCK)
         BR    R3                      
IN01     DCB   DDNAME=INPUT,DSORG=PS,MACRF=GM,RECFM=FB,LRECL=5,        -
               EODAD=CLEANUP
         LTORG      
SAVE     DC    18F'0'                
         DS    0H                    
WTOBLOCK EQU   *
         DC    H'11'                
         DC    H'0'                  
WTOTEXT  DC    CL7' '
*
INREC    DC    CL5' '
CAL      DC    PL4' '
CALSUM   DC    PL4'0'
MAXSUM   DC    PL4'0'
MAXSUM2  DC    PL4'0'
MAXSUM3  DC    PL4'0'
SPACETAB DC    256X'00'
         ORG   SPACETAB+C' '
         DC    X'FF'
         END