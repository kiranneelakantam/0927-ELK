#
# Cookbook Name:: elk-kibana
# Recipe:: default
# Author:: Kiran Neelakantam
# Copyright 2016, CTP
#
# All rights reserved - Do Not Redistribute
#

  bash 'elk_kibana_install' do
  user 'root'
  code <<-EOH
  yum install wget -y
  yum install unzip -y
  wget https://download.elastic.co/kibana/kibana/kibana-4.5.4-linux-x64.tar.gz
  tar xzf kibana-4.5.4-linux-x64.tar.gz
  curl -L -O http://download.elastic.co/beats/dashboards/beats-dashboards-1.3.1.zip
  unzip beats-dashboards-1.3.1.zip
  
   EOH
end

#Filebeat dashborad installation
template '/beats-dashboards-1.3.1/load.sh' do
      source 'load.sh'
      user 'root'
      owner 'root'
      group 'root'
      mode  '0777'
     end
#Kibana configuartion integation with elasticsearch
  template '/kibana-4.5.4-linux-x64/config/kibana.yml' do
      source 'kibana.yml'
      user 'root'
      owner 'root'
      group 'root'
      mode  '0755'
     end

 #Exceute and install the plugins and start the kibana
 bash 'elk_kibana_start' do
  user 'root'
  code <<-EOH
  cd /beats-dashboards-1.3.1
   ./load.sh
  cd /kibana-4.5.4-linux-x64
   nohup ./bin/kibana &
   EOH
 end

