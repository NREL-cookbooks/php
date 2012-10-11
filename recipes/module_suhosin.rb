#
# Cookbook Name:: php
# Recipe:: module_suhosin
#
# Copyright 2011, NREL
#
# All rights reserved - Do Not Redistribute
#

case node[:platform]
when "debian", "ubuntu"
  package "php5-suhosin" do
    if(node.recipe?("apache2"))
      notifies :reload, "service[apache2]"
    end
  end
when "centos", "redhat", "fedora", "suse"
  package "php-suhosin" do
    if(node.recipe?("apache2"))
      notifies :reload, "service[apache2]"
    end
  end
end

