# == Class: amazon_s3
#
# Installs and configures S3fs-fuse in order to mount S3 buckets.
#
# === Parameters
#
# [*aws_access_key*]
#  The access key for AWS. 
#
# [*secret_access_key*]
#   The secret key for AWS.
#
# [*s3fs_version*]
#   The version of the s3fs.
#   See https://github.com/s3fs-fuse/s3fs-fuse
#
# === Variables
#
# [*s3fs_src_dir*]
#   The source directory for compiling s3fs
#
# === Examples
#
#  class { 'amazon_s3':
#  }
#
# === Authors
#
# Michael Speth <spethm@landcareresearch.co.nz>
#
# === Copyright
#
# GPLv3
#
class amazon_s3 (
  $aws_access_key,
  $secret_access_key,
  $s3fs_version = 'v1.78',
){

  # == Variables == #
  $s3fs_src_dir = '/opt/s3fs'

  # Check supported operating systems
  if $::osfamily != 'debian' {
    fail("Unsupported OS ${::osfamily}.  Please use a debian based system")
  }
  anchor { 'amazon_s3::begin': }
  class{'amazon_s3::install':
    require => Anchor['amazon_s3::begin'],
  }
  class{'amazon_s3::config':
    require => Class['amazon_s3::install'],
  }
  anchor { 'amazon_s3::end':
    require => Class['amazon_s3::config'],
  }
}