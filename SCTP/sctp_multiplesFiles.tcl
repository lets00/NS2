set ns [new Simulator]

$ns color 1 Blue
$ns color 2 Red

set nf [open sctpMultiplesFiles.nam w]
$ns namtrace-all $nf

set TraceFile [open sctpMultiplesFiles.tr w]
$ns trace-all $TraceFile

#Create 4 nodes

set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]

$ns duplex-link $n0 $n1 400Kb 80ms DropTail
$ns duplex-link $n1 $n2 40kb 80ms DropTail
$ns queue-limit $n1 $n2 20

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
$ns at 0.2 "$ftp1 send 52428800"
$ns at 0.3 "$ftp1 send 1024"
$ns at 50.0 "$ftp1 stop"
 
proc finish {} {
	global ns TraceFile NamFile
	$ns flush-trace
	close $TraceFile
#	close $nf
	exec nam sctpMultiplesFiles &
	exit 0
}

$ns at 55.0 "finish"

#Run
$ns run


