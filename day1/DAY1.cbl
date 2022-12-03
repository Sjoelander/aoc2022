       IDENTIFICATION DIVISION.
       PROGRAM-ID. DAY1.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT INPUT-FILE ASSIGN TO 'input.txt'
           ORGANIZATION IS LINE SEQUENTIAL.
       DATA DIVISION.
       FILE SECTION.
       FD  INPUT-FILE.
       01  CALORIES                PIC X(5).
       WORKING-STORAGE SECTION.
       01 CALORIES-TABLE OCCURS 3 TIMES.
           05 CALORIES-TABLE-SUM   PIC 9(9) BINARY VALUE ZERO.
       01 CALORIES-SUM             PIC 9(9) BINARY VALUE ZERO.   
       01 INPUT-FILE-STATUS        PIC X(1) VALUE X'00'.
           88 INPUT-FILE-EOF                VALUE X'FF'.

       PROCEDURE DIVISION.
           OPEN INPUT INPUT-FILE 

           PERFORM UNTIL INPUT-FILE-EOF
              READ INPUT-FILE
                 AT END 
                    SET INPUT-FILE-EOF TO TRUE
                    PERFORM CHECK-ELF
                 NOT AT END 
                    IF CALORIES = SPACE THEN *> NEW ELF
                       PERFORM CHECK-ELF
                       MOVE ZERO TO CALORIES-SUM
                    ELSE
                       ADD FUNCTION NUMVAL(CALORIES) TO CALORIES-SUM
                    END-IF
              END-READ
           END-PERFORM

           CLOSE INPUT-FILE

           DISPLAY 'HIGHEST SUM OF CALORIES: ' CALORIES-TABLE-SUM(1) '.'
           DISPLAY 'SUM OF THREE HIGHEST: ' 
                    FUNCTION SUM(CALORIES-TABLE-SUM(1), 
                           CALORIES-TABLE-SUM(2), 
                           CALORIES-TABLE-SUM(3)) '.'
           STOP RUN.

       CHECK-ELF.
           IF CALORIES-TABLE-SUM(3) < CALORIES-SUM THEN
              MOVE CALORIES-SUM TO CALORIES-TABLE-SUM(3)
              SORT CALORIES-TABLE DESCENDING CALORIES-TABLE-SUM
           END-IF
           .
        END PROGRAM DAY1.
