#!/bin/sh

certbot -d $SUBDOMAIN.$HOSTEDZONE \
        --manual --preferred-challenges dns-01 certonly \
        --register-unsafely-without-email --agree-tos --manual-public-ip-logging-ok \
        --manual-auth-hook /bc/manual-auth-hook.sh \
        --manual-cleanup-hook /bc/manual-cleanup-hook.sh