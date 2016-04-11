#
# Author::  Joshua Timberman (<joshua@opscode.com>)
# Author::  Seth Chisamore (<schisamo@opscode.com>)
# Cookbook Name:: php
# Recipe:: module_apc
#
# Copyright 2009-2011, Opscode, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

package node[:php][:module_apc][:package] do
  action :install
  options "--enablerepo=ius"
end

# Hacky workaround so we can use this same recipe to work on some of our old
# 5.4 boxes with APC, as well as transitioning to 5.6 with APCu and Opcache
# replacements in test environments.
if(node[:php][:module_apc][:package] == "php56u-pecl-apcu")
  package "php56u-opcache" do
    action :install
    options "--enablerepo=ius"
  end

  file "#{node[:php][:ext_conf_dir]}/apc.ini" do
    action :delete
  end
else
  template "#{node[:php][:ext_conf_dir]}/apc.ini" do
    source "apc.ini.erb"
    owner "root"
    group "root"
    mode "0644"

    if(node.recipe?("apache2"))
      notifies :reload, "service[apache2]"
    elsif(node.recipe?("php::fpm"))
      notifies :reload, "service[php_fpm]"
    end
  end
end
