#
# Author::  Nick Muerdter (<nick.muerdter@nrel.gov>)
# Cookbook Name:: php
# Recipe:: module_yaml
#
# Copyright 2010, NREL
#

include_recipe "yum::epel"

package_name = value_for_platform({
  ["redhat", "centos", "fedora"] => { "default" => "libyaml-devel" },
  "default" => { "default" => "libyaml-dev" },
})

package package_name

php_pear "yaml" do
  action :install
  version node[:php][:module_yaml][:version]
end
