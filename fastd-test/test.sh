peer_number=$1
peer_ip=$2
peer_iface=$3

echo '
key "'$(cat /home/jehan2/host/fastd-test/publickey$1)'";
remote "'$peer_ip'" port 1234;
'