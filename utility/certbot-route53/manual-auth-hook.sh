#!/bin/sh

sed -i "s/{{VALIDATION_STRING}}/$CERTBOT_VALIDATION/g" ./change-resource-record-sets.json
sed -i "s/{{VALIDATION_DOMAIN}}/$CERTBOT_DOMAIN/g" ./change-resource-record-sets.json

HOSTEDZONE_ID=$(aws route53 list-hosted-zones \
        | jq -r ".HostedZones[] | select(.Name == \"$HOSTEDZONE.\") | .Id" \
        | cut -d'/' -f3)
ACTION_ID=$(aws route53 change-resource-record-sets \
        --hosted-zone-id $HOSTEDZONE_ID \
        --change-batch file://change-resource-record-sets.json \
        | jq '.ChangeInfo.Id' -r)
aws route53 wait resource-record-sets-changed --id $ACTION_ID