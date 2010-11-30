#
# Author::  Nick Muerdter (<nick.muerdter@nrel.gov>)
# Cookbook Name:: php
# Recipe:: module_oci8
#
# Copyright 2010, NREL
#

include_recipe "oracle_instantclient"

pecl_module "oci8" do
  version node[:php][:module_oci8_version]
end
