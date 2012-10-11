#
# Author::  Nick Muerdter (<nick.muerdter@nrel.gov>)
# Cookbook Name:: php
# Recipe:: module_pdo
#
# Copyright 2012, NREL
#

case node['platform']
when "centos", "redhat", "fedora", "scientific"
  package "php54-pdo" do
    action :install
  end
when "debian", "ubuntu"
end
