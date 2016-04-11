#
# Author::  Nick Muerdter (<nick.muerdter@nrel.gov>)
# Cookbook Name:: php
# Recipe:: module_pdo
#
# Copyright 2012, NREL
#

package node[:php][:module_pdo][:package] do
  action :install
  options "--enablerepo=ius"
end
