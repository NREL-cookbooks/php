#
# Cookbook Name:: php
# Recipe:: module_xml
#
# Copyright 2010, NREL
#
# All rights reserved - Do Not Redistribute
#

case node[:platform]
when "centos", "redhat", "fedora", "suse"
  package "php-xml" do
    action :install

    if(node.recipe?("apache2"))
      notifies :reload, "service[apache2]"
    end
  end
when "debian", "ubuntu"
  # Ubuntu's default PHP is already compiled with xml support.
end
