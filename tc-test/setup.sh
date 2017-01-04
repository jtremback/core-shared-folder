dev=$1

# Remove root qdisc
tc qdisc del dev $dev handle 1 root

# Add root shaping qdisc and class
tc qdisc add dev $dev root handle 1: htb
tc class add dev $dev parent 1: classid 1:1 htb rate 10mbit ceil 10mbit

# Add root drr qdisc
tc qdisc add dev $dev handle 2: parent 1:1 drr

# Add default class
tc class add dev $dev parent 2: classid 2:1 drr

# Send traffic to default class
tc filter add dev $dev parent 1: protocol all prio 2 u32 match u32 0 0 classid 1:1
tc filter add dev $dev parent 2: protocol all prio 2 u32 match u32 0 0 classid 2:1

tc -s class show dev $dev
tc -s filter show dev $dev