dev=$1

# Remove root qdisc
tc qdisc del dev $dev root

# Add root qfq qdisc
tc qdisc add dev $dev root handle 1: qfq

# Add default class
tc class add dev $dev parent 1: classid 1:1 qfq weight 1 maxpkt 2048

# Send traffic to default class
tc filter add dev $dev parent 1: protocol all prio 2 u32 match u32 0 0 classid 1:1

tc -s class show dev $dev
tc -s filter show dev $dev