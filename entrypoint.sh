#!/bin/bash
#########################################################################
# File Name: frps.sh
# Version:1.3.20180615
# Created Time: 2018-06-15
#########################################################################

set -e
FRPS_BIN="/usr/local/frps/frps"
FRPS_CONF="/usr/local/frps/frps.ini"
FRPS_LOG="/var/log/frps.log"
# ======= FRPS CONFIG ======

[ ! -f ${FRPS_CONF} ] && cat > ${FRPS_CONF}<<-EOF
# [common] is integral section
[common]
# A literal address or host name for IPv6 must be enclosed
# in square brackets, as in "[::1]:80", "[ipv6-host]:http" or "[ipv6-host%zone]:80"
bind_addr = 0.0.0.0
bind_port = 5443
EOF

echo "+---------------------------------------------+"
echo "|              Frps On Docker                 |"
echo "+---------------------------------------------+"
echo "|       Images:{frps-docker:latest}           |"
echo "+---------------------------------------------+"
echo "|     Intro: https://github.com/clangcn       |"
echo "+---------------------------------------------+"
echo "+---------------------------------------------+"
rm -f ${FRPS_LOG} > /dev/null 2>&1
echo "Starting frps $(${FRPS_BIN} -v) ..."
${FRPS_BIN} -c ${FRPS_CONF} &
sleep 0.3
netstat -ntlup | grep "frps"
exec "tail" -f ${FRPS_LOG}
