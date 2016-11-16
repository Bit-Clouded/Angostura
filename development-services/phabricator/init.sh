#!/bin/bash

mkdir -p /home/local/storage/repos/
REPO_DIR=/home/local/storage/repos/

cd /home/local/phabricator/bin/
./config set phd.user daemon-user
./config set phabricator.timezone $PHAB_TIMEZONE
./config set diffusion.allow-http-auth true
./config set pygments.enabled true
./config set metamta.mail-adapter PhabricatorMailImplementationAmazonSESAdapter
./config set metamta.default-address $MAIL_ADDRESS
./config set amazon-ses.access-key $IAM_KEY
./config set amazon-ses.secret-key $IAM_SECRET
./config set amazon-ses.endpoint email.$SES_REGION.amazonaws.com
./config set repository.default-local-path $REPO_DIR
./config set mysql.user $DB_USERNAME
./config set mysql.pass $DB_PASSWORD
./config set mysql.host $DB_ENDPOINT
./config set phabricator.base-uri "https://$PHAB_HOSTNAME/"
./storage upgrade -f

ln -s /usr/lib/git-core/git-http-backend /home/local/phabricator/support/bin/git-http-backend
echo "www-data ALL=(daemon-user) SETENV: NOPASSWD: /usr/lib/git-core/git-http-backend, /usr/bin/hg" >> /etc/sudoers
sed -i -e 's/;opcache.validate_timestamps=1/opcache.validate_timestamps=0/g' /etc/php5/fpm/php.ini
sed -i -e 's/;always_populate_raw_post_data = -1/always_populate_raw_post_data = -1/g' /etc/php5/fpm/php.ini
sed -i -e 's/post_max_size = 8M/post_max_size = 500M/g' /etc/php5/fpm/php.ini
sed -i -e 's/listen = \/var\/run\/php5-fpm.sock/listen = localhost:9000/g' /etc/php5/fpm/pool.d/www.conf
service php5-fpm restart

useradd daemon-user
mkdir /home/daemon-user
chown daemon-user /home/daemon-user
chown daemon-user $REPO_DIR -R
sudo -iu daemon-user /home/local/phabricator/bin/phd start

nginx -g "daemon off;"
