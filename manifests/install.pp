# == Class: amazon_s3::install
#
# Installs the required software
#
# === Parameters
#
#
class amazon_s3::install {
  
  $packages = ['build-essential', 'libfuse-dev','libcurl4-openssl-dev',
  'libxml2-dev','mime-support','automake','libtool','git']
  ensure_packages($packages)
  
  vcsrepo { $amazon_s3::s3fs_src_dir:
    ensure   => 'present',
    provider => 'git',
    source   => 'git://github.com/s3fs-fuse/s3fs-fuse.git',
    revision => $amazon_s3::s3fs_version,
    require  => Package[$packages],
  }
  exec { 'compile s3fs':
    command     => "${amazon_s3::s3fs_src_dir}/autogen.sh &&\
 ${amazon_s3::s3fs_src_dir}/configure --prefix=/usr &&\
 /usr/bin/make &&\
 /usr/bin/make install",
    cwd         => $amazon_s3::s3fs_src_dir,
    refreshonly => true,
    subscribe   => Vcsrepo [$amazon_s3::s3fs_src_dir],
  }
  exec { 'install s3fs':
    command     => '/usr/bin/make install',
    cwd         => $amazon_s3::s3fs_src_dir,
    refreshonly => true,
    subscribe   => Exec['compile s3fs'],
  }
}
