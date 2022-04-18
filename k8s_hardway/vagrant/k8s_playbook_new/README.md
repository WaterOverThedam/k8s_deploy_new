# 1.主机初始化
## 1.1.说明
Ansible Linux主机初始化模块

## 1.2.前提条件
* 部署运维平台
* 部署yum源
* 安装ansible

## 1.3.执行流程
1. 设置`hosts`文件中主机信息
1. 设置`/etc/ansible/ansible.cfg`配置能使用密码登录
1. 运维平台主机免密登录hosts.ini文件主机
1. 执行ansible初始化主机脚本

# 1.4.全局参数配置
全局参数配置在`group_vars/all.yml`文件中配置

|参数名|默认值|描述|
| --- | --- | --- |
|h2_db_name|winning|运维平台H2数据库名|
|db_user_name|admin|运维平台H2数据库用户名|
|db_user_pwd| |运维平台H2数据库密码|

# 1.5.执行实例
```shell
## 格式：脚本名 主机编码:主机密码
###hosts.ini可传root密码；调用脚本也可以传密码。如果两个地方都有hosts.ini的参数优先
法一、
./init_sys.sh prod_mid1 prod_mid2 prod_mid3
法二、
./init_sys.sh mid1:xxx mid2:xxx mid3:xxx

## 执行防火墙配置操作，使用tag标签实现
ansible-playbook -i hosts --tags=firewall init_sys.yml

## 关闭防火墙
ansible-playbook -i hosts --tags=firewall_stop init_sys.yml

## 防火墙白名单调整
###重置防火墙白名单；白名单=集群主机ip+Vip+脚本白名单参数
sh modify_whitelist.sh prod 172.16.208.1,172.16.208.13,172.16.11.12 reset
###增加防火墙白名单，默认是增加；白名单=之前已经有白名单+脚本白名单参数
sh modify_whitelist.sh prod 172.16.208.1,172.16.208.174 [add]
###移除白名单；白名单=之前已经有白名单-脚本白名单参数
sh modify_whitelist.sh prod 172.16.208.1,172.16.208.174 remove
```
