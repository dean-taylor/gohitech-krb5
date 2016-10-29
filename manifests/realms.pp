define krb5::realms::realm (
  $realm          = $name,
  $admin_server   = undef,
  $auth_to_local  = [],
  $auth_to_local_names = undef,
  $default_domain = undef,
  $http_anchors   = undef,
  $kdc            = undef,
  $kpasswd_server = undef,
  $master_kdc     = undef,
  $v4_instance_convert = undef,
  $v4_realm       = undef,
) {
  include krb5
  include krb5::realms

  concat::fragment { "/etc/krb5.conf_realms_${realm}_aaheader":
    target  => $krb5::krb5_conf,
    content => " ${realm} = {\n",
    order   => '22',
  }
  concat::fragment { "/etc/krb5.conf_realms_${realm}_zzfooter":
    target  => '/etc/krb5.conf',
    content => " }\n",
    order   => '22',
  }
}

class krb5::realms (
) inherits krb5::params {
  include krb5

  concat::fragment { "/etc/krb5.conf_realms_header":
    target  => '/etc/krb5.conf',
    content => "[realms]\n",
    order   => '21',
  }
}
