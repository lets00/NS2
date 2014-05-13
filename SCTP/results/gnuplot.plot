#!/usr/bin/gnuplot

#set multiplot
set title "File Transfer Time"
set xlabel "Bandwidth (Kbps,Mbps)"
set ylabel "Time (s)"
set grid
#set yrange [000.00:99.00]
#set yrange [20:50]
plot "SCTPresults2.txt" using 1:3:xtic(2) title "SCTP 0% loss" with lines lt 1 lc rgb 'blue'
#unset multiplot
set terminal png
set output "sctp.png"
replot
