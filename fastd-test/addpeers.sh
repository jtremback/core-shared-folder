# usage: addpeers <subnet> <peers...>

mkdir -p peers

subnet=$1

shift
for peer in "$@"
do

touch peers/peer$peer
echo '
key "'$(< /home/jehan2/host/fastd-test/publickey$peer)'";
remote "'$subnet$peer'" port 1234;
' > peers/peer$peer

ip route add $subnet$peer dev eth0

done