# == Class: amazon_s3::config
#
# Configures the mounts for amazon s3.
#
# === Parameters
#
# === Authors
#
# Michael Speth <spethm@landcareresearch.co.nz>
#
# === Copyright
# GPL-3.0+
#
class amazon_s3::config {
  file {'/etc/passwd-s3fs':
    ensure  => file,
    content => inline_template("${amazon_s3::aws_access_key}:\
${amazon_s3::secret_access_key}"),
    mode    => '0640',
  }
}