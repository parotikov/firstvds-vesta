#!/bin/bash
echo "nameserver 8.8.8.8" > /etc/resolv.conf
sudo yum remove mysql-server* bind* exim* proftpd* *httpd*
curl -O http://vestacp.com/pub/vst-install.sh
bash vst-install.sh
