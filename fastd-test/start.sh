#!/bin/sh
# usage: start <my_number> <my_tunnel_ip>

touch fastd.conf
echo \
'
bind any:1234; # UDP Port 1234 auf allen Interfaces
mode multitap;
method "xsalsa20-poly1305"; # Verschlüsselungsalgorithmus festlegen
mtu 1426;
secret "'$(cat /home/jehan2/host/fastd-test/privatekey$1)'";

include peers from "peers";

on up "
  ip link set up $INTERFACE
  ip addr add '$2' dev $INTERFACE
  echo interface $INTERFACE | nc ::1 8481
";
' > fastd.conf

fastd -d -c fastd.conf
