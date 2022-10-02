#!/bin/bash
touch py-requirements.txt
cat >./py-requirements.txt <<EOF
pandas==1.3.5
tqdm==4.64.0
mysql-connector==2.2.9
argparse==1.4.0
sqlalchemy==1.4.37
pymysql==1.0.2
EOF
sudo pip3 install -r py-requirements.txt
sudo yum install https://dev.mysql.com/get/mysql80-community-release-el7-5.noarch.rpm -y &&
sudo amazon-linux-extras install epel -y &&
sudo yum -y install mysql-community-server -y &&
sudo systemctl start mysqld &&
sleep 60s && 
aws s3 cp s3://ravi-banking-aws/pswd-db.txt /home/ec2-user/ &&
pswd="$(sudo grep 'temporary password' /var/log/mysqld.log | cut -d ':' -f4,5,6,7)" &&
pswd_new=$(cat /home/ec2-user/pswd-db.txt)
mysql -uroot -p"$(echo $pswd)" --connect-expired-password -e"ALTER USER 'root'@'localhost' IDENTIFIED BY '$(echo $pswd_new)';"
mysql -uroot -p"$(echo $pswd_new)" -e"CREATE USER 'ravi'@'%' IDENTIFIED BY '$(echo $pswd_new)';"
mysql -uroot -p"$(echo $pswd_new)" -e"GRANT ALL PRIVILEGES ON *.* to 'ravi'@'%';"
sudo echo "bind-address=0.0.0.0" >> /etc/my.cnf &&
echo 'updated'
sudo service mysqld restart 
echo 'done!!!'
