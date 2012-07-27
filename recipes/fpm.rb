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

user node[:php][:fpm_user] do
  system true
  shell "/bin/false"
  home "/var/www"
  # Don't alter existing users (so pre-existing "vagrant" user can be used).
  not_if { Etc.getpwnam(node[:php][:fpm_user]) rescue false }
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

template "#{node['php']['conf_dir']}/php.ini" do
  source "php.ini.erb"
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

if(node.recipe?("nginx"))
  if(node[:php][:fpm][:www][:status_path] || node[:php][:fpm][:www][:ping_path])
    include_recipe "nginx"

    template "php_fpm_status" do
      path "#{node[:nginx][:dir]}/sites-available/php_fpm_status"
      source "nginx_status.erb"
      owner "root"
      group "root"
      mode "0644"
      notifies :reload, resources(:service => "nginx")
    end

    nginx_site "php_fpm_status"
  end
end
