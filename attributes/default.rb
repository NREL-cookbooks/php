#
# Cookbook Name:: php
# Attributes:: php
#
# Copyright 2010, NREL
#
# All rights reserved - Do Not Redistribute
#

case platform
when "centos", "redhat", "fedora", "suse"
  default[:php][:ini_path] = "/etc/php.ini"
  default[:php][:confd_path] = "/etc/php.d"
else
  default[:php][:ini_path] = "/etc/php5/apache2/php.ini"
  default[:php][:confd_path] = "/etc/php5/conf.d"
end

default[:php][:module_oci8][:version] = "1.4.4"
