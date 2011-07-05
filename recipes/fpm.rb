#
# Cookbook Name:: php
# Recipe:: fpm
#
# Copyright 2011, NREL
#
# All rights reserved - Do Not Redistribute
#

include_recipe "yum::remi"

pkgs = value_for_platform(
  [ "centos", "redhat", "fedora" ] => {
    "default" => %w{ php-fpm php php-devel php-cli php-pear }
  },
  [ "debian", "ubuntu" ] => {
    "default" => %w{ php5-fpm php5 php5-dev php5-cli php-pear }
  },
  "default" => %w{ php5-fpm php5 php5-dev php5-cli php-pear }
)

pkgs.each do |pkg|
  package pkg do
    action :install
  end
end

service "php-fpm" do
  supports :status => true, :reload => true
  action [:enable, :start]
end
