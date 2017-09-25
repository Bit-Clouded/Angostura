# Letsencrypt Certbot for Route53

This container extends the official certbot container with AWS cli and required scripts to automate the certificate provisioning process.

Usage:

    docker run --rm \
        -e SUBDOMAIN=www \
        -e HOSTEDZONE=yourdomain.com \
        -v /etc/letsencrypt:/etc/letsencrypt \
        bitclouded/certbot-route53:<tag>

This will automatically add required TXT hostfile for acme dns challenge. After it validates, it'll deposit the result in the mapped folder.

Note this requires the following IAM permission.

    {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Action": [
                    "route53:ChangeResourceRecordSets",
                    "route53:ListHostedZones"
                ],
                "Effect": "Allow",
                "Resource": "*"
            }
        ]
    }

This is used throughout the infrastructure framework to provide end to end encryption into the server where needed.

Please note the operation of adding and removing the TXT entry R53 Hostedzone is NOT atomic and concurrent safe. If multiple servers apply for the same certificate at the same time, it is almost guaranteed to fail.

## How this works

The script invokes the manual dns challenge of type DNS-01 as described on the official [certbot documenation](https://certbot.eff.org/docs/using.html?highlight=dns#manual).

The [manual-auth-hook.sh](./manual-auth-hook.sh) is fed in and invoked to create the Route 53 TXT record. Note it also waits until the record is fully created before it exits the script.

Then the certbot proceeds with the rest of the certificate signing.