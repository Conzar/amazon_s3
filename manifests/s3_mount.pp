# == Defined Type: amazon_s3::s3_mount
#
# The individual s3 mount.
# Requires amazon_s3.
#
# === Parameters
#
# [*ensure*]
#   Control what to do with this mount. Acceps the same values as the 'mount' type.
#
# [*mount_point*]
#   The path to mount.  Note, this module ensures the directory exists.
#
# [*options*]
#   Options used when mounting.
#
# [*s3_bucket_name*]
#   The name of the s3 bucket. By default, it uses the title.
#
define amazon_s3::s3_mount(
  $ensure = 'mounted',
  $mount_point,
  $options = 'allow_other',
  $s3_bucket_name = $title,
){
  file{$mount_point:
    ensure => directory,
    mode   => '0777',
  }

  # mount the s3 bucket
  mount { $title:
    ensure  => $ensure,
    name    => $mount_point,
    device  => "s3fs#${s3_bucket_name}",
    fstype  => 'fuse',
    options => $options,
    require => File[$mount_point],
  }
}
