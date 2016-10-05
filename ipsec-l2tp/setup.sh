echo 'spdadd 0.0.0.0/0 0.0.0.0/0 any -P out discard;' | setkey -c
echo 'spdadd 0.0.0.0/0 0.0.0.0/0 any -P in discard;' | setkey -c

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

echo 'spdadd 10.0.0.'$a' 10.0.0.'$var' any -P out ipsec ah/transport//require;' | setkey -c
echo 'spdadd 10.0.0.'$var' 10.0.0.'$a' any -P in ipsec ah/transport//require;' | setkey -c

echo 'add 10.0.0.'$a' 10.0.0.'$var' ah 10'$a$var' -A hmac-md5 "1234567890123456";' | setkey -c
echo 'add 10.0.0.'$var' 10.0.0.'$a' ah 10'$var$a' -A hmac-md5 "1234567890123456";' | setkey -c

# echo 'add 10.0.1.'$a' 10.0.1.'$var' ah 10'$a$var' -A hmac-md5 "1234567890123456";' | setkey -c
# echo 'add 10.0.1.'$var' 10.0.1.'$a' ah 10'$var$a' -A hmac-md5 "1234567890123456";' | setkey -c

done
