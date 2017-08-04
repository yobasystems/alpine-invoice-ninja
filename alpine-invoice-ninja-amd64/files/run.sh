#!/bin/ash

if [ ! -d /usr/html ] ; then
  mkdir -p /usr/html
  chown -R nginx:www-data /usr/html
else
  chown -R nginx:www-data /usr/html
fi

if [ ! -d /usr/html/app ] ; then
  curl -fLk -o /tmp/ninja.zip  "https://download.invoiceninja.com"
  mkdir /tmp/ninja-src
  unzip /tmp/ninja.zip -d /tmp/ninja-src
  mv -f /tmp/ninja-src/ninja/* /usr/html/
  rm -R /tmp/ninja*
  chown -R nginx:www-data /usr/html
else
  chown -R nginx:www-data /usr/html
fi

cp -fr /environment.env /usr/html/.env

sed -i "s,APP_ENV=production,APP_ENV=${APP_ENV},g" /usr/html/.env
sed -i "s,APP_DEBUG=false,APP_DEBUG=${APP_DEBUG},g" /usr/html/.env
sed -i "s,APP_URL=http://ninja.dev,APP_URL=${APP_URL},g" /usr/html/.env
sed -i "s,APP_KEY=randomappkey,APP_KEY=${APP_KEY},g" /usr/html/.env
sed -i "s,APP_CIPHER=rijndael-128,APP_CIPHER=${APP_CIPHER},g" /usr/html/.env
sed -i "s,API_SECRET=apisecret,API_SECRET=${API_SECRET},g" /usr/html/.env
sed -i "s,DB_TYPE=mysql,DB_TYPE=${DB_TYPE},g" /usr/html/.env
sed -i "s,DB_HOST=mysql,DB_HOST=${DB_HOST},g" /usr/html/.env
sed -i "s,DB_DATABASE=ninja,DB_DATABASE=${DB_DATABASE},g" /usr/html/.env
sed -i "s,DB_USERNAME=ninja,DB_USERNAME=${DB_USERNAME},g" /usr/html/.env
sed -i "s,DB_PASSWORD=dbpassword,DB_PASSWORD=${DB_PASSWORD},g" /usr/html/.env
sed -i "s,MAIL_DRIVER=smtp,MAIL_DRIVER=${MAIL_DRIVER},g" /usr/html/.env
sed -i "s,MAIL_HOST=smtp.gmail.com,MAIL_HOST=${MAIL_HOST},g" /usr/html/.env
sed -i "s,MAIL_USERNAME=invoiceninja@gmail.com,MAIL_USERNAME=${MAIL_USERNAME},g" /usr/html/.env
sed -i "s,MAIL_PASSWORD=smtppassword,MAIL_PASSWORD=${MAIL_PASSWORD},g" /usr/html/.env
sed -i "s,MAIL_PORT=587,MAIL_PORT=${MAIL_PORT},g" /usr/html/.env
sed -i "s,MAIL_ENCRYPTION=tls,MAIL_ENCRYPTION=${MAIL_ENCRYPTION},g" /usr/html/.env
sed -i "s,MAIL_FROM_ADDRESS=invoiceninja@gmail.com,MAIL_FROM_ADDRESS=${MAIL_FROM_ADDRESS},g" /usr/html/.env
sed -i "s,MAIL_FROM_NAME=invoiceninja,MAIL_FROM_NAME=${MAIL_FROM_NAME},g" /usr/html/.env


chown -R nginx:www-data /usr/html
# start php-fpm
mkdir -p /usr/logs/php-fpm
php-fpm7

# start nginx
mkdir -p /usr/logs/nginx
mkdir -p /tmp/nginx
chown nginx /tmp/nginx
nginx
