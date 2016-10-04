#
# Cookbook Name:: elk-logstash
# Recipe:: default
# Author:: Kiran Neelakantam
# Copyright 2016, CTP
#
# All rights reserved - Do Not Redistribute


bash 'elk_logstash_install' do
  user 'root'
  code <<-EOH
   yum install wget -y
  wget --no-cookies --no-check-certificate --header "Cookie: oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u91-b14/jdk-8u91-linux-x64.rpm" -O jdk-8u91-linux-x64.rpm
  yum install jdk-8u91-linux-x64.rpm -y
  wget https://download.elastic.co/logstash/logstash/packages/centos/logstash-2.4.0.noarch.rpm
  yum install logstash-2.4.0.noarch.rpm -y
  rm -rf  /var/log/syslog
  mkdir /var/log/syslog
  chmod 777 /var/log/syslog/*.*log
  chmod 777 /var/log/yum.log
 # service logstash start
  EOH
end


template '/etc/logstash/conf.d/logstash.conf' do
      source 'logstash.conf'
      owner 'root'
      group 'root'
      mode  '0755'
     end

template '/etc/init.d/rsyslog' do
      source 'rsyslog'
      owner 'root'
      group 'root'
      mode  '0111'
     end


template '/etc/rsyslog.conf' do
      source 'rsyslog.conf'
      owner 'root'
      group 'root'
      mode  '0755'
     end

	 	 	 
service "rsyslog" do
 action [:restart]
end


 service "logstash" do
    action [:enable, :start]
end
