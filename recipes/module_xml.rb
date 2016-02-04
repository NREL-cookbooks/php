#
# Cookbook Name:: php
# Recipe:: module_xml
#
# Copyright 2010, NREL
#
# All rights reserved - Do Not Redistribute
#

package node[:php][:module_xml][:package] do
  action :install

  if(node.recipe?("apache2"))
    notifies :reload, "service[apache2]"
  elsif(node.recipe?("php::fpm"))
    notifies :reload, "service[php_fpm]"
  end
end
