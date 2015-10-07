#!/bin/bash
set -e

if [ "$1" = 'runsvdir' ]; then
  # Ensure that www-data user has permission to write to the uploads
  # directory. This will make it owned by a weird user on your host.
  # Sorry.
  chown -R www-data:www-data /var/www/foodcoop/wordpress/foodcoop-test/wp-content/uploads
  set -- "$@" -P /etc/service

  # Ensure all of our services are properly symlinked so they will start.
  [ ! -f /etc/service/mysql ] && ln -s /etc/sv/mysql /etc/service/mysql
  [ ! -f /etc/service/apache ] && ln -s /etc/sv/apache /etc/service/apache
  [ ! -f /etc/service/node ] && ln -s /etc/sv/node /etc/service/node
fi

exec "$@"
