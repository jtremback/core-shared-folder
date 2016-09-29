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
";
' > fastd.conf

mkdir peers

shift
for var in "$@"
do

touch peers/peer$var
echo '
key "'$(< /home/jehan2/host/fastd-test/publickey$var)'";
remote "10.0.0.'$var'" port 1234;
' > peers/peer$var

ip route add 10.0.0.$var dev eth0
done

fastd -c fastd.conf