#
# Author::  Nick Muerdter (<nick.muerdter@nrel.gov>)
# Cookbook Name:: php
# Recipe:: module_yaml
#
# Copyright 2010, NREL
#

if platform?("redhat", "centos", "fedora")
  include_recipe "yum::epel"
end

package_name = value_for_platform({
  ["redhat", "centos", "fedora"] => { "default" => "libyaml-devel" },
  "default" => { "default" => "libyaml-dev" },
})

package package_name

pecl_module "yaml" do
  version node[:php][:module_yaml][:version]
  ini "extension=yaml.so"
end
