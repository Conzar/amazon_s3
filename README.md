# amazon_s3

[![Build Status](https://travis-ci.org/Conzar/amazon_s3.svg?branch=master)](https://travis-ci.org/Conzar/amazon_s3)

## Overview

Enables mounting of s3 buckets.

## Module Description

Compiles and installs s3fs-fuse (from source) to provide support for mounting
S3 buckets.  See: [s3fs-fuse](https://github.com/s3fs-fuse/s3fs-fuse).

## Setup

### Requirements for Amazon S3

* You will need your [Amazon Access keys](http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSGettingStartedGuide/AWSCredentials.html).
* You will also need to have already created an S3 Bucket.
* Make sure the IAM user has [access](http://docs.aws.amazon.com/AmazonS3/latest/dev/using-iam-policies.html) to your S3 bucket.

### Beginning with amazon_ses

To install s3fs and setup the configuration for mounting with default parameters.
Note, its recomended to NOT store the access key or secret key in your puppet manifest.
Its a good practice to use [hiera](https://docs.puppetlabs.com/hiera/1/) and [eyaml](https://github.com/TomPoulton/hiera-eyaml).

```class {'amazon_s3':
    aws_access_key    => 'ACCESS_KEY',
    secret_access_key => 'SECRET_KEY',
   }
```

Creates a mount with default parameters.

```amazon_s3::s3_mount{'s3_mount':
    mount_point => '/mnt/s3_mount',
    require     => Class['amazon_s3'],
   }
```

## Usage

###Classes and Defined Types

This module downloads (from source), compiles, and installs s3fs-fuse; the module allows for auto-mounting s3 buckets.

####Class: `amazon_s3`

Installs and configures S3fs-fuse in order to mount S3 buckets.

**Parameters within `amazon_s3`:**

#####`aws_access_key`
The access key for your AWS IAM user that has access to the S3 bucket(s) that you plan on mounting.

#####`secret_access_key`
The secret key for your AWS IAM user that has access to the S3 bucket(s).

#####`s3fs_version`
This is the version of s3fs-fuse to install.  The version referes to the tags in the git repositoryg.
Currently, version [v1.78](https://github.com/s3fs-fuse/s3fs-fuse/tree/v1.78) is the default.

####Defined Type: `amazon_s3::s3_mount`

Defines an S3 automount (in fstab).  Also attempts to mount the bucket once defined.

**Parameters within `amazon_s3::s3_mount`:**


#####`s3_bucket_name`
The name of the S3 bucket to mount.  By default, it uses the title.

#####`mount_point`
The path to mount the bucket.  This module ensures the directory exists; however,
it does not ensure that the parent(s) to the path exists.  

## Limitations

Only works with debian based OS's.

## Development

The module is open source and available on github.  Please fork!