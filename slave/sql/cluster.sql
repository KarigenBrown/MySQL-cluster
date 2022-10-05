GRANT ALL PRIVILEGES ON *.* TO 'reader'@'%';
flush privileges;
change master to master_host="mysql-master",master_user='reader',master_password='reader',master_log_file='mysql-bin.000010',master_log_pos=1503;
reset slave;
start slave;