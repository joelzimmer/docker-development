FROM my-jessie:latest
MAINTAINER Jamie McClelland <jamie@progressivetech.org>
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
  apt-get install -y \
  php5-mysql \
  php-apc \
  mysql-server \
  mysql-client \
  bzip2 \
  libapache2-mod-php5 \
  runit \
  git \
  lsb-release \
  acl \
  wget \
  unzip \
  php5-cli \
  php5-imap \
  php5-ldap \
  php5-curl \
  php5-intl \
  php5-gd \
  nodejs \
  sudo \
  vim \
  npm \
  php5-mcrypt \
  apache2 \
  nodejs-legacy 

# Avoid key buffer size warnings and myisam-recover warnings
# See: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=751840
RUN sed -i "s/^key_buffer\s/key_buffer_size\t/g" /etc/mysql/my.cnf
RUN sed -i "s/^myisam-recover\s/myisam-recover-options\t/g" /etc/mysql/my.cnf

# Avoid Apache complaint about server name
RUN echo "ServerName foodcoop.local" > /etc/apache2/conf-available/foodcoop.conf
RUN a2enconf foodcoop 

# Wordpress wants mod rewrite.
RUN a2enmod rewrite

# We don't want to ever send email. But we also don't want an error when 
# when wordpress tries. 
RUN ln -s /bin/true /usr/sbin/sendmail

# Checkout code. 
## This is disabled since we can't checkout the code anonymously
#RUN cd /var/www/foodcoop && git clone --recursive https://github.com/foodcoop/foodcoop-test.git wordpress
#RUN cd /var/www/foodcop && git clone https://github.com/foodcoop/foodcoop-api.git api

## Install node dependencies
#RUN cd /var/www/foodcoop/api && npm install

# Overwrite config files
#COPY wp-config.php /var/www/foodcoop/wordpress/
#COPY config.json /var/www/foodcoop/api/

# Configure apache 
COPY wordpress.apache.conf /etc/apache2/sites-available/wordpress.apache.conf
RUN a2ensite wordpress.apache.conf

# Stop apache and mysql. We will run them via runit
RUN /etc/init.d/apache2 stop
RUN /etc/init.d/mysql stop

# Handle service starting with runit.
RUN mkdir /etc/sv/mysql /etc/sv/apache /etc/sv/node
COPY mysql.run /etc/sv/mysql/run
COPY apache.run /etc/sv/apache/run
COPY node.run /etc/sv/node/run

# The symlinks in /etc/service will be created by the entrypoint script.
# That way we avoid errors since node won't be able to properly start until
# the directory is mounted from the host.

# Handle initializing the data
# init.sql sets up the databases with the minimal data (creates databases
# creates user/permissions). The developer must run /root/import-data before
# they can begin developing.
COPY init.sql /etc/sv/mysql/init.sql
COPY import-data /root/import-data
RUN wget --show-progress --progress=dot:giga -q -O /tmp/members.sql https://www.dropbox.com/s/tbzw4lwqqkyoso2/membership_obfuscated_20140722.sql?dl=0 
RUN wget --show-progress --progress=dot:giga -q -O /tmp/wordpress.sql.gz https://www.dropbox.com/s/o616lav11ydxzj9/foodcoop-test.sql.gz?dl=0 
RUN gunzip /tmp/wordpress.sql.gz

# Create the directory that will be mounted on the host.
RUN mkdir -p /var/www/foodcoop

COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["runsvdir"]
