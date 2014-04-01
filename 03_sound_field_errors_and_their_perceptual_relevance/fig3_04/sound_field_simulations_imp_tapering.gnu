#!/usr/bin/gnuplot
# generated by SFS-Toolbox, see: http://github.com/sfstoolbox/sfs
reset
set macros
set loadpath '../../gnuplot'

set t epslatex size 10cm,5cm color colortext
set output 'sound_field_simulations_imp_tapering.tex';

load 'border.cfg'
load 'moreland.pal'
load 'array.cfg'

set format '$%g$'

unset key
set size ratio -1


set xrange [-1.25:1.25]
set yrange [-1.9:0.25]
set cbrange [-1:1]
set tics scale 0.75 out nomirror
set xtics 1 offset 0,0.5
set ytics 1 offset 0.5,0
set cbtics 1
set xlabel '$x$ / m' offset 0,1
set ylabel '$y$ / m' offset 1.5,0
unset colorbox

set bmargin 1
set tmargin 0

set multiplot layout 1,2
set label 1 'no tapering' at -1,-1.7 left front
set label 2 '\ft edge waves' at 0.8,-1.4 center front
set arrow from 0.8,-1.3 to 0.00,-0.4 front size 0.05,25
set arrow from 0.8,-1.3 to 0.52,-0.4 front size 0.05,25
set lmargin 4
set rmargin 0
plot 'wfs_notapering.dat' binary matrix u 1:2:(0.2*real(-$3)) with image,\
     'array.txt' @array_active w l
unset arrow
set label 1 'tapering'
unset label 2
set border 1
unset ylabel
set format y ''
set ytics scale 0
#set lmargin 2
#set rmargin 2
plot 'wfs_tapering.dat' binary matrix u 1:2:(0.2*real(-$3)) with image,\
     'array.txt' @array_active w l
unset multiplot
