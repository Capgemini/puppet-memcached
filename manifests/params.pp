class memcached::params {
  case $::osfamily {
    'Debian': {
      $package_name      = 'memcached'
      $service_name      = 'memcached'
      $service_hasstatus = false
      $dev_package_name  = 'libmemcached-dev'
      $config_dir        = '/etc/memcached'
      $log_dir           = '/var/log/memcached'
      $log_file_prefix   = "$log_dir/$service_name"
      $service_dir       = '/etc/init.d/'
      $config_tmpl       = "${module_name}/memcached.conf.erb"
      $serivce_tmpl      = "${module_name}/memcached_service.erb"
      $user              = 'nobody'
    }
    'RedHat': {
      $package_name      = 'memcached'
      $service_name      = 'memcached'
      $service_hasstatus = true
      $dev_package_name  = 'libmemcached-devel'
      $config_dir        = '/etc/sysconfig/memcached'
      $log_dir           = '/var/log/memcached'
      $log_file_prefix   = "$log_dir/$service_name"
      $service_dir       = '/etc/init.d/'
      $config_tmpl       = "${module_name}/memcached_sysconfig.erb"
      $service_tmpl      = "${module_name}/memcached_service.erb"
      $user              = 'memcached'
    }
    default: {
      fail("Unsupported platform: ${::osfamily}")
    }
  }

}
