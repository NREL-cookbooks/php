#
# Cookbook Name:: php
# Recipe:: ctts
#
# Copyright 2010, NREL
#
# All rights reserved - Do Not Redistribute
#

cookbook_file "#{node[:php][:ext_conf_dir]}/ctts.ini" do
  source "ctts.ini"
  owner "root"
  group "root"
  mode "0644"

  if(node.recipe?("apache2"))
    notifies :reload, "service[apache2]"
  end
end
