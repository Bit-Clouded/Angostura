ARG NGINX_BASE=alpine
ARG NGINX_BASE_DIGEST=

FROM nginx:$NGINX_BASE$NGINX_BASE_DIGEST

RUN apt-get update -q && \
    apt-get install -y -q unzip curl sudo && \
    apt-get install -y -q git mercurial subversion python-pygments dpkg-dev && \
    apt-get install -y -q php7.0 php7.0-mysql php7.0-gd php7.0-dev php7.0-curl php7.0-cli php7.0-json php7.0-fpm
	
RUN mkdir /home/local && mkdir /home/local/storage
WORKDIR /home/local

ADD ./phabricator ./
ADD ./arcanist ./
ADD ./libphutil ./

ADD ./phabricator.conf /etc/nginx/conf.d/default.conf
ADD ./init.sh ./
ADD ./preamble.php /home/local/phabricator/support/
RUN chmod +x ./init.sh

CMD ["/home/local/init.sh"]
