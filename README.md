<!--
 * @Author: Karigen B
 * @Date: 2022-10-03 19:15:47
 * @LastEditors: Karigen B
 * @LastEditTime: 2022-10-09 10:47:34
 * @Description: 
 * @FilePath: \undefinedd:\CodeSpace\SQLSpace\MySQL-cluster\README.md
-->

# MySQL-cluster

- 部署步骤:
  1. 由于可能存在网络问题,所以先看 [@java赵先生](https://blog.csdn.net/weixin_53974140/article/details/122959471) 的这篇博客
  2. cd到docker-compose.yml所在的目录,执行`docker-compose up -d`(可能会出现权限问题,以管理员权限cd,运行即可),等待容器初始化完毕
  3. 执行`docker exec -it mysql-master /bin/bash`,再执行`mysql -uroot -p123456 < cluster.sql`
  4. 此时会将File和Position打印出来,例如:![](images/master.png)将这两个值在 ==./slave/sql/cluster.sql== ( ==master_log_file='mysql-bin.000003',master_log_pos=829== ,这两个)中修改一下,因为是在容器中运行的缘故,所以如果完全参照作者的步骤执行命令,MySQL的日志系统到目前为止的参数和作者预留的参数一致
  5. 执行`docker exec -it mysql-slave-1 /bin/bash`,再执行`mysql -uroot -p123456 < cluster.sql`
  6. 执行`docker exec -it mysql-slave-2 /bin/bash`,再执行`mysql -uroot -p123456 < cluster.sql`
  7. 集群部署完毕
  8. 集群停止命令:cd到docker-compose.yml所在的目录,执行`docker-compose stop`
  9. 集群删除命令:cd到docker-compose.yml所在的目录,执行`docker-compose down -v`

- 项目结构
  - MySQL一主二从集群,通过Nginx做从服务器的负载均衡
  - MySQL主服务器端口映射到宿主机3307端口
  - Nginx端口映射到宿主机3308端口

**注意**:
  - 集群中所有节点的root密码都是123456,可以自行从cluster.env中修改
  - 由于在Windows中所有的文件权限都是777,所以在执行命令的时候由于Windows文件权限太低,MySQL会忽略my.cnf文件,所以**不要在Windows环境(特指Windows文件系统,总之不能跟Windows沾边)中运行**
  - 因为一般MySQL集群的负载均衡仅限于从服务器用于读,所以在本项目中就只做了从服务器的负载均衡
  - 用于只用了从服务器做的做的读操作负载均衡,且是用docker-compose做的,所以一般也容器之间的性能页不会有太大的差别,所以Nginx负载均衡策略采用默认的轮询策略
  - **由于作者有项目洁癖**,每个MySQL节点才执行一条命令,所以作者是不回去打镜像的,所以就依次执行命令吧;云计算的Web客户端同理

本项目专门为**北京邮电大学2020级软件工程数据库课设&&云计算第二次实验**准备

--by Karigen(**学二507地位最高的男人**)
