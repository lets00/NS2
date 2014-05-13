set ns [new Simulator]

$ns color 1 Blue
$ns color 2 Red

set nf [open sctpMultiplesFiles400Kbps10Mbps.nam w]
$ns namtrace-all $nf

set TraceFile [open sctpMultiplesFiles400Kbps10Mbps.tr w]
$ns trace-all $TraceFile

#Create 4 nodes

set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]

$ns duplex-link $n0 $n1 10Mb 80ms DropTail
$ns duplex-link $n1 $n2 400Kb 80ms DropTail
#$ns queue-limit $n1 $n2 20

#SCTP
set sctp0 [new Agent/SCTP]
$sctp0 set fid_ 1
$ns attach-agent $n0 $sctp0

set sctp1 [new Agent/SCTP]
$ns attach-agent $n2 $sctp1
$ns connect $sctp0 $sctp1

#$ftp

set ftp1 [new Application/FTP]
$ftp1 attach-agent $sctp0

$ns at 0.1 "$ftp1 start"
$ns at 0.2 "$ftp1 send 102400"
$ns at 0.3 "$ftp1 send 204800"
#32.98328ms
 
proc finish {} {
	global ns TraceFile NamFile
	$ns flush-trace
	close $TraceFile
#	close $nf
	exec nam sctpMultiplesFiles400Kbps10Mbps &
	exit 0
}

$ns at 100.0 "finish"

#Run
$ns run


