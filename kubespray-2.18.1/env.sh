#!/bin/bash


#去selinux
setenforce 0
sed -i '/SELINUX/s/enforcing/disabled/' /etc/selinux/config
#关闭防火墙
systemctl stop firewalld && systemctl disable firewalld

#设置iptables规则
iptables -F && iptables -X && iptables -F -t nat && iptables -X -t nat && iptables -P FORWARD ACCEPT

#环境变量
grep 'nerdctl' /etc/bashrc &>/dev/null || {
echo '
export PATH=$PATH:/usr/local/bin
alias docker="nerdctl -n k8s.io"
'>>/etc/bashrc 
kubectl --help &>/dev/null || {
echo '
alias k=kubectl
alias kk="kubectl -n kube-system"
alias docker="nerdctl -n k8s.io"
export do="--dry-run=client -o yaml"
complete -F __start_kubectl k
'>>/etc/bashrc 
}
source /etc/bashrc
#纠正时区
sudo timedatectl set-timezone 'Asia/Shanghai'
#去swap
sudo /usr/sbin/swapoff -a && free –h && sed '/swap/d'  /etc/fstab  -i

# 关闭dnsmasq(否则可能导致容器无法解析域名)
systemctl status dnsmasq &>/dev/null && {
 service dnsmasq stop 
 systemctl disable dnsmasq
}
cat > /etc/sysctl.d/kubernetes.conf <<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_nonlocal_bind = 1
net.ipv4.ip_forward = 1
vm.swappiness = 0
vm.overcommit_memory = 1
EOF
# 生效文件
modprobe br_netfilter && sysctl -p /etc/sysctl.d/kubernetes.conf