#!/bin/bash

pacman -Syy --noconfirm
pacman -S mariadb shadow --noconfirm

groupadd mysql
useradd -r -g mysql mysql

mysql_install_db --user=mysql --basedir=/usr --datadir=/docker/data/mariadb
mkdir -p /run/mysqld/
mysqld_safe --datadir='/docker/data/mariadb' --user=mysql &
mysqladmin -u root password '123456'
mysql -uroot -p123456 --database=mysql -e"GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '123456' WITH GRANT OPTION;"

pacman -Rs shadow --noconfirm
rm -rf /var/cache/pacman/pkg
rm -rf /var/lib/pacman/sync

cd /etc/mysql/
rm my.cnf
ln -s /docker/config/mariadb/my.cnf
mkdir -p /run/mysqld/
chown -R mysql:mysql /run/mysqld/

cat <<EOT > /usr/bin/mariadb-entrypoint
#!/bin/bash

chown -R mysql:mysql /docker/data/mariadb
mysqld --datadir='/docker/data/mariadb' --user=mysql
EOT

chmod +x /usr/bin/mariadb-entrypoint

rm /build.sh