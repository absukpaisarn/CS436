#Create a simulator object
set ns [new Simulator]

#Tell the simulator to use dynamic routing
$ns rtproto DV

#Create a trace file
set tracefd [open project1.tr w]
$ns trace-all $tracefd

#Define a 'finish' procedure
proc finish {} {
        global ns nf
        
        $ns flush-trace
 #Close the trace file
 #       close $nf

        exit 0
}

#Create 17 nodes
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]
set n6 [$ns node]
set n7 [$ns node]
set n8 [$ns node]
set n9 [$ns node]
set n10 [$ns node]
set n11 [$ns node]
set n12 [$ns node]
set n13 [$ns node]
set n14 [$ns node]
set n15 [$ns node]
set n16 [$ns node]
set n17 [$ns node]


#Create duplex - links between the nodes
#Yellowlinks
$ns duplex-link $n8 $n0 1Mb 20ms DropTail
$ns duplex-link $n9 $n1 1Mb 20ms DropTail

$ns duplex-link $n5 $n10 1Mb 20ms DropTail
$ns duplex-link $n5 $n11 1Mb 20ms DropTail
$ns duplex-link $n5 $n12 1Mb 20ms DropTail
$ns duplex-link $n5 $n13 1Mb 20ms DropTail

$ns duplex-link $n6 $n14 1Mb 20ms DropTail
$ns duplex-link $n6 $n15 1Mb 20ms DropTail

$ns duplex-link $n7 $n16 1Mb 20ms DropTail
$ns duplex-link $n7 $n17 1Mb 20ms DropTail

#Purple links
$ns duplex-link $n0 $n2 2Mb 40ms DropTail
$ns duplex-link $n1 $n2 2Mb 40ms DropTail
$ns duplex-link $n3 $n5 2Mb 40ms DropTail
$ns duplex-link $n4 $n6 2Mb 40ms DropTail
$ns duplex-link $n4 $n7 2Mb 40ms DropTail

#Black links
$ns duplex-link $n2 $n3 8Mb 100ms DropTail
$ns duplex-link $n3 $n4 8Mb 100ms DropTail
$ns duplex-link $n4 $n2 8Mb 100ms DropTail

#set queue size of links
#yellow queue
$ns queue-limit $n8 $n0 20
$ns queue-limit $n9 $n1 20

$ns queue-limit $n5 $n10 20
$ns queue-limit $n5 $n11 20
$ns queue-limit $n5 $n12 20
$ns queue-limit $n5 $n13 20

$ns queue-limit $n6 $n14 20
$ns queue-limit $n6 $n15 20

$ns queue-limit $n7 $n16 20
$ns queue-limit $n7 $n17 20

#Purple queue
$ns queue-limit $n0 $n2 25
$ns queue-limit $n1 $n2 25
$ns queue-limit $n3 $n5 25
$ns queue-limit $n4 $n6 25
$ns queue-limit $n4 $n7 25

#Black queue
$ns queue-limit $n2 $n3 30 
$ns queue-limit $n3 $n4 30
$ns queue-limit $n4 $n2 30

#Create a UDP agent for each traffic source
# 8  / RED
set tcp10 [new Agent/TCP]
set tcp11 [new Agent/TCP]
set tcp14 [new Agent/TCP]
set tcp16 [new Agent/TCP]
$ns attach-agent $n8 $tcp10
$ns attach-agent $n8 $tcp11
$ns attach-agent $n8 $tcp14
$ns attach-agent $n8 $tcp16

# 9 / BLUE
set udp12 [new Agent/UDP]
set udp13 [new Agent/UDP]
set udp15 [new Agent/UDP]
set udp17 [new Agent/UDP]
$ns attach-agent $n9 $udp12
$ns attach-agent $n9 $udp13
$ns attach-agent $n9 $udp15
$ns attach-agent $n9 $udp17

#Set flow id for each traffic
# 8 / RED
$tcp10 set fid_ 10
$tcp11 set fid_ 11
$tcp14 set fid_ 14
$tcp16 set fid_ 16

# 9 / BLUE
$udp12 set fid_ 12
$udp13 set fid_ 13
$udp15 set fid_ 15
$udp17 set fid_ 17

# Create a CBR generators for each traffic source
# 8 / RED
set cbr10 [new Application/Traffic/CBR]
$cbr10 set packetSize_ 1000
$cbr10 set interval_ 0.005
$cbr10 set random_ 1
$cbr10 attach-agent $tcp10

set cbr11 [new Application/Traffic/CBR]
$cbr11 set packetSize_ 3000
$cbr11 set interval_ 0.005
$cbr11 set random_ 1
$cbr11 attach-agent $tcp11

set cbr14 [new Application/Traffic/CBR]
$cbr14 set packetSize_ 2000
$cbr14 set interval_ 0.005
$cbr14 set random_ 1
$cbr14 attach-agent $tcp14

set cbr16 [new Application/Traffic/CBR]
$cbr16 set packetSize_ 2000
$cbr16 set interval_ 0.005
$cbr16 set random_ 1
$cbr16 attach-agent $tcp16

# 9 / BLUE
set cbr12 [new Application/Traffic/CBR]
$cbr12 set packetSize_ 1000
$cbr12 set interval_ 0.005
$cbr12 set random_ 1
$cbr12 attach-agent $udp12

set cbr13 [new Application/Traffic/CBR]
$cbr13 set packetSize_ 3000
$cbr13 set interval_ 0.005
$cbr13 set random_ 1
$cbr13 attach-agent $udp13

set cbr15 [new Application/Traffic/CBR]
$cbr15 set packetSize_ 2000
$cbr15 set interval_ 0.005
$cbr15 set random_ 1
$cbr15 attach-agent $udp15

set cbr17 [new Application/Traffic/CBR]
$cbr17 set packetSize_ 2000
$cbr17 set interval_ 0.005
$cbr17 set random_ 1
$cbr17 attach-agent $udp17

#Create a traffic sink for each source
# 8 / RED
set sink10 [new Agent/LossMonitor]
set sink11 [new Agent/LossMonitor]
set sink14 [new Agent/LossMonitor]
set sink16 [new Agent/LossMonitor]
$ns attach-agent $n10 $sink10
$ns attach-agent $n11 $sink11
$ns attach-agent $n14 $sink14
$ns attach-agent $n16 $sink16

# 9 / BLUE
set sink12 [new Agent/LossMonitor]
set sink13 [new Agent/LossMonitor]
set sink15 [new Agent/LossMonitor]
set sink17 [new Agent/LossMonitor]
$ns attach-agent $n12 $sink12
$ns attach-agent $n13 $sink13
$ns attach-agent $n15 $sink15
$ns attach-agent $n17 $sink17

#Connect the traffic sources to the traffic sinks
# 8 / RED
$ns connect $tcp10 $sink10
$ns connect $tcp11 $sink11
$ns connect $tcp14 $sink14
$ns connect $tcp16 $sink16

# 9 / BLUE
$ns connect $udp12 $sink12
$ns connect $udp13 $sink13
$ns connect $udp15 $sink15
$ns connect $udp17 $sink17

#Schedule events for the CBR agent and the network dynamics
$ns at 1 "$cbr10 start"
$ns at 1 "$cbr11 start"
$ns at 1 "$cbr14 start"
$ns at 1 "$cbr16 start"

$ns at 2 "$cbr12 start"
$ns at 2 "$cbr13 start"
$ns at 2 "$cbr15 start"
$ns at 2 "$cbr17 start"

$ns rtmodel-at 6.0 down $n2 $n3
$ns rtmodel-at 7.0 up $n2 $n3


#Call the finish procedure after 5 seconds of simulation time
$ns at 10.0 "finish"

#Run the simulation
$ns run
