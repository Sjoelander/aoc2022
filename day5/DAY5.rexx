/*REXX*/
line = linein(input.txt) 
stacks. = ""
stacks.0 = (length(line) + 1)/4
/* parse the structure for the initial state */
do while line \= " "
   if verify(line, "01234789", "M") > 0 then do
      line = linein(input.txt) 
      iterate
   end
   j = 2
   do i = 1 by 1 to stacks.0 
      if substr(line,j,1) \= ' ' then 
         stacks.i = stacks.i || substr(line,j,1)
      j = j + 4
   end
   line = linein(input.txt) 
end

/* copy stacks to stacks2 which is for part2 */
stacks2. = ""
stacks2.0 = stacks.0
do i = 1 by 1 to stacks.0
   stacks2.i = stacks.i
end

do while lines(input.txt) > 0 
   line = linein(input.txt) 
   parse var line w1 i w2 x w3 y /* e.g. "move 1 from 2 to 1" */
   stacks.y = reverse(substr(stacks.x,1,i)) || stacks.y 
   stacks2.y = substr(stacks2.x,1,i) || stacks2.y 
   j = length(stacks.x) - i 
   stacks.x = right(stacks.x,j)
   stacks2.x = right(stacks2.x,j)
end

/* get top of each stack */
str = ""; str2 = "";
do i = 1 by 1 to stacks.0
   c = substr(stacks.i,1,1); c2 = substr(stacks2.i,1,1)
   str = str || c; str2 = str2 || c2
end

say "part1:" str
say "part2:" str2

exit