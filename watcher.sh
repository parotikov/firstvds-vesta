#!/usr/bin/env bash
# функция вызова проверки и перезапуска служб сервера
check_srv()
{
   s1=$1
   /usr/bin/pgrep $s1 &>/dev/null

   s2=$?
   if [ $s2 -ne 0 ]; then
      if [ X"$s1" == X"mysqld" ]; then
      s1='mysql'
   fi
      service $s1 restart &>/dev/null
      echo "---------------------------------------------------------------"  >> /root/service_up.log
      echo "Служба $s1 был перезапущена в `date`"  >> /root/service_up.log
      echo -e "---------------------------------------------------------------\n"  >> /root/service_up.log
   fi
};

# "Проверяем apache2"
check_srv httpd

# "Проверяем MySQL"
check_srv mysqld
