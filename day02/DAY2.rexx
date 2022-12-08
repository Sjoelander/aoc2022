/*REXX*/
sum = 0
sum2 = 0
results.A.X = 1 + 3; results2.A.X = 3 + 0 
results.A.Y = 2 + 6; results2.A.Y = 1 + 3
results.A.Z = 3 + 0; results2.A.Z = 2 + 6
results.B.X = 1 + 0; results2.B.X = 1 + 0 
results.B.Y = 2 + 3; results2.B.Y = 2 + 3
results.B.Z = 3 + 6; results2.B.Z = 3 + 6
results.C.X = 1 + 6; results2.C.X = 2 + 0 
results.C.Y = 2 + 0; results2.C.Y = 3 + 3
results.C.Z = 3 + 3; results2.C.Z = 1 + 6
do while lines(input.txt) > 0 
   str = linein(input.txt) 
   parse var str o ' ' p
   sum += results.o.p
   sum2 += results2.o.p
end

say "part1:" sum
say "part2:" sum2

exit 