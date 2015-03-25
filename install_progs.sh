#!/bin/bash
echo "nameserver 8.8.8.8" > /etc/resolv.conf
sudo yum remove mysql-server* bind* exim* proftpd* *httpd*
curl -O http://vestacp.com/pub/vst-install.sh
bash vst-install.sh
sudo yum install zsh mtr nano vim htop git composer ctags
git clone https://github.com/amix/vimrc.git ~/.vim_runtime
sh ~/.vim_runtime/install_awesome_vimrc.sh
git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
cp ~/.zshrc ~/.zshrc.orig
cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
chsh -s /bin/zsh

/usr/local/vesta/bin/v-stop-service named
/usr/local/vesta/bin/v-stop-service dovecot
/usr/local/vesta/bin/v-stop-service nginx

chkconfig named off
chkconfig dovecot off
chkconfig nginx off
