       IDENTIFICATION DIVISION.
       PROGRAM-ID. DAY2.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT INPUT-FILE ASSIGN TO 'input.txt'
           ORGANIZATION IS LINE SEQUENTIAL.
       DATA DIVISION.
       FILE SECTION.
       FD  INPUT-FILE.
       01  STRATEGY.
           05 OPPONENT-CHOICE      PIC X(1).
           05 FILLER               PIC X(1).
           05 PLAYER-CHOICE        PIC X(1).
       WORKING-STORAGE SECTION.     
       01 OCHOICE-ORD              PIC 9(4) BINARY.
       01 PCHOICE-ORD              PIC 9(4) BINARY.
       01 SCORE-PART1              PIC 9(9) BINARY.
       01 SCORE-PART2              PIC 9(9) BINARY.
       01 RESULT                   PIC S9(4) BINARY.
       01 INPUT-FILE-STATUS        PIC X(1) VALUE X'00'.
           88 INPUT-FILE-EOF                VALUE X'FF'.

       PROCEDURE DIVISION.
           OPEN INPUT INPUT-FILE 

           PERFORM UNTIL INPUT-FILE-EOF
              READ INPUT-FILE
                 AT END 
                    SET INPUT-FILE-EOF TO TRUE
                 NOT AT END  
                    COMPUTE PCHOICE-ORD = FUNCTION ORD(PLAYER-CHOICE) 
                       - FUNCTION ORD('X')
                    COMPUTE OCHOICE-ORD = FUNCTION ORD(OPPONENT-CHOICE) 
                       - FUNCTION ORD('A')
                    COMPUTE RESULT = PCHOICE-ORD - OCHOICE-ORD

                    EVALUATE TRUE 
                       WHEN RESULT = 1 OR RESULT = -2   
                          ADD +6 TO SCORE-PART1
                       WHEN RESULT = 0                
                          ADD +3 TO SCORE-PART1
                    END-EVALUATE           
                    ADD PCHOICE-ORD, +1 TO SCORE-PART1

                    EVALUATE PCHOICE-ORD ALSO OCHOICE-ORD
                       WHEN 0 ALSO 0
                          ADD +3 TO SCORE-PART2
                       WHEN 0 ALSO 1 THROUGH 2
                          ADD OCHOICE-ORD TO SCORE-PART2
                       WHEN 1 ALSO 0 THROUGH 2
                          ADD +3, OCHOICE-ORD, +1 TO SCORE-PART2
                       WHEN 2 ALSO 0 THROUGH 2
                          COMPUTE SCORE-PART2 = SCORE-PART2 + 6
                          + FUNCTION MOD((OCHOICE-ORD + 1), 3) + 1
                    END-EVALUATE
              END-READ
           END-PERFORM

           CLOSE INPUT-FILE

           DISPLAY SCORE-PART1
           DISPLAY SCORE-PART2
           
           STOP RUN.
       END PROGRAM DAY2.
