#
# Cookbook Name:: elk-elasticsearch
# Recipe:: default
# Author:: Kiran Neelakantam
# Copyright 2016, CTP
#
# All rights reserved - Do Not Redistribute
#

bash 'elk_install' do
  user 'root'
  code <<-EOH
   yum install wget -y
   wget --no-cookies --no-check-certificate --header "Cookie: oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u91-b14/jdk-8u91-linux-x64.rpm" -O jdk-8u91-linux-x64.rpm
   yum install jdk-8u91-linux-x64.rpm -y
  wget https://download.elastic.co/elasticsearch/release/org/elasticsearch/distribution/rpm/elasticsearch/2.3.5/elasticsearch-2.3.5.rpm
  yum install elasticsearch-2.3.5.rpm -y
  cd /usr/share/elasticsearch/
    ./bin/plugin install mobz/elasticsearch-head
    bin/plugin install lmenezes/elasticsearch-kopf
    bin/plugin install analysis-icu
    bin/plugin install cloud-aws
	#bin/plugin install license
	#bin/plugin install shield
  #service elasticsearch start
 #bin/shield/esusers useradd es_admin -r admin -p es_admin

  EOH
end

template '/etc/elasticsearch/elasticsearch.yml' do
      source 'elasticsearch.yml'
      owner 'root'
      group 'root'
      mode  '0755'
     end
	 

    service "elasticsearch" do
    action [:enable, :start]
 end

