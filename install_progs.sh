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

curl -O https://raw.githubusercontent.com/parotikov/firstvds-vesta/master/my.cnf
cp /etc/my.cnf /etc/my.cnf.old
mv my.cnf /etc/my.cnf

# remove preloaded packages
v-delete-user-package palegreen
v-delete-user-package gainsboro
v-delete-user-package slategrey

# change package for admin
v-change-user-package admin default

# remove default.domain for admin
v-delete-domain admin default.domain

#remove unused directories from template
sed -i '/\$domain\/public_shtml/d' /usr/local/vesta/bin/v-add-web-domain
sed -i '/\$domain\/private/d' /usr/local/vesta/bin/v-add-web-domain
sed -i '/\$domain\/cgi-bin/d' /usr/local/vesta/bin/v-add-web-domain

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
sudo mv wp-cli.phar /usr/local/bin/wp
