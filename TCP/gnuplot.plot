#!/usr/bin/gnuplot

#set multiplot
set title "Throughput"
set xlabel "Time"
set ylabel "Throughput"
set grid
set xrange [000.00:55.00]
#set yrange [20:50]
plot "out.txt" using 1:2 title "TCP" with lines lt 1 lc rgb 'blue'
#unset multiplot
set terminal png
set output "tcp.png"
replot
