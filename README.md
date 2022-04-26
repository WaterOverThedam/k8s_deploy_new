# 一、 准备镜像和二进制压缩包
##  1）files镜像和二进制压缩下载地址：
     链接: https://pan.baidu.com/s/18bFvBZMjrqCVJJe4n8rV6A 提取码: n7kj 
##  2）下载好后，tar包移入程序目录下的files文件夹
##  3）程序根目录执行
```bash
 tar -xf files/roles_addon_files_images.tar.gz
 tar -xf files/roles_binary_files.tar.gz
 tar -xf files/roles_worker_svc_files_images.tar.gz
```

# 二、安装
## 前提： 操作命令主机先安装ansible软件 
```bash
 yum install ansible -y
```
## 方法一、vagrant+virtualbox环境下，通过vagrant和vagrant ansible插件部署,修改Vagrantfile配置，up.sh运行部署
```bash
  vi Vagrantfile
  sh up.sh
``` 
## 方法二、普通环境下，直接ansible命令部署
*  1）修改inventory下的hosts.ini主机信息;和group_vars/all.yml的extra_vars可覆盖部分
*  2）执行playbook命令
```bash
 ansbile-playbook -i hosts.ini cluster.yml  
```

# 三、vagrant相关命令
* 启动主机： vagrant up
* 重启主机： vagrant reload
* 单跑shell脚本： vagrant provision --provision-with shell
* 单跑ansible脚本： vagrant provision --provision-with ansible
* 保存快照： vagrant snapshot save [快照名]
* 恢复快照： vagrant snapshot restore [快照名]
* 删除主机： vagrant destroy -f

# 四、注意事项：
* 如果中途有部分role任务失败，可以单独调用ansible role,仅跑失败的
```bash
Vagrantfile 配置如下可调整
                    ansible.raw_arguments  = [
                    #用于单跑role，用tag过滤
                      "-t addon,test"
                    ]    
     等价于<=>
ansbile-playbook -i hosts.ini cluster.yml  -t addon,test
```
* 单跑ansible脚本： vagrant provision --provision-with ansible

# 五、小技巧
role任务比较多，一旦失败，全部重新跑一遍会比较浪费时间。
可以通过tag标签分步骤部署；成功一部分可以做下快照，再接着跑后面的任务