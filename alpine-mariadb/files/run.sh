#!/bin/sh

VOLUME_HOME="/var/lib/mysql"

if [[ ! -d $VOLUME_HOME/mysql ]]; then
    echo "=> An empty or uninitialized MariaDB volume is detected in $VOLUME_HOME"
    echo "=> Installing MariaDB ..."
    mysql_install_db > /dev/null 2>&1
    chown -R mysql:mysql $VOLUME_HOME
    chmod -R 755 $VOLUME_HOME
    echo "=> Done!"  
    sh mariadb_init.sh
else
    echo "=> Using an existing volume of MariaDB"
fi

echo "=> Starting MySQL"  
exec mysqld_safe