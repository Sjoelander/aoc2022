/*REXX*/
tmppath = ""; paths. = ""; paths.0 = 0; i=0; 
do while lines(input.txt) > 0 
   line = linein(input.txt) 
   select
      when (line == "$ ls") then
         nop
      when (line == "$ cd ..") then do
         tmppath = strip(delword(tmppath,words(tmppath)))
      end
      when (substr(line,1,4) == "$ cd") then do
         tmppath = tmppath strip(word(line,3))
         i += 1;
         paths.i = strip(tmppath)
         paths.0 = i
         paths.i.sum = 0
      end
      otherwise
         if (substr(line,1,3) == "dir") then
            nop
         else do
            paths.i.sum += word(line, 1)
         end
   end
end
do i = paths.0 to 2 by -1
   p = paths.i 
   pp = strip(delword(p,words(p)))
   j = 0; k = 0;
   do l = i by -1 while (j == 0 | k == 0)
      if paths.l = p then do
         j = l
      end
      if paths.l = pp then do
         k = l
      end
   end 
   paths.k.sum += paths.j.sum
end

needed = 30000000 - (70000000 - paths.1.sum)

s = 0; m = paths.1.sum
do i = 1 to paths.0 by 1
   j = paths.i.sum
   if j <= 100000 then
      s += j
   if j => needed then
      m = min(m,j)
end

say "Part 1:" s
say "Part 2:" m