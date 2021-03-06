class krb5 (
  $allow_weak_crypto    = false,
  $ap_req_checksum_type = undef,
  $canonicalize         = false,
  $ccache_type          = 4,
  $clockskew            = 300,          # seconds
  $default_ccache_name  = $krb5::params::default_ccache_name,
  $default_client_keytab_name = 'FILE:/var/kerberos/krb5/user/%{euid}/client.keytab',
  $default_keytab_name  = 'FILE:/etc/krb5.keytab',
  $default_realm        = undef,
  $default_tgs_enctypes = 'aes256-cts-hmac-sha1-96 aes128-cts-hmac-sha1-96 des3-cbc-sha1 arcfour-hmac-md5 camellia256-cts-cmac camellia128-cts-cmac des-cbc-crc des-cbc-md5 des-cbc-md4',
  $default_tkt_enctype  = 'aes256-cts-hmac-sha1-96 aes128-cts-hmac-sha1-96 des3-cbc-sha1 arcfour-hmac-md5 camellia256-cts-cmac camellia128-cts-cmac des-cbc-crc des-cbc-md5 des-cbc-md4',
  $dns_canonicalize_hostname = true,
  $dns_lookup_kdc       = false,
  $dns_lookup_realm     = false,
  $extra_addresses      = undef,
  $forwardable          = false,
  $ignore_acceptor_hostname = false,
  $k5login_authoritative = true,
  $k5login_directory    = undef,
  $kcm_mach_service     = 'org.h5l.kcm',        # OS X only
  $kcm_socket           = '/var/run/.heim_org.h5l.kcm-socket',
  $kdc_default_options  = '0x00000010', # KDC_OPT_RENEWABLE_OK
  $kdc_timesync         = 1,
  $kdc_req_checksum_type = undef,
  $noaddresses          = true,
  $permitted_enctypes   = 'aes256-cts-hmac-sha1-96 aes128-cts-hmac-sha1-96 des3-cbc-sha1 arcfour-hmac-md5 camellia256-cts-cmac camellia128-cts-cmac des-cbc-crc des-cbc-md5 des-cbc-md4',
  $plugin_base_dir      = 'krb5/plugins',
  $preferred_preauth_types = '17, 16, 15, 14',
  $proxiable            = false,
  $rdns                 = true,
  $realm_try_domains    = undef,
  $renew_lifetime       = 0,
  $safe_checksum_type   = 8,    # RSA MD5  DES
  $ticket_lifetime      = '24h',
  $udp_preference_limit = undef,
  $verify_ap_req_nofail = false,
  $packages             = $krb5::params::packages,
  $krb5_conf            = $krb5::params::krb5_conf,
) inherits krb5::params {
  package { $packages:
  }

  concat { $krb5_conf:
    ensure => present,
    warn   => true,
  }
  concat::fragment { '/etc/krb5.conf_libdefaults':
    target  => $krb5_conf,
    content => template('krb5/krb5.conf/libdefaults.erb'),
    order   => '11',
  }

  if $default_realm {
    krb5::realms::realm { $default_realm:
    }
    $domain = downcase($default_realm)
    $domains = [".${domain}","${domain}",]
    krb5::domain_realm::domain { $domains:
      realm => $default_realm,
    }
  }
}

# == Class: krb5
#
# Full description of class krb5 here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { krb5:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2016 Your name here, unless otherwise noted.
#
