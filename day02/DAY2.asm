         YREGS
DAY2     CSECT
         STM   R14,R12,12(R13)         
         LR    R12,R15                 
         USING DAY2,R12
         ST    R13,SAVE+4              
         LR    R14,R13
         LA    R13,SAVE               
         ST    R13,8(,R14)             
         OPEN  (IN01,INPUT)
IN01READ GET   IN01,INREC 
         TR    PLAYER(1),TRANSTAB
         L     R1,PLAYER
         
         B     IN01READ
CLEANUP  EQU   *
         CLOSE IN01
         UNPK  WTOTEXT,SCORE 
         OI    WTOTEXT+6,X'F0'
         BAL   R3,WTOROUT
RETURN   L     R13,SAVE+4             
         LM    R14,R12,12(R13)         
         LA    R15,0                  
         BR    R14        
WTOROUT  EQU   *
         WTO   MF=(E,WTOBLOCK)
         BR    R3                      
IN01     DCB   DDNAME=INPUT,DSORG=PS,MACRF=GM,RECFM=FT,LRECL=3,        -
               EODAD=CLEANUP
         LTORG      
SAVE     DC    18F'0'                
         DS    0H                    
WTOBLOCK EQU   *
         DC    H'11'                
         DC    H'0'                  
WTOTEXT  DC    CL7' '

SCORE    DC    PL4'0'
INREC    EQU   *
OPPON    DS    CL1
         DS    CL1
PLAYER   DS    CL1

RESTAB   DC    PL1'1',PL1'3'     AA 1,1 
         DC    PL1'2',PL1'6'     AB 1,2
         DC    PL1'3',PL1'0'     AC 1,3
         DC    PL1'1',PL1'0'     BA 2,1
         DC    PL1'2',PL1'3'     BB 2,2
         DC    PL1'3',PL1'6'     BC 2,3
         DC    PL1'1',PL1'6'     CA 3,1
         DC    PL1'2',PL1'0'     CB 3,2
         DC    PL1'3',PL1'3'     CC 3,3
TRANSTAB DC    256X'00'
         ORG   TRANSTAB+C'X'
         DC    X'C1C2C3'
         DC    X'FF'
         END