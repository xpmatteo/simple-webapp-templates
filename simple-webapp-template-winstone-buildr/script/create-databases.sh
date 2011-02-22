#!/bin/bash

# define key information
src=src/main/sql
dbname=xxx_development
dbname_test=xxx_test
dbuser=xxx
dbpassword=xxx

# no customization needed beyond this line
cd "$(dirname $0)/.."
read -s -p "mysql root password? (type return for no password) " MYSQL_ROOT_PASSWORD

if [ "$MYSQL_ROOT_PASSWORD" != "" ]; then
    MYSQL_ROOT_PASSWORD=-p$MYSQL_ROOT_PASSWORD
fi

function do_admin() {
  mysqladmin -uroot $MYSQL_ROOT_PASSWORD $*
}

function do_mysql() { 
  mysql -uroot $MYSQL_ROOT_PASSWORD $2
}

do_admin drop $dbname
do_admin --force drop $dbname_test
do_admin create $dbname
do_admin create $dbname_test
echo "$dbname created"

echo "grant all on $dbname.* to '$dbuser'@localhost identified by '$dbpassword';" | do_mysql
echo "grant all on $dbname_test.* to '$dbuser'@localhost identified by '$dbpassword';" | do_mysql 
echo "$dbuser authorized"

cat $src/???_*.sql | mysql -u$dbuser -p$dbpassword $dbname 
cat $src/???_*.sql | mysql -u$dbuser -p$dbpassword $dbname_test 
echo "schema loaded"

