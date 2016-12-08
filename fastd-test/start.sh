# usage: start <my_ip> <my_number>

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

fastd -d -c fastd.conf
