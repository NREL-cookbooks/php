#
# Cookbook Name:: php
# Recipe:: ctts
#
# Copyright 2010, NREL
#
# All rights reserved - Do Not Redistribute
#

ini_path = value_for_platform({
  ["centos", "redhat", "fedora", "suse"] => { "default" => "/etc/php.d/ctts.ini" },
  "default" => "/etc/php5/conf.d/ctts.ini",
})

cookbook_file "#{node[:php][:confd_path]}/ctts.ini" do
  source "ctts.ini"
  owner "root"
  group "root"
  mode "0644"

  if(node.recipe?("apache2"))
    notifies :reload, "service[apache2]"
  end
end
