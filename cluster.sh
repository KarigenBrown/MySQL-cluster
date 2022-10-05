#/bin/bash
docker network create mysql-cluster --subnet 192.168.127.0/24

docker run -it -d -p 3307:3306 --name mysql-master -v `pwd`/master/cnf:/etc/mysql/conf.d -v `pwd`/master/data:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=123456 --network mysql-cluster mysql:8
docker run -it -d -p 3308:3306 --name mysql-slave-1 -v `pwd`/slave-1/cnf:/etc/mysql/conf.d -v `pwd`/slave-1/data:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=123456 --network mysql-cluster mysql:8
docker run -it -d -p 3309:3306 --name mysql-slave-2 -v `pwd`/slave-2/cnf:/etc/mysql/conf.d -v `pwd`/slave-2/data:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=123456 --network mysql-cluster mysql:8