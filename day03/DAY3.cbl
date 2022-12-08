       IDENTIFICATION DIVISION.
       PROGRAM-ID. DAY3.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT INPUT-FILE ASSIGN TO 'input.txt'
           ORGANIZATION IS LINE SEQUENTIAL.
       DATA DIVISION.
       FILE SECTION.
       FD  INPUT-FILE.
       01  RUCKSACK                PIC X(50).
       WORKING-STORAGE SECTION. 
       01 STRING-TABLE.
           05 STRING-ELEMENT OCCURS 3 TIMES
                                   PIC X(50).
       01 RUCKSACK-TABLE.
           05 RUCKSACK-STRING OCCURS 3 TIMES
                                   PIC X(50).
       01 CHAR                     PIC X.
       01 PRIO-SCORE               PIC 9(4) BINARY.
       01 PRIO-SUM-PART1           PIC 9(9) BINARY.
       01 PRIO-SUM-PART2           PIC 9(9) BINARY.
       01 STR-LEN                  PIC 9(4) BINARY.
       01 OFFSET                   PIC 9(4) BINARY.
       01 GROUP-COUNTER            PIC 9(4) BINARY.
       01 INPUT-FILE-STATUS        PIC X(1) VALUE X'00'.
           88 INPUT-FILE-EOF                VALUE X'FF'.

       PROCEDURE DIVISION.
           OPEN INPUT INPUT-FILE 

           PERFORM UNTIL INPUT-FILE-EOF
              READ INPUT-FILE
                 AT END 
                    SET INPUT-FILE-EOF TO TRUE
                 NOT AT END  
                    PERFORM PART1 
                    ADD 1 TO GROUP-COUNTER
                    MOVE RUCKSACK TO RUCKSACK-STRING(GROUP-COUNTER)
                    IF GROUP-COUNTER = 3 THEN
                       PERFORM PART2
                       MOVE ZERO TO GROUP-COUNTER
                    END-IF
              END-READ
           END-PERFORM
           
           DISPLAY 'PART1: ' PRIO-SUM-PART1
           DISPLAY 'PART2: ' PRIO-SUM-PART2
 
           CLOSE INPUT-FILE

           STOP RUN.

       PART1.
           COMPUTE STR-LEN = FUNCTION LENGTH(FUNCTION TRIM(RUCKSACK,
              TRAILING))/2
           ADD 1 TO STR-LEN GIVING OFFSET
           MOVE RUCKSACK(1:STR-LEN) TO STRING-ELEMENT(1)
           MOVE RUCKSACK(OFFSET:) TO STRING-ELEMENT(2)
           CALL 'DAY3CHAR2' USING STRING-TABLE, CHAR
           CALL 'DAY3PRIO' USING CHAR, PRIO-SCORE
           ADD PRIO-SCORE TO PRIO-SUM-PART1
           .

       PART2.
           MOVE RUCKSACK-TABLE TO STRING-TABLE
           CALL 'DAY3CHAR3' USING STRING-TABLE, CHAR
           CALL 'DAY3PRIO' USING CHAR, PRIO-SCORE
           ADD PRIO-SCORE TO PRIO-SUM-PART2
           .
       END PROGRAM DAY3.

       IDENTIFICATION DIVISION.
       PROGRAM-ID. DAY3CHAR.
       DATA DIVISION.
       LOCAL-STORAGE SECTION. 
       01 I                  PIC 9(4) BINARY.
       01 J                  PIC 9(4) BINARY.
       01 J-MAX              PIC 9(4) BINARY.
       01 K                  PIC 9(4) BINARY.
       01 L                  PIC 9(4) BINARY.
       01 STR-LEN            PIC 9(4) BINARY.
       01 CHAR               PIC X.
       01 FILLER OCCURS 2 TIMES PIC X(1) VALUE ALL X'00'.
           88 FOUND                   VALUE X'FF' FALSE X'00'.
       LINKAGE SECTION. 
       01 RET-CHAR           PIC X.
       01 STR-TABLE.
           05 STR OCCURS 3 TIMES PIC X(50).
       PROCEDURE DIVISION.
       ENTRIES.
           ENTRY 'DAY3CHAR3'  USING STR-TABLE, RET-CHAR
           MOVE 3 TO J-MAX
           GO TO MAIN
           ENTRY 'DAY3CHAR2' USING STR-TABLE, RET-CHAR
           MOVE 2 TO J-MAX
           SET FOUND(2) TO TRUE
           GO TO MAIN
           .
       MAIN.
           COMPUTE STR-LEN = FUNCTION LENGTH(FUNCTION TRIM(STR(1), 
              TRAILING))
           PERFORM VARYING I FROM 1 BY 1 UNTIL I > STR-LEN OR
              (FOUND(1) AND FOUND(2))
              MOVE STR(1)(I:1) TO CHAR
              PERFORM VARYING J FROM 2 BY 1 UNTIL J > J-MAX
                  SUBTRACT 1 FROM J GIVING K
                  MOVE ZERO TO L
                  INSPECT STR(J) TALLYING L FOR ALL CHAR
                  IF L > 0 THEN 
                    SET FOUND(K) TO TRUE
                  ELSE 
                    SET FOUND(K) TO FALSE
                  END-IF
              END-PERFORM
           END-PERFORM
           MOVE CHAR TO RET-CHAR
           GOBACK
           .

       END PROGRAM DAY3CHAR.

       IDENTIFICATION DIVISION.
       PROGRAM-ID. DAY3PRIO.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION. 
       SPECIAL-NAMES.
           CLASS UPPER IS "ABCDEFGHIJKLMNOPQRSTUVWXYZ".
       DATA DIVISION.
       LOCAL-STORAGE SECTION. 
       LINKAGE SECTION. 
       01 CHAR               PIC X.
       01 PRIO-SCORE         PIC 9(4) BINARY.
       PROCEDURE DIVISION USING CHAR, PRIO-SCORE.
           IF CHAR IS UPPER THEN
              COMPUTE PRIO-SCORE = FUNCTION ORD(CHAR) 
                 - FUNCTION ORD('A') + 26 + 1
           ELSE 
              COMPUTE PRIO-SCORE = FUNCTION ORD(CHAR) 
                 - FUNCTION ORD('a') + 1
           END-IF

           GOBACK.

       END PROGRAM DAY3PRIO.
