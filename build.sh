#!/bin/bash

pacman -Syy --noconfirm
pacman -S mariadb shadow --noconfirm

echo "127.0.0.1       localhost" >> /etc/hosts
echo "::1             localhost" >> /etc/hosts

groupadd users
groupadd mysql
useradd -r -g mysql -s /bin/false mysql

mkdir -p /run/mysqld/
chown -R mysql:mysql /run/mysqld/

# mysql_install_db --user=mysql --basedir=/usr --datadir=/docker/data/mariadb

# mysqld_safe --datadir='/docker/data/mariadb' --user=mysql &
# mysqladmin -u root password '123456'
# mysql -uroot -p123456 --database=mysql -e"GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '123456' WITH GRANT OPTION;"

rm -rf /var/cache/pacman/pkg
rm -rf /var/lib/pacman/sync

cd /etc/
rm my.cnf
ln -s /docker/config/mariadb/my.cnf

cat <<EOT > /usr/bin/maria
#!/bin/bash

chown -R mysql:mysql /docker/data/mariadb
mysqld --datadir='/docker/data/mariadb' --user=mysql
EOT

chmod +x /usr/bin/maria

rm /build.sh
