#!/bin/bash
# TTL for record set
TTL=${TTL:-300}
COMMENT="Updated at $(date +"%Y%m%d%H%M%S")"
# Change to AAAA if using an IPv6 address
TYPE="A"
IP=$(dig +short myip.opendns.com @resolver1.opendns.com)
LOG_DIR="${LOG_DIR:-/var/log/ddns-route53}"
LOG_FILE="$LOG_DIR/ddns-route53.log"
IP_FILE="$LOG_DIR/ip.log"
# Sanity check for fetched IP addres
function valid_ip()
{
  local ip=$1
  local stat=1
  if [[ $ip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
      OIFS=$IFS
      IFS='.'
      ip=($ip)
      IFS=$OIFS
      [[ ${ip[0]} -le 255 && ${ip[1]} -le 255 \
          && ${ip[2]} -le 255 && ${ip[3]} -le 255 ]]
      stat=$?
  fi
  return $stat
}

while [[ $# -gt 0 ]]; do
  key="$1"
  case "$key" in
    -z|--zone)
      ZONE_ID="$2"
      shift
      shift
      ;;
    -z=*|--zone=*)
      ZONE_ID="${key#*=}"
      shift
      ;;
    -r|--record-set)
      RECORD_SET="$2"
      shift
      shift
      ;;
    -r=*|--record-set=*)
      RECORD_SET="${key#*=}"
      shift
      ;;
    *)
      echo "Unkown option: $key = $2"
      exit 1
      ;;
  esac
done

if [[ -z $ZONE_ID ]]; then
  echo "Missing -z | --zone | \$ZONE_ID"
  exit 1
elif [[ -z $RECORD_SET ]]; then
  echo "Missing -r | --record-set | \$RECORD_SET"
  exit 1
fi

if [[ -d $LOG_DIR ]]; then
  mkdir -p "$LOG_DIR"
fi

if ! valid_ip "$IP"; then
  echo "Invalid \$IP address: $IP" >> "$LOG_FILE"
  exit 1
fi

if grep -Fxq "$IP" "$IP_FILE"; then
  echo "Current IP == $IP, exiting" >> "$LOG_FILE"
  exit 0
else
  echo "IP has changed to $IP, updating" >> "$LOG_FILE"
  TMP_FILE=$(mktemp -t ddns-route53.XXXXXXXX)
  cat > "$TMP_FILE" << EOF
  {
    "Comment": "$COMMENT",
    "Changes": [
      {
        "Action": "UPSERT",
        "ResourceRecordSet": {
          "ResourceRecords": [
            {"Value": "$IP"}
          ],
          "Name": "$RECORD_SET",
          "Type": "$TYPE",
          "TTL": $TTL
        }
      }
    ]
  }
EOF

  aws route53 change-resource-record-sets \
      --hosted-zone-id "$ZONE_ID" \
      --change-batch "file://$TMP_FILE" >> "$LOG_FILE"
  echo "" >> "$LOG_FILE"
  rm "$TMP_FILE"
fi

echo "$IP" > "$IP_FILE"
