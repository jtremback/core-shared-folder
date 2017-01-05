dev=$1
handle=$2
weight=$3

tc class change dev $dev parent 1: classid 1:$handle qfq weight $weight maxpkt 2048
