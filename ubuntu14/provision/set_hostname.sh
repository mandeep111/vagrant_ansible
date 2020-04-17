
#!/bin/bash
fqdn=ubuntu14.test
ip="$(ip addr | grep eth1 | grep inet | awk '{ print $2}' | cut -c 1-12)"
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
systemctl stop firewalld & systemctl disable firewalld & echo "firewall disabled at this point"
sleep 2
echo ""
echo "Updating"
sudo apt-get update

#installing repos
echo"installing repositories"
sudo apt-get install software-properties-common

sudo apt-add-repository ppa:ansible/ansible
sudo apt-get update
#installing ansible 
sudo apt-get install -y ansible

echo "Your server is ready with $ip"