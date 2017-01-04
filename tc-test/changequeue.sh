dev=$1
handle=$2
quantum=$3

tc class change dev $dev parent 2: classid 2:$handle drr quantum $quantum
