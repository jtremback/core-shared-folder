setkey -c <<< 'flush;'
setkey -c <<< 'spdflush;'

a=$1

shift
for var in "$@"
do

echo 'add 10.0.0.'$a' 10.0.0.'$var' ah 10'$a$var' -A hmac-md5 "1234567890123456";' | setkey -c

echo 'add 10.0.0.'$var' 10.0.0.'$a' ah 10'$var$a' -A hmac-md5 "1234567890123456";' | setkey -c

echo 'spdadd 10.0.0.'$a' 10.0.0.'$var' any -P out ipsec ah/transport//require;' | setkey -c

echo 'spdadd 10.0.0.'$var' 10.0.0.'$a' any -P in ipsec ah/transport//require;' | setkey -c

ip route add 10.0.0.$var dev eth0

done