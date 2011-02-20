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

mysqladmin -uroot $MYSQL_ROOT_PASSWORD drop $dbname
mysqladmin -uroot $MYSQL_ROOT_PASSWORD --force drop $dbname_test
mysqladmin -uroot $MYSQL_ROOT_PASSWORD create $dbname
mysqladmin -uroot $MYSQL_ROOT_PASSWORD create $dbname_test
echo "$dbname created"

echo "grant all on $dbname.* to '$dbuser'@localhost identified by '$dbpassword';" \
     | mysql -uroot $MYSQL_ROOT_PASSWORD $dbname
echo "grant all on $dbname_test.* to '$dbuser'@localhost identified by '$dbpassword';" \
      | mysql -uroot $MYSQL_ROOT_PASSWORD $dbname_test
echo "$dbuser authorized"

cat $src/???_*.sql | mysql -u$dbuser -p$dbpassword $dbname 
cat $src/???_*.sql | mysql -u$dbuser -p$dbpassword $dbname_test 
echo "schema loaded"

cat $src/initial_dump.sql | mysql -u$dbuser -p$dbpassword $dbname 
echo "database populated"