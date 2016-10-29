class krb5::params {
  $default_ccache_name = 'KEYRING:persistent:%{uid}'	# 'FILE:/tmp/krb5cc_%{uid}'
  $krb5_conf = '/etc/krb5.conf'
  $packages = ['krb5-libs',]
}
