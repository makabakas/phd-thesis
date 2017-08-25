#!/usr/bin/gnuplot
#
# FIGURE 3.15: Sound pressure of a low and high-frequency cosine shaped impulse
# synthesized as plane wave by NFC-HOA (2.45) and WFS (2.57) at three listening
# positions. A fixed offset was added to the sound pressure at two listening
# positions for a better visualization. The low-frequency impulses are presented
# in blue, the high-frequency impulses in red. Parameters: n_k = (0, -1, 0),
# x_ref = (0, 0, 0) m, circular secondary source distribution with a diameter of
# 3 m.
#
# AUTHOR:   Hagen Wierstorf
# SOFTWARE: gnuplot 5.0 patchlevel 3

#!/usr/bin/gnuplot
reset
set macros
set loadpath '../../gnuplot' 'data'

load 'latex.cfg'
load 'grid.cfg'
load 'rdbu.pal'

set terminal epslatex size 15.99cm,9.15cm color colortext @small
set output 'fig3_15.tex';

unset key

set bmargin 2
set tmargin 1.2

set multiplot
set size 0.356,0.5
set origin 0,0.5
load 'yborder.cfg'
set ylabel 'sound pressure'
set lmargin 7
set rmargin 0
set label 1 '\ft continuous secondary sources' at 6,1.4 center tc ls 101
set label 2 '\ft \acs{NFC-HOA}' at 11.8,-4.6 right front tc ls 101
stats 'lowpass_nfchoa_X0.00_Y0.00.txt' u 2 nooutput
plot [*:*] [-5:1] 'lowpass_nfchoa_X0.00_Y0.00.txt'  u ($1*1000):($2/STATS_max)   w l ls 8 lw 2,\
                  'lowpass_nfchoa_X0.75_Y0.00.txt'  u ($1*1000):($2/STATS_max-2) w l ls 7 lw 2,\
                  'lowpass_nfchoa_X0.00_Y0.75.txt'  u ($1*1000):($2/STATS_max-4) w l ls 6 lw 2,\
                  'highpass_nfchoa_X0.00_Y0.00.txt' u ($1*1000):($2/STATS_max)   w l ls 1 lw 2,\
                  'highpass_nfchoa_X0.75_Y0.00.txt' u ($1*1000):($2/STATS_max-2) w l ls 2 lw 2,\
                  'highpass_nfchoa_X0.00_Y0.75.txt' u ($1*1000):($2/STATS_max-4) w l ls 3 lw 2
set origin 0.335,0.5
load 'noborder.cfg'
unset ylabel
set lmargin 3.5
set rmargin 3.5
set label 1 '\ft 64 secondary sources'
stats 'lowpass_nfchoa_X0.00_Y0.00_nls64.txt' u 2 nooutput
plot [*:*] [-5:1] 'lowpass_nfchoa_X0.00_Y0.00_nls64.txt'  u ($1*1000):($2/STATS_max)   w l ls 8 lw 2,\
                  'lowpass_nfchoa_X0.75_Y0.00_nls64.txt'  u ($1*1000):($2/STATS_max-2) w l ls 7 lw 2,\
                  'lowpass_nfchoa_X0.00_Y0.75_nls64.txt'  u ($1*1000):($2/STATS_max-4) w l ls 6 lw 2,\
                  'highpass_nfchoa_X0.00_Y0.00_nls64.txt' u ($1*1000):($2/STATS_max)   w l ls 1 lw 2,\
                  'highpass_nfchoa_X0.75_Y0.00_nls64.txt' u ($1*1000):($2/STATS_max-2) w l ls 2 lw 2,\
                  'highpass_nfchoa_X0.00_Y0.75_nls64.txt' u ($1*1000):($2/STATS_max-4) w l ls 3 lw 2
set origin 0.67,0.5
load 'xborder.cfg'
set xlabel '$t$ / ms'
set lmargin 0
set rmargin 7
set label 2 '\ft band-limited \acs{NFC-HOA}'
set label 3 '\scs $<2$\,kHz' at 2.8,-1.2 center front tc ls 7
set label 4 '\scs $>2$\,kHz' at 6.2,-1.4 center front tc ls 2
stats 'lowpass_nfchoa_X0.00_Y0.00_nls64_band_limited.txt' u 2 nooutput
plot [*:*] [-5:1] 'lowpass_nfchoa_X0.00_Y0.00_nls64_band_limited.txt'  u ($1*1000):($2/STATS_max)   w l ls 8 lw 2,\
                  'lowpass_nfchoa_X0.75_Y0.00_nls64_band_limited.txt'  u ($1*1000):($2/STATS_max-2) w l ls 7 lw 2,\
                  'lowpass_nfchoa_X0.00_Y0.75_nls64_band_limited.txt'  u ($1*1000):($2/STATS_max-4) w l ls 6 lw 2,\
                  'highpass_nfchoa_X0.00_Y0.00_nls64_band_limited.txt' u ($1*1000):($2/STATS_max)   w l ls 1 lw 2,\
                  'highpass_nfchoa_X0.75_Y0.00_nls64_band_limited.txt' u ($1*1000):($2/STATS_max-2) w l ls 2 lw 2,\
                  'highpass_nfchoa_X0.00_Y0.75_nls64_band_limited.txt' u ($1*1000):($2/STATS_max-4) w l ls 3 lw 2
set origin 0,0
unset label 1
load 'xyborder.cfg'
set ylabel 'sound pressure'
set bmargin 3.2
set tmargin 0
set lmargin 7
set rmargin 0
set label 2 '\ft \acs{WFS}'
set label 3 '\scs listener at'  at 11,1.2 right front tc ls 101
set label 4 '\scs $(0,0,0)$\,m' at 11,0.5 right front tc ls 101
set label 5 '\scs $(0.75,0,0)$\,m' at 11,-1.5 right front tc ls 101
set label 6 '\scs $(0,0.75,0)$\,m' at 11,-3.5 right front tc ls 101
stats 'lowpass_wfs_X0.00_Y0.00.txt' u 2 nooutput
plot [*:*] [-5:1] 'lowpass_wfs_X0.00_Y0.00.txt'  u ($1*1000):($2/STATS_max)   w l ls 8 lw 2,\
                  'lowpass_wfs_X0.75_Y0.00.txt'  u ($1*1000):($2/STATS_max-2) w l ls 7 lw 2,\
                  'lowpass_wfs_X0.00_Y0.75.txt'  u ($1*1000):($2/STATS_max-4) w l ls 6 lw 2,\
                  'highpass_wfs_X0.00_Y0.00.txt' u ($1*1000):($2/STATS_max)   w l ls 1 lw 2,\
                  'highpass_wfs_X0.75_Y0.00.txt' u ($1*1000):($2/STATS_max-2) w l ls 2 lw 2,\
                  'highpass_wfs_X0.00_Y0.75.txt' u ($1*1000):($2/STATS_max-4) w l ls 3 lw 2
set origin 0.335,0
unset for [ii=3:6] label ii
load 'xborder.cfg'
set lmargin 3.5
set rmargin 3.5
stats 'lowpass_wfs_X0.00_Y0.00_nls64.txt' u 2 nooutput
plot [*:*] [-5:1] 'lowpass_wfs_X0.00_Y0.00_nls64.txt'  u ($1*1000):($2/STATS_max)   w l ls 8 lw 2,\
                  'lowpass_wfs_X0.75_Y0.00_nls64.txt'  u ($1*1000):($2/STATS_max-2) w l ls 7 lw 2,\
                  'lowpass_wfs_X0.00_Y0.75_nls64.txt'  u ($1*1000):($2/STATS_max-4) w l ls 6 lw 2,\
                  'highpass_wfs_X0.00_Y0.00_nls64.txt' u ($1*1000):($2/STATS_max)   w l ls 1 lw 2,\
                  'highpass_wfs_X0.75_Y0.00_nls64.txt' u ($1*1000):($2/STATS_max-2) w l ls 2 lw 2,\
                  'highpass_wfs_X0.00_Y0.75_nls64.txt' u ($1*1000):($2/STATS_max-4) w l ls 3 lw 2
unset multiplot

call 'plot.plt' 'fig3_15'

# vim: set textwidth=200:
