#
# Author::  Nick Muerdter (<nick.muerdter@nrel.gov>)
# Cookbook Name:: php
# Recipe:: module_stats
#
# Copyright 2011, NREL
#

php_pear "stats" do
  action :install
  version node[:php][:module_stats][:version]
end
