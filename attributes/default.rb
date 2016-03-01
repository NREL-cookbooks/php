#
# Author:: Seth Chisamore (<schisamo@opscode.com>)
# Cookbook Name:: php
# Attribute:: default
#
# Copyright 2011, Opscode, Inc.
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

lib_dir = kernel['machine'] =~ /x86_64/ ? 'lib64' : 'lib'

default['php']['install_method'] = 'package'
default['php']['directives'] = {}

case node["platform_family"]
when "rhel", "fedora"
  default['php']['conf_dir']      = '/etc'
  default['php']['ext_conf_dir']  = '/etc/php.d'
  default['php']['fpm_user']      = 'nobody'
  default['php']['fpm_group']     = 'nobody'
  default['php']['ext_dir']       = "/usr/#{lib_dir}/php/modules"
when "debian"
  default['php']['conf_dir']      = '/etc/php5/cli'
  default['php']['ext_conf_dir']  = '/etc/php5/conf.d'
  default['php']['fpm_user']      = 'www-data'
  default['php']['fpm_group']     = 'www-data'
else
  default['php']['conf_dir']      = '/etc/php5/cli'
  default['php']['ext_conf_dir']  = '/etc/php5/conf.d'
  default['php']['fpm_user']      = 'www-data'
  default['php']['fpm_group']     = 'www-data'
end

default['php']['url'] = 'http://us.php.net/distributions'
default['php']['version'] = '5.3.10'
default['php']['checksum'] = 'ee26ff003eaeaefb649735980d9ef1ffad3ea8c2836e6ad520de598da225eaab'
default['php']['prefix_dir'] = '/usr/local'

default['php']['configure_options'] = %W{--prefix=#{php['prefix_dir']}
                                          --with-libdir=#{lib_dir}
                                          --with-config-file-path=#{php['conf_dir']}
                                          --with-config-file-scan-dir=#{php['ext_conf_dir']}
                                          --with-pear
                                          --enable-fpm
                                          --with-fpm-user=#{php['fpm_user']}
                                          --with-fpm-group=#{php['fpm_group']}
                                          --with-zlib
                                          --with-openssl
                                          --with-kerberos
                                          --with-bz2
                                          --with-curl
                                          --enable-ftp
                                          --enable-zip
                                          --enable-exif
                                          --with-gd
                                          --enable-gd-native-ttf
                                          --with-gettext
                                          --with-gmp
                                          --with-mhash
                                          --with-iconv
                                          --with-imap
                                          --with-imap-ssl
                                          --enable-sockets
                                          --enable-soap
                                          --with-xmlrpc
                                          --with-libevent-dir
                                          --with-mcrypt
                                          --enable-mbstring
                                          --with-t1lib
                                          --with-mysql
                                          --with-mysqli=/usr/bin/mysql_config
                                          --with-mysql-sock
                                          --with-sqlite3
                                          --with-pdo-mysql
                                          --with-pdo-sqlite}

default[:php][:module_apc][:package] = value_for_platform_family(
  ["rhel", "fedora"] => "php54-pecl-apc",
  ["debian"] => "php-apc",
)
default[:php][:module_apc][:enabled] = 1
default[:php][:module_apc][:filters] = []
default[:php][:module_apc][:stat] = 1
default[:php][:module_apc][:stat_ctime] = 0
default[:php][:module_pdo][:package] = value_for_platform_family(
  ["rhel", "fedora"] => "php54-pdo",
)
default[:php][:module_xml][:package] = value_for_platform_family(
  ["rhel", "fedora"] => "php54-xml",
)
default[:php][:module_oci8][:version] = "1.4.9"
default[:php][:module_yaml][:version] = "1.1.0"
default[:php][:module_stats][:version] = "1.0.2"

default[:php][:fpm][:pid] = "/var/run/php-fpm/php-fpm.pid"
default[:php][:fpm][:error_log] = "/var/log/php-fpm/error.log"
default[:php][:fpm][:www][:listen] = "127.0.0.1:9000"
default[:php][:fpm][:www][:listen_mode] = "0660"
default[:php][:fpm][:www][:listen_owner] = "www-data"
default[:php][:fpm][:www][:listen_group] = "www-data"
default[:php][:fpm][:www][:listen_allowed_clients] = "127.0.0.1"
default[:php][:fpm][:www][:user] = "www-data"
default[:php][:fpm][:www][:group] = "www-data"
default[:php][:fpm][:www][:max_children] = 50
default[:php][:fpm][:www][:start_servers] = 5
default[:php][:fpm][:www][:min_spare_servers] = 5
default[:php][:fpm][:www][:max_spare_servers] = 35
default[:php][:fpm][:www][:max_requests] = 0
default[:php][:fpm][:www][:security_limit_extensions] = ".php"
default[:php][:fpm][:www][:status_path] = nil
default[:php][:fpm][:www][:ping_path] = nil
default[:php][:fpm][:www][:slow_log] = "/var/log/php-fpm/www-slow.log"
default[:php][:fpm][:www][:error_log] = "/var/log/php-fpm/www-error.log"
default[:php][:fpm][:www][:session_save_path] = "/var/lib/php/session"
