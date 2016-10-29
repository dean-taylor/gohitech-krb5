define krb5::domain_realm::domain (
  $domain = $name,
  $realm,
) {
  include krb5
  include krb5::domain_realm

  concat::fragment { "/etc/krb5.conf_domain_realm_${realm}_${domain}":
    target  => '/etc/krb5.conf',
    content => " ${domain} = ${realm}\n",
    order   => '32',
  }
}

class krb5::domain_realm (
) inherits krb5::params {
  include krb5

  concat::fragment { "/etc/krb5.conf_domain_realm_header":
    target => '/etc/krb5.conf',
    content => "[domain_realm]\n",
    order   => '31',
  }
}
