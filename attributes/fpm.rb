default['php']['conf_dir']      = '/etc'
default['php']['ext_conf_dir']  = '/etc/php.d'

default[:php][:fpm][:packages] = value_for_platform_family(
  ["rhel", "fedora"] => {
    "default" => %w(php54-fpm php54-devel php54-cli php54-pear),
  },
  ["debian"] => {
    "default" => %w(php5-fpm php5-dev php5-cli php-pear),
  },
  "default" => %w(php5-fpm php5-dev php5-cli php-pear),
)
