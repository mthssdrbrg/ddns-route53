# ddns-route53

Simple bash script for rolling one's own Dynamic DNS updater using AWS Route53.

Source is originally from [Roll your own dynamic DNS service using Amazon Route53](https://willwarren.com/2014/07/03/roll-dynamic-dns-service-using-amazon-route53)
though it's been slightly modified to use OpenDNS and uses environment variables
rather than hardcoded variables in the script.

## Installation

```bash
# Download the latest script using your preferred tool, if command-line:
curl -s https://raw.githubusercontent.com/mthssdrbrg/ddns-route53/master/ddns-route53.sh -O
wget -q https://raw.githubusercontent.com/mthssdrbrg/ddns-route53/master/ddns-route53.sh
# If you want to download it to some other directory:
curl -s https://raw.githubusercontent.com/mthssdrbrg/ddns-route53/master/ddns-route53.sh -o /tmp/ddns-route53.sh
wget -q https://raw.githubusercontent.com/mthssdrbrg/ddns-route53/master/ddns-route53.sh -O /tmp/ddns-route53.sh
```
