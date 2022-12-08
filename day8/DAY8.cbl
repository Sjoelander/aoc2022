       IDENTIFICATION DIVISION.
       PROGRAM-ID. DAY8.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT INPUT-FILE ASSIGN TO 'input.txt'
           ORGANIZATION IS LINE SEQUENTIAL.
       DATA DIVISION.
       FILE SECTION.
       FD  INPUT-FILE.
       01  INREC                       PIC X(256).
       WORKING-STORAGE SECTION.
       01  X                           PIC S9(4) BINARY.
       01  Y                           PIC S9(4) BINARY.
       01  MAX-Y                       PIC S9(4) BINARY.
       01  MAX-X                       PIC S9(4) BINARY.
       01  I                           PIC S9(4) BINARY.
       01  J                           PIC S9(4) BINARY.
       01  K                           PIC  9(4) BINARY.
       01  CNT                         PIC  9(4) BINARY.
       01  A                           PIC  9(4) BINARY.
       01  B                           PIC  9(4) BINARY.
       01  C                           PIC  9(4) BINARY.
       01  D                           PIC  9(4) BINARY.
       01  MAX-SCORE                   PIC  9(9) BINARY.   
       01  SCORE                       PIC  9(9) BINARY.
       01  FILLER                      PIC X VALUE X'00'.
           88 B1                           VALUE X'FF' FALSE X'00'.
       01  FILLER                      PIC X VALUE X'00'.
           88 B2                           VALUE X'FF' FALSE X'00'.
       01  FILLER                      PIC X VALUE X'00'.
           88 B3                           VALUE X'FF' FALSE X'00'.
       01  FILLER                      PIC X VALUE X'00'.
           88 B4                           VALUE X'FF' FALSE X'00'.
       01  INPUT-FILE-STATUS           PIC X   VALUE X'00'.
           88 INPUT-FILE-EOF               VALUE X'FF'.
       01  GRID-TABLE.
           02  TREE-ROW OCCURS 256 TIMES.
               03  TREE-XY OCCURS 256 TIMES PIC 9.

       PROCEDURE DIVISION.
           OPEN INPUT INPUT-FILE 
           PERFORM UNTIL INPUT-FILE-EOF
              READ INPUT-FILE
                 AT END 
                    SET INPUT-FILE-EOF TO TRUE
                 NOT AT END  
                    ADD 1 TO I
                    MOVE INREC TO TREE-ROW(I)
              END-READ
           END-PERFORM
           CLOSE INPUT-FILE

           COMPUTE MAX-Y = I
           COMPUTE MAX-X = FUNCTION LENGTH(FUNCTION TRIM(INREC))
           PERFORM VARYING X FROM 2 BY 1 UNTIL X = MAX-Y
               PERFORM VARYING Y FROM 2 BY 1 UNTIL Y = MAX-Y        
                   SET B1 TO FALSE
                   COMPUTE J = X - 1
                   MOVE ZERO TO K
                   *> Check if visible from the left
                   PERFORM VARYING I FROM J BY -1 UNTIL I = 0 OR B1
                       ADD 1 TO K
                       IF TREE-XY(I,Y) >= TREE-XY(X,Y) THEN 
                           SET B1 TO TRUE
                       END-IF
                   END-PERFORM
                   MOVE K TO A

                   SET B2 TO FALSE
                   COMPUTE J = X + 1
                   MOVE ZERO TO K
                   *> Check if visible from the right
                   PERFORM VARYING I FROM J BY 1 UNTIL I > MAX-X OR B2
                       ADD 1 TO K
                       IF TREE-XY(I,Y) >= TREE-XY(X,Y) THEN 
                           SET B2 TO TRUE
                       END-IF
                   END-PERFORM
                   MOVE K TO B
                   
                   SET B3 TO FALSE
                   COMPUTE J = Y - 1 
                   MOVE ZERO TO K
                   *> Check if visible from up
                   PERFORM VARYING I FROM J BY -1 UNTIL I = 0 OR B3
                       ADD 1 TO K
                       IF TREE-XY(X,I) >= TREE-XY(X,Y) THEN 
                           SET B3 TO TRUE
                       END-IF
                   END-PERFORM
                   MOVE K TO C
                   
                   SET B4 TO FALSE
                   COMPUTE J = Y + 1 
                   MOVE ZERO TO K
                   *> Check if visible from down
                   PERFORM VARYING I FROM J BY 1 UNTIL I > MAX-Y OR B4
                       ADD 1 TO K
                       IF TREE-XY(X,I) >= TREE-XY(X,Y) THEN 
                           SET B4 TO TRUE
                       END-IF
                   END-PERFORM
                   MOVE K TO D

                   COMPUTE SCORE = A * B * C * D
                   COMPUTE MAX-SCORE = 
                       FUNCTION MAX(MAX-SCORE, SCORE)

                   *> Visible FROM either direction
                   IF NOT B1 OR NOT B2 OR NOT B3 OR NOT B4 THEN 
                       ADD +1 TO CNT
                   END-IF
               END-PERFORM
           END-PERFORM
           
           *> Count edges
           COMPUTE CNT = CNT + ((MAX-X * 2) + 2 * (MAX-X - 2))

           DISPLAY 'PART 1: ' CNT   
           DISPLAY 'PART 2: ' MAX-SCORE
           STOP RUN.

       END PROGRAM DAY8.
