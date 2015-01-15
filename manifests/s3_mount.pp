# == Defined Type: amazon_s3::s3_mount
#
# The individual s3 mount.
# Requires amazon_s3.
#
# === Parameters
#
# [*s3_bucket_name*]
#   The name of the s3 bucket. By default, it uses the title.
#
# [*mount_point*]
#   The path to mount.  Note, this module ensures the directory exists.
#
define amazon_s3::s3_mount(
  $mount_point,
  $s3_bucket_name = $title,
){
  
  file{$mount_point:
    ensure => directory,
    mode   => '0777',
  }
  
  # mount the s3 bucket
  mount { $title:
    ensure  => 'mounted',
    name    => $mount_point,
    device  => "s3fs#${s3_bucket_name}",
    fstype  => 'fuse',
    options => 'allow_other',
    require => File[$mount_point],
  }
}