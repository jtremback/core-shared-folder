echo 'flush;' | setkey -c
echo 'spdflush;' | setkey -c

echo 'spdadd 0.0.0.0/0 0.0.0.0/0 any -P out ipsec ah/transport//require;' | setkey -c
echo 'spdadd 0.0.0.0/0 0.0.0.0/0 any -P in ipsec ah/transport//require;' | setkey -c

a=$1

shift
for var in "$@"
do

echo 'add 10.0.0.'$a' 10.0.0.'$var' ah 10'$a$var' -A hmac-md5 "1234567890123456";' | setkey -c

echo 'add 10.0.0.'$var' 10.0.0.'$a' ah 10'$var$a' -A hmac-md5 "1234567890123456";' | setkey -c

done