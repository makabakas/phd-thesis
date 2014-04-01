#!/usr/bin/gnuplot
# generated by SFS-Toolbox, see: http://github.com/sfstoolbox/sfs
set t epslatex size 5cm,5cm color colortext
set output 'sound_field_nfchoa_ps.tex';

load 'border.cfg'
load 'moreland.pal'
load 'array.cfg'

set format '$%g$'

unset key
set size ratio -1

set xrange [-1.75:1.75]
set yrange [-1.75:1.75]
set cbrange [-1:1]
set tics scale 0.75 out nomirror
set xtics 1 offset 0,0.5
set ytics 1 offset 0.5,0
set xlabel '$x$ / m' offset 0,1
set ylabel '$y$ / m' offset 1.5,0
unset colorbox

set bmargin 1

plot 'sound_field_nfchoa_ps_f1000Hz_nls64.dat' binary matrix with image,\
     'array.txt' @array_active w l
