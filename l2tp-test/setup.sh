a=$1

shift
for var in "$@"
do

ip route add 10.0.0.$var dev eth0

ip l2tp add tunnel tunnel_id $a$var peer_tunnel_id $var$a encap udp local 10.0.0.$a remote 10.0.0.$var udp_sport 50$a$var udp_dport 50$var$a

ip l2tp add session name l2tp$a$var tunnel_id $a$var session_id $a$var peer_session_id $var$a

ip link set up l2tp$a$var

ip addr add 10.0.1.$a dev l2tp$a$var

ip route add 10.0.1.$var dev l2tp$a$var

done
