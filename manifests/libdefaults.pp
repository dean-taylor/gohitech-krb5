class krb5::libdefaults (
  $allow_weak_crypto    = false,
  $ap_req_checksum_type = undef,
  $canonicalize         = false,
  $ccache_type          = 4,
  $clockskew            = 300,		# seconds
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
  $kcm_mach_service     = 'org.h5l.kcm',	# OS X only
  $kcm_socket           = '/var/run/.heim_org.h5l.kcm-socket',
  $kdc_default_options  = '0x00000010',	# KDC_OPT_RENEWABLE_OK
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
  $safe_checksum_type   = 8,	# RSA MD5  DES
  $ticket_lifetime      = '24h',
  $udp_preference_limit = undef,
  $verify_ap_req_nofail = false,
) inherits krb5::params {
  validate_integer($kdc_timesync,1,0)

  include krb5

  concat::fragment { '/etc/krb5.conf_libdefaults':
    target  => $krb5::params::krb5_conf,
    content => template('krb5/krb5.conf/libdefaults.erb'),
  }
}
