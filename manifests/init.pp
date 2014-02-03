class memcached (
  $package_ensure = 'installed',
) inherits memcached::params {


  file { [ $memcached::params::config_dir, $memcached::params::log_dir]:
    ensure => directory,
    owner => 'root',
    group => 'root',
    mode => 0770
  }

  if $install_dev {
    package { $memcached::params::dev_package_name:
      ensure  => $package_ensure,
      require => Package[$memcached::params::package_name]
    }
  }

  package { $memcached::params::package_name:
    ensure => $package_ensure,
  }

}
