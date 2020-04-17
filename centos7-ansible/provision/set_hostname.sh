
#!/bin/bash
fqdn=ansible.test
ip="$(ifconfig eth1 | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}')"
echo $ip
echo "setting the hostname as $fqdn in /etc/hosts file with ipaddress $ip ... "
echo "$ip       $fqdn" >> /etc/hosts
sleep 2
echo ""
printf "writing $fqdn as hostname in kernel..."
sleep 2
sysctl kernel.hostname=$fqdn
echo ""
sleep 2
service iptables stop & chkconfig iptables off & echo "firewall disabled at this point"
sleep 2
echo ""
echo "Finally getting repos..."
sleep 3
cd /opt
rpm -ivh http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm && echo "got epel repos"
sleep 1
yum install -y ansible && echo "ansible has been installed"
sleep 5
echo "your server is ready to ssh into with $ip"