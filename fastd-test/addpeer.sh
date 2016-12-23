# usage: addpeer <peer_number> <peer_ip> <peer_iface>

mkdir -p peers

peer_number=$1
peer_ip=$2
peer_iface=$3

touch peers/peer$peer_number
echo '
key "'$(cat /home/jehan2/host/fastd-test/publickey$peer_number)'";
remote "'$peer_ip'" port 1234;
' > peers/peer$peer_number

ip route add $peer_ip dev $peer_iface
