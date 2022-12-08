/*REXX*/
sums = "0 0 0"; sum = 0
do while lines(input.txt) > 0 
   incalories = linein(input.txt) 
   if incalories = ' ' then do
      sums = sortSums(sum, sums)
      sum = 0
   end
   else
      sum += incalories
end

say "part1:" word(sums, 3)
say "part2:" word(sums, 1) + word(sums, 2) + word(sums, 3)

exit

sortSums: procedure 
   arg sum, sums
   do i = 1 to 3 by 1 
      sumStem.i = word(sums, i)
   end
   if sum > word(sums, 1) then do 
      sumStem.1 = sum
      sumStem.0 = 3 
      address system "sort" with input stem sumStem. output stem sumStem. 
   end
   return sumStem.1 sumStem.2 sumStem.3