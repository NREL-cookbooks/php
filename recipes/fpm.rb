#
# Cookbook Name:: php
# Recipe:: fpm
#
# Copyright 2011, NREL
#
# All rights reserved - Do Not Redistribute
#

include_recipe "yum::ius"

pkgs = value_for_platform(
  [ "centos", "redhat", "fedora" ] => {
    "default" => %w{ php54-fpm php54-devel php54-cli php54-pear }
  },
  [ "debian", "ubuntu" ] => {
    "default" => %w{ php5-fpm php5-dev php5-cli php-pear }
  },
  "default" => %w{ php5-fpm php5-dev php5-cli php-pear }
)

pkgs.each do |pkg|
  package pkg do
    action :install
  end
end

directory "/var/log/php-fpm" do
  owner node[:php][:fpm_user]
  group "root"
  mode "0755"
  recursive true
end

template "/etc/php-fpm.conf" do
  source "php-fpm.conf.erb"
  owner "root"
  group "root"
  mode "0644"
  notifies :reload, "service[php_fpm]"
end

directory "/etc/php-fpm.d" do
  owner "root"
  group "root"
  mode "0755"
  recursive true
end

directory node[:php][:fpm][:www][:session_save_path] do
  owner node[:php][:fpm_user]
  group "root"
  mode "0770"
  recursive true
end

template "/etc/php-fpm.d/www.conf" do
  source "php-fpm-www.conf.erb"
  owner "root"
  group "root"
  mode "0644"
  notifies :reload, "service[php_fpm]"
end

service "php_fpm" do
  service_name "php-fpm"
  supports :status => true, :reload => true
  action [:enable, :start]
end
