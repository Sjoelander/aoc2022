/*REXX*/
fullyoverlaps = 0; overlaps = 0
do while lines(input.txt) > 0 
   str = linein(input.txt)
   parse var str x1 '-' x2 ',' y1 '-' y2
   overlaps += (x1 <= y2) & (x2 >= y1)
   fullyoverlaps += ((x1 >= y1) & (x2 <= y2)) | ((y1 >= x1) & (y2 <= x2))
end

say "part1:" fullyoverlaps
say "part2:" overlaps

exit