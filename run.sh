#!/bin/bash

CFG_JANUS='/root/janus/etc/janus/janus.cfg'
sed 's/; broadcast = yes/broadcast = yes/1' -i $CFG_JANUS
CFG_HTTPS='/root/janus/etc/janus/janus.transport.http.cfg'
sed 's/https = no/https = yes/1' -i $CFG_HTTPS
sed 's/;secure_port = 8889/secure_port = 8889/1' -i $CFG_HTTPS

# Generate Certs
openssl req -x509 -newkey rsa:4086 \
  -subj "/C=XX/ST=XXXX/L=XXXX/O=XXXX/CN=localhost" \
  -keyout "/usr/share/key.pem" \
  -out "/usr/share/cert.pem" \
  -days 3650 -nodes -sha256

# Start Janus Gateway
/root/janus/bin/janus --stun-server=stun.l.google.com:19302 -L /var/log/meetecho --rtp-port-range=10000-10200
tail -f /var/log/meetecho

