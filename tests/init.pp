# The baseline for module testing used by Puppet Labs is that each manifest
# should have a corresponding test manifest that declares that class or defined
# type.
#
# Tests are then run by using puppet apply --noop (to check for compilation
# errors and view a log of events) or by fully applying the test in a virtual
# environment (to compare the resulting system state to the desired state).
#
# Learn more about module testing here:
# http://docs.puppetlabs.com/guides/tests_smoke.html
#
class {'amazon_s3':
  aws_access_key    => 'ACCESS_KEY',
  secret_access_key => 'SECRET_KEY',
}
amazon_s3::s3_mount{'s3_mount':
  mount_point => '/mnt/s3_mount',
  require     => Class['amazon_s3'],
}