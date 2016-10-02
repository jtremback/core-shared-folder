echo 'spdadd 0.0.0.0/0 0.0.0.0/0 any -P out ipsec ah/transport//require;' | setkey -c
echo 'spdadd 0.0.0.0/0 0.0.0.0/0 any -P in ipsec ah/transport//require;' | setkey -c