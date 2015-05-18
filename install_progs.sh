#!/bin/bash
sudo yum install -y wget zsh mtr nano vim git ctags
wget http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.3-1.el6.rf.x86_64.rpm
rpm -Uhv rpmforge-release*.rf.x86_64.rpm

sudo yum install -y nano htop tmux mc pwgen

git clone https://github.com/amix/vimrc.git ~/.vim_runtime
sh ~/.vim_runtime/install_awesome_vimrc.sh
git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
cp ~/.zshrc ~/.zshrc.orig
cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
chsh -s /bin/zsh
curl -O https://raw.githubusercontent.com/parotikov/firstvds-vesta/master/nik.zsh-theme
mv nik.zsh-theme ~/.oh-my-zsh/themes
sed -i 's/^ZSH_THEME="robbyrussell".*/ZSH_THEME="nik"/g' ~/.zshrc 

useradd nik -c 'Nik Parotikov' -s /bin/zsh -g wheel

curl -O https://raw.githubusercontent.com/parotikov/firstvds-vesta/master/.tmux.conf
echo 'alias tmux="tmux attach || tmux new"' >> ~/.zshrc

#/usr/local/vesta/bin/v-stop-service named
#/usr/local/vesta/bin/v-stop-service dovecot
#/usr/local/vesta/bin/v-stop-service nginx

#chkconfig named off
#chkconfig dovecot off
#chkconfig nginx off

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
sed -i '/\$domain\/private/d' /usr/local/vesta/bin/v-add-web-domain
sed -i '/\$domain\/cgi-bin/d' /usr/local/vesta/bin/v-add-web-domain
sed -i '/\$domain\/public_shtml/d' /usr/local/vesta/bin/v-add-web-domain

#sed -i '/cp.*public_shtml/d' /usr/local/vesta/bin/v-add-web-domain
#sed -i '/cp.*cgi-bin/d' /usr/local/vesta/bin/v-add-web-domain

#sed -i '/public_shtml/d' /usr/local/vesta/bin/v-add-web-domain
#sed -i '/cgi-bin/d' /usr/local/vesta/bin/v-add-web-domain

#sed -i '/cp.*public_shtml.*$/,+2d' /usr/local/vesta/bin/v-add-web-domain
#sed -i '/cp.*cgi-bin.*$/,+2d' /usr/local/vesta/bin/v-add-web-domain
#sed -i '$!N; /^\(.*\)\n\1$/d' /usr/local/vesta/bin/v-add-web-domain

#disable phpmyadmin and install adminer instead
rm /etc/httpd/conf.d/phpMyAdmin.conf*
wget http://adminer.org/latest.php
mkdir /usr/share/adminer/
cp latest.php /usr/share/adminer/index.php
curl -O https://raw.githubusercontent.com/parotikov/firstvds-vesta/master/adminer.conf
mv adminer.conf /etc/httpd/conf.d
service httpd restart

#disable webmail alias
mv /etc/httpd/conf.d/roundcubemail.conf /etc/httpd/conf.d/roundcubemail.conf.orig

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
sudo mv wp-cli.phar /usr/local/bin/wp

curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer

curl -O https://raw.githubusercontent.com/parotikov/firstvds-vesta/master/watcher.sh
chmod +x ./watcher.sh

curl -O https://raw.githubusercontent.com/parotikov/firstvds-vesta/master/yandex.repo
mv yandex.repo /etc/yum.repos.d/yandex.repo
rpm --import http://repo.yandex.ru/yandex-disk/YANDEX-DISK-KEY.GPG
yum install -y yandex-disk
echo "yandex-disk start" >> /etc/rc.local
yandex-disk setup
yandex-disk start

#change ssh port
#sed -i 's/^.*Port .*/Port 39001/g' /etc/ssh/sshd_config
#and disable root login
#sed -i 's/^PermitRootLogin.*/PermitRootLogin no/g' /etc/ssh/sshd_config
#apply changes
#service sshd restart
