#
# Cookbook Name:: php
# Recipe:: cyber_security
#
# Copyright 2012, NREL
#
# All rights reserved - Do Not Redistribute
#

template "#{node[:php][:ext_conf_dir]}/cyber_security.ini" do
  source "cyber_security.ini.erb"
  owner "root"
  group "root"
  mode "0644"

  if(node.recipe?("apache2"))
    notifies :reload, "service[apache2]"
  elsif(node.recipe?("php::fpm"))
    notifies :reload, "service[php_fpm]"
  end
end
