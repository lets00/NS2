set ns [new Simulator]

$ns color 1 Blue

set nf [open sctp.nam w]
$ns namtrace-all $nf

set TraceFile [open sctp.tr w]
$ns trace-all $TraceFile


#Create 4 nodes

set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]

$ns duplex-link $n0 $n1 10Mb 20ms DropTail
$ns duplex-link $n1 $n2 1Mb 20ms DropTail
$ns duplex-link $n2 $n3 10Mb 20ms DropTail

#SCTP

set sctp0 [new Agent/SCTP]
$ns attach-agent $n0 $sctp0

set sctp1 [new Agent/SCTP]
$ns attach-agent $n3 $sctp1
$ns connect $sctp0 $sctp1

set ftp [new Application/FTP]
$ftp attach-agent $sctp0

$ns at 0.1 "$ftp start"
$ns at 50.0 "$ftp stop"
 
proc finish {} {
	global ns TraceFile NamFile
	$ns flush-trace
	close $TraceFile
#	close $nf
	exec nam sctp.nam &
	exit 0
}

$ns at 55.0 "finish"
$ns run

