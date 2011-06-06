#
# Author::  Nick Muerdter (<nick.muerdter@nrel.gov>)
# Cookbook Name:: php
# Recipe:: module_oci8
#
# Copyright 2010, NREL
#

include_recipe "oracle_instantclient"

php_pear "oci8" do
  action :install
  version node[:php][:module_oci8][:version]
  answer_prompt "instantclient,#{node[:oracle_instantclient][:path]}" 
end
