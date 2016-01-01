# ddns-route53

Simple bash script for rolling one's own Dynamic DNS updater using AWS Route53.

Source is originally from [Roll your own dynamic DNS service using Amazon Route53](https://willwarren.com/2014/07/03/roll-dynamic-dns-service-using-amazon-route53)
though it's been slightly modified to use OpenDNS and uses environment variables
rather than hardcoded variables in the script.

## Installation

```bash
curl -sO https://raw.githubusercontent.com/mthssdrbrg/ddns-route53/master/ddns-route53.sh
```

## Usage

```bash
ddns-route53.sh --zone-id=ZONE_ID --record-set=RECORD_SET
```

It's also possible to use short options `-z` and `-r` (with or without equal
sign) if preferable, or by setting the `ZONE_ID` and `RECORD_SET` environment
variables.
