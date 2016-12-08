# Does it all. deprecated.

# nft add table inet althea
# nft add chain inet althea

# usage: command 1 10.0.0. 2 3

touch fastd.conf
echo \
'
bind any:1234; # UDP Port 1234 auf allen Interfaces
mode tap;
method "xsalsa20-poly1305"; # Verschlüsselungsalgorithmus festlegen
mtu 1426;
secret "'$(< /home/jehan2/host/fastd-test/privatekey$1)'";

include peers from "peers";

on up "
  ip link set up $INTERFACE
  ip addr add 11.0.0.'$1' dev $INTERFACE
  echo interface $INTERFACE | nc ::1 8481
";
' > fastd.conf

mkdir peers

b=$2

shift
shift
for var in "$@"
do

touch peers/peer$var
echo '
key "'$(< /home/jehan2/host/fastd-test/publickey$var)'";
remote "'$b$var'" port 1234;
' > peers/peer$var

ip route add $b$var dev eth0

done

fastd -d -c fastd.conf