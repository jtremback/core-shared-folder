dev=$1
handle=$2
weight=$3

# Get traffic with a certain fw mark and direct it to the corresponding QFQ class
tc filter add dev $dev parent 1: protocol ip prio 1 handle $handle fw classid 1:$handle
tc class add dev $dev parent 1: classid 1:$handle qfq weight $weight maxpkt 2048

# This acts to actually drop traffic, making DRR take effect
# tc qdisc add dev $dev parent 2:$handle sfq perturb 120 limit 1024

tc -s class show dev $dev
tc -s filter show dev $dev