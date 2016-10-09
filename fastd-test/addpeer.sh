# usage: addpeer <ip> <iface> <peer>

mkdir -p peers

ip=$1
iface=$2
peer=$3

touch peers/peer$peer
echo '
key "'$(< /home/jehan2/host/fastd-test/publickey$peer)'";
remote "'$ip'" port 1234;
' > peers/peer$peer

ip route add $ip dev $iface
