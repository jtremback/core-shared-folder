dev=$1
handle=$2
quantum=$3

# Get traffic with a certain fw mark and direct it to the corresponding DRR class
tc filter add dev $dev parent 2: protocol ip prio 1 handle $handle fw classid 2:$handle
tc class add dev $dev parent 2: classid 2:$handle drr quantum $quantum

# This acts to actually drop traffic, making DRR take effect
tc qdisc add dev $dev parent 2:$handle fq_codel

tc -s class show dev $dev
tc -s filter show dev $dev