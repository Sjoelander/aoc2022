/*REXX*/
rcrdcnt = 0; prtysum = 0; prtysum2 = 0

do while lines(input.txt) > 0 
   /* part1 */
   str = linein(input.txt)
   left = substr(str, 1, length(str)/2)
   right = substr(str, length(str)/2+1)
   char = substr(left,verify(left, right, "M"),1)
   prtysum += priority(char)

   /* part2 */
   rcrdcnt += 1
   i = rcrdcnt//3 + 1
   rucksacks.i = str
   if rcrdcnt//3 = 0 then do
      j = 1
      do forever
         idx = verify(rucksacks.1, rucksacks.2, "M", j)
         char = substr(rucksacks.1,idx,1)
         if verify(char,rucksacks.3, "M") = 0 then 
            j = idx + 1 
         else
            leave
      end
      prtysum2 += priority(char)
   end
end

say prtysum
say prtysum2

exit 0

priority: Procedure
   parse arg char
   chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
   return pos(char, chars)