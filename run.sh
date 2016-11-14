#!/bin/bash

CFG_JANUS='/root/janus/etc/janus/janus.cfg'
sed 's/; broadcast = yes/broadcast = yes/1' -i $CFG_JANUS

sed 's/;turn_server = myturnserver.com/turn_server = turn.webrtc.24sessions.com/1' -i $CFG_JANUS
sed 's/;turn_port = 3478/turn_port = 3478/1' -i $CFG_JANUS
sed 's/;turn_type = udp/turn_type = udp/1' -i $CFG_JANUS
sed 's/;turn_user = myuser/turn_user = videolink2me/1' -i $CFG_JANUS
sed 's/;turn_pwd = mypassword/turn_pwd = j@ds!k2jShq2/1' -i $CFG_JANUS

CFG_HTTPS='/root/janus/etc/janus/janus.transport.http.cfg'
sed 's/https = no/https = yes/1' -i $CFG_HTTPS
sed 's/;secure_port = 8089/secure_port = 443/1' -i $CFG_HTTPS

# Configure websockets
CFG_WS='/root/janus/etc/janus/janus.transport.websockets.cfg'
sed 's/wss = no/wss = yes/1' -i $CFG_WS
sed 's/;wss_port = 8989/wss_port = 8989/1' -i $CFG_WS

# Configure certs
sed 's/cert_pem = \/root\/janus\/share\/janus\/certs\/mycert.pem/cert_pem = \/root\/janus\/certs\/janus.pem/1' -i $CFG_HTTPS
sed 's/cert_key = \/root\/janus\/share\/janus\/certs\/mycert.key/cert_key = \/root\/janus\/certs\/janus.key/1' -i $CFG_HTTPS

sed 's/cert_pem = \/root\/janus\/share\/janus\/certs\/mycert.pem/cert_pem = \/root\/janus\/certs\/janus.pem/1' -i $CFG_WS
sed 's/cert_key = \/root\/janus\/share\/janus\/certs\/mycert.key/cert_key = \/root\/janus\/certs\/janus.key/1' -i $CFG_WS

# Start Janus Gateway
/root/janus/bin/janus --stun-server=stun.l.google.com:19302 -L /var/log/meetecho --rtp-port-range=10000-10200
tail -f /var/log/meetecho

