一、 准备镜像和二进制压缩包
#files镜像和二进制压缩下载地址：
 链接: https://pan.baidu.com/s/1c12oQMg1qe4Is6I53UxhDQ 提取码: a9as 
#下载好后，tar包移入files文件夹
#当前目录执行
 tar -xf files/vagrant_k8s_playbook_new_roles_addon_files_images.tar.gz
 tar -xf files/vagrant_k8s_playbook_new_roles_binary_files.tar.gz
 tar -xf files/vagrant_k8s_playbook_new_roles_worker_svc_files_images.tar.gz

 二、安装
 前提： 操作命令主机先安装ansible软件 
 cd k8s_playbook_new/
 方法一、vagrant+virtualbox环境下，通过vagrant和vagrant ansible插件部署
 cd vagrant && sh up.sh

 方法二、普通环境下，直接ansible命令部署
 1）修改hosts.ini;修改group_vars/all.yml，替换来自extra_vars变量
 2）执行playbook
 ansbile-playbook -i hosts.ini cluster.yml  
