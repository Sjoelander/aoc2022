       IDENTIFICATION DIVISION.
       PROGRAM-ID. DAY6.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT INPUT-FILE ASSIGN TO 'input.txt'
           ORGANIZATION IS LINE SEQUENTIAL.
       DATA DIVISION.
       FILE SECTION.
       FD  INPUT-FILE.
       01  INREC                   PIC X(4095).
       WORKING-STORAGE SECTION. 
       01  I                       PIC 9(4) BINARY VALUE 4095.
       01  J                       PIC 9(4) BINARY.
       01  K                       PIC 9(4) BINARY.
       01  L                       PIC 9(4) BINARY.
       01  M                       PIC 9(4) BINARY.
       01  LEN                     PIC 9(4) BINARY.
       01  CHAR-TBL.
           02 CHARS OCCURS 1 TO 4095 TIMES
                    DEPENDING ON I 
                    INDEXED BY IDX PIC X.    
       01  FLAGS.
           02 FILLER               PIC 9 VALUE 0.
               88 FOUND-CHAR           VALUE 1 FALSE 0.
           02 FILLER               PIC 9 VALUE 0.
               88 DONE                 VALUE 1 FALSE 0.
       PROCEDURE DIVISION.

           OPEN INPUT INPUT-FILE 
           READ INPUT-FILE
           CLOSE INPUT-FILE
           
           MOVE INREC TO CHAR-TBL
           MOVE FUNCTION LENGTH(FUNCTION TRIM(INREC)) TO LEN

           MOVE +4 TO M
           PERFORM FIND-MARKER
           DISPLAY 'PART1: ' I

           MOVE +14 TO M
           PERFORM FIND-MARKER
           DISPLAY 'PART2: ' I
                      
           STOP RUN.

       FIND-MARKER.
           SET DONE TO FALSE
           PERFORM VARYING I FROM M BY 1 UNTIL I > LEN
               OR DONE
               COMPUTE J = I - M + 1
               COMPUTE L = J + M
               SET FOUND-CHAR TO FALSE
               PERFORM VARYING K FROM J BY 1 UNTIL K > L
                   OR FOUND-CHAR
                   COMPUTE IDX = K + 1
                   SEARCH CHARS 
                       WHEN CHARS(IDX) = CHARS(K)
                           SET FOUND-CHAR TO TRUE
                   END-SEARCH
               END-PERFORM
               IF NOT FOUND-CHAR THEN
                   SET DONE TO TRUE
               END-IF
           END-PERFORM
           SUBTRACT 1 FROM I
           .

       END PROGRAM DAY6.
