define memcached::bin (
  $instance_ensure  = 'running',
  $logfile         = "$memcached::params::log_file_prefix-$title.log",
  $max_memory      = false,
  $item_size       = false,
  $lock_memory     = false,
  $listen_ip       = '0.0.0.0',
  $tcp_port        = 11211,
  $udp_port        = 11211,
  $user            = $memcached::params::user,
  $max_connections = '8192',
  $verbosity       = undef,
  $unix_socket     = undef,
  $install_dev     = false,
  $processorcount  = $::processorcount
) {

  $service_name = "$memcached::params::service_name-$title"
  $service_file = "$memcached::params::service_dir/$service_name"

  file { $service_file:
    owner   => 'root',
    group   => 'root',
    mode    => '775',
    content => template($memcached::params::service_tmpl),
    require => Package[$memcached::params::package_name],
  }

  service { "$memcached::params::service_name-$title":
    ensure     => $instance_ensure,
    enable     => true,
    hasrestart => true,
    hasstatus  => $memcached::params::service_hasstatus,
    subscribe  => File[$service_file],
  }
}