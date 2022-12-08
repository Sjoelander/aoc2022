       IDENTIFICATION DIVISION.
       PROGRAM-ID. DAY4.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT INPUT-FILE ASSIGN TO 'input.txt'
           ORGANIZATION IS LINE SEQUENTIAL.
       DATA DIVISION.
       FILE SECTION.
       FD  INPUT-FILE.
       01  SECTION-RECORD          PIC X(25).
       WORKING-STORAGE SECTION. 
       01  SECTION-RANGE1          PIC X(15).
       01  SECTION-RANGE2          PIC X(15).
       01  SECTION-START           PIC X(5).
       01  SECTION-END             PIC X(5).
       01  MIN1                    PIC 9(4) BINARY.
       01  MAX1                    PIC 9(4) BINARY.
       01  MIN2                    PIC 9(4) BINARY.
       01  MAX2                    PIC 9(4) BINARY.
       01  OVERLAPS-FULLY-COUNTER  PIC 9(4) BINARY VALUE ZERO.
       01  OVERLAPS-COUNTER        PIC 9(4) BINARY VALUE ZERO.
       01  INPUT-FILE-STATUS       PIC X(1) VALUE X'00'.
           88 INPUT-FILE-EOF                VALUE X'FF'.

       PROCEDURE DIVISION.
           OPEN INPUT INPUT-FILE 
           PERFORM UNTIL INPUT-FILE-EOF
              READ INPUT-FILE
                 AT END 
                    SET INPUT-FILE-EOF TO TRUE
                 NOT AT END  
                    UNSTRING SECTION-RECORD DELIMITED BY ','
                       INTO SECTION-RANGE1 
                            SECTION-RANGE2
                    UNSTRING SECTION-RANGE1 DELIMITED BY '-'
                       INTO  SECTION-START
                             SECTION-END
                    COMPUTE MIN1 = FUNCTION NUMVAL(SECTION-START)
                    COMPUTE MAX1 = FUNCTION NUMVAL(SECTION-END)
                    UNSTRING SECTION-RANGE2 DELIMITED BY '-'
                       INTO  SECTION-START
                             SECTION-END
                    COMPUTE MIN2 = FUNCTION NUMVAL(SECTION-START)
                    COMPUTE MAX2 = FUNCTION NUMVAL(SECTION-END)
                    IF ((MIN1 <= MAX2) AND (MAX1 >= MIN2)) THEN
                       ADD +1 TO OVERLAPS-COUNTER
                       IF ((MIN1 >= MIN2) AND (MAX1 <= MAX2))
                       OR ((MIN2 >= MIN1) AND (MAX2 <= MAX1)) THEN
                          ADD +1 TO OVERLAPS-FULLY-COUNTER
                       END-IF
                    END-IF
              END-READ
           END-PERFORM
           
           DISPLAY 'PART1: ' OVERLAPS-FULLY-COUNTER
           DISPLAY 'PART2: ' OVERLAPS-COUNTER
 
           CLOSE INPUT-FILE

           STOP RUN.
           
       END PROGRAM DAY4.
