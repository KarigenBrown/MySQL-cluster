change master to master_host="mysql-master",master_user='reader',master_password='reader',master_log_file='mysql-bin.000003',master_log_pos=829;
reset slave;
start slave;