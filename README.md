# ddns-route53

[![Build Status](https://travis-ci.org/mthssdrbrg/ddns-route53.svg?branch=main)](https://travis-ci.org/mthssdrbrg/ddns-route53)
[![GitHub Release](https://img.shields.io/github/release/mthssdrbrg/ddns-route53.svg)]()

Simple dynamic DNS updater script using Amazon Route53.

Source is originally from [Roll your own dynamic DNS service using Amazon Route53](https://willwarren.com/2014/07/03/roll-dynamic-dns-service-using-amazon-route53)
though it's been modified to use OpenDNS for getting the current IP address, as
well as usage of command line arguments and environment variables.

## Requirements

* `bash`
* `awscli`
* `dig`

## Installation

```shell
curl -sLO https://github.com/mthssdrbrg/ddns-route53/raw/$VERSION/ddns-route53
```

The following IAM policy (or something similar) will have to be applied to an user or role.
Unfortunately it's not possible to restrict access to specific resource record (yet), but
a workaround is to create a "sub" hosted zone for a specific record.

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "route53:ChangeResourceRecordSets",
        "route53:ListResourceRecordSets"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:route53:::hostedzone/EXAMPLE"
    }
  ]
}
```

## Usage

```shell
$ ddns-route53 --zone-id <ZONE_ID> --record-set <RECORD_SET>
```

> Note: long options on the form `--long-option=` are not supported.

The above command assumes that the necessary environment variables for `awscli`
are set, an A type record and a TTL of 300 seconds.

See `ddns-route53 --help` for more information about command line arguments.

It's possible to set a number of environment variables instead of using command
line arguments, though command line arguments take precedence over environment
variables.

* `DDNS_ROUTE53_TTL`: TTL for DNS record.
* `DDNS_ROUTE53_TYPE`: DNS record type.
* `DDNS_ROUTE53_COMMENT`: comment set when updating the Route53 record (only
  configurable as environment variable).
* `DDNS_ROUTE53_ZONE_ID`: Amazon Route53 hosted zone ID.
* `DDNS_ROUTE53_RECORD_SET`: Amazon Route53 record set name.
* `DDNS_ROUTE53_SCRIPT`: path to script to execute on changes.

## Copyright

This is free and unencumbered software released into the public domain.

See LICENSE.txt or [unlicense.org](http://unlicense.org) for more information.
