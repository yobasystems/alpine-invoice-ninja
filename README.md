# Invoice Ninja Docker image running on Alpine Linux

[![Docker Layers](https://img.shields.io/badge/docker%20layers-8-blue.svg?maxAge=2592000?style=flat-square)](https://hub.docker.com/r/yobasystems/alpine-nginx/) [![Docker Size](https://img.shields.io/badge/docker%20size-55%20MB-blue.svg?maxAge=2592000?style=flat-square)](https://hub.docker.com/r/yobasystems/alpine-nginx/) [![Docker Stars](https://img.shields.io/docker/stars/yobasystems/alpine-invoice-ninja.svg?maxAge=2592000?style=flat-square)](https://hub.docker.com/r/yobasystems/alpine-nginx/) [![Docker Pulls](https://img.shields.io/docker/pulls/yobasystems/alpine-invoice-ninja.svg?maxAge=2592000?style=flat-square)](https://hub.docker.com/r/yobasystems/alpine-nginx/)

[![Alpine Version](https://img.shields.io/badge/alpine%20version-v3.8.0-green.svg?maxAge=2592000?style=flat-square)](http://alpinelinux.org/) [![Invoice Ninja Version](https://img.shields.io/badge/nginx%20version-v4.5.3-green.svg?maxAge=2592000?style=flat-square)](http://nginx.org/en/)



This Docker image [(yobasystems/alpine-invoice-ninja)](https://hub.docker.com/r/yobasystems/alpine-invoice-ninja/) is based on the minimal [Alpine Linux](http://alpinelinux.org/) with version 4.5.3 of [Invoice Ninja](https://github.com/invoiceninja/invoiceninja)

##### Alpine Version 3.8.0 (Released June 26, 2018)
##### Invoice Ninja Version 4.5.3

----

## What is Alpine Linux?
Alpine Linux is a Linux distribution built around musl libc and BusyBox. The image is only 5 MB in size and has access to a package repository that is much more complete than other BusyBox based images. This makes Alpine Linux a great image base for utilities and even production applications. Read more about Alpine Linux here and you can see how their mantra fits in right at home with Docker images.

## What is Invoice Ninja?
Invoice Ninja is a free, open-source solution for invoicing and billing customers. With Invoice Ninja, you can easily build and send beautiful invoices from any device that has access to the web. Your clients can print your invoices, download them as pdf files, and even pay you online from within the system.

## Features

  * Minimal size only
    * 55 MB and only 8 layers
  * Memory usage is minimal on a simple install


## Architectures

* ```:amd64```, ```:latest``` - 64 bit Intel/AMD (x86_64/amd64)
* ```:i386```, ```:x86``` - 32 bit Intel/AMD (x86/i686)
* ```:arm64v8```, ```:aarch64``` - 64 bit ARM (ARMv8/aarch64)
* ```:arm32v7```, ```:armhf``` - 32 bit ARM (ARMv7/armhf)

#### PLEASE CHECK TAGS BELOW FOR SUPPORTED ARCHITECTURES, THE ABOVE IS A LIST OF EXPLANATION

## Tags

* ```:latest```, ```:amd64``` latest branch based on amd64
* ```:master``` master branch usually inline with latest
* ```:v0.0.0``` version number related to docker version
* ```:armhf```, ```:arm32v7``` Armv7 based on latest tag but arm architecture


## FOR SQL SERVER

If you need to manually create the user and db

```
CREATE DATABASE ninjadb;
CREATE USER 'ninjauser'@'localhost' IDENTIFIED BY 'ninjapassword';
GRANT ALL PRIVILEGES ON * . * TO 'ninjauser'@'localhost';
```

```
GRANT ALL PRIVILEGES ON *.* TO 'ninjauser'@'192.168.%.%' IDENTIFIED BY 'ninjapassword' WITH GRANT OPTION;
```


## FOR SSL

To prevent the redirection loop when behind SSL terminated proxy (HAPROXY) add last line to the /etc/nginx/nginx.conf file

```
location ~ \.php$ {
    fastcgi_split_path_info ^(.+\.php)(/.+)$;
    fastcgi_pass backend;
    fastcgi_index index.php;
    include fastcgi_params;
    fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
    fastcgi_intercept_errors off;
    fastcgi_buffer_size 16k;
    fastcgi_buffers 4 16k;
    fastcgi_param HTTPS on;
  }
```

## Recurring invoices and reminder emails

Create a cron to call the ninja:send-invoices and ninja:send-reminders Artisan commands once daily.

```
0 8 * * * /usr/local/bin/php /usr/html/artisan ninja:send-invoices
0 8 * * * /usr/local/bin/php /usr/html/artisan ninja:send-reminders
```


## Generate API KEYS

The keys ideally need to be 32 characters long.

AES-256 is different from RIJNDAEL-256. The 256 in AES refers to the key size, where the 256 in RIJNDAEL refers to block size. AES-256 is RIJNDAEL-128 when used with a 256 bit key. All variants of AES use a 128-bit block size with varying key lengths (128, 192, or 256). This means that MCRYPT_RIJNDAEL_128 is the only correct choice if you want AES.

Run the following command, substituting 'supersecret' with a value to generate a key;

```
openssl enc -aes-128-cbc -k supersecret -P -md sha1
```

```
openssl enc -aes-128-cbc -k dHiHsYwTmHtSi5kegrhgn5tVwICTHc -P -md sha1
```

## ENV VARS

```
APP_ENV=production
APP_DEBUG=false
APP_URL=http://ninja.dev
APP_KEY=SomeRandomStringSomeRandomString
APP_CIPHER=rijndael-128

DB_TYPE=mysql
DB_STRICT=false
DB_HOST=localhost
DB_DATABASE=ninja
DB_USERNAME=ninja
DB_PASSWORD=ninja

MAIL_DRIVER=smtp
MAIL_PORT=587
MAIL_ENCRYPTION=tls
MAIL_HOST
MAIL_USERNAME
MAIL_FROM_ADDRESS
MAIL_FROM_NAME
MAIL_PASSWORD

MAILGUN_DOMAIN=
MAILGUN_SECRET=

#POSTMARK_API_TOKEN=

PHANTOMJS_CLOUD_KEY='a-demo-key-with-low-quota-per-ip-address'
#PHANTOMJS_BIN_PATH=/usr/local/bin/phantomjs

LOG=single
REQUIRE_HTTPS=false
API_SECRET=password
IOS_DEVICE=
ANDROID_DEVICE=
FCM_API_TOKEN=

#TRUSTED_PROXIES=

#SESSION_DRIVER=
#SESSION_DOMAIN=
#SESSION_ENCRYPT=
#SESSION_SECURE=

#CACHE_DRIVER=
#CACHE_HOST=
#CACHE_PORT1=
#CACHE_PORT2=

#GOOGLE_CLIENT_ID=
#GOOGLE_CLIENT_SECRET=
#GOOGLE_OAUTH_REDIRECT=http://ninja.dev/auth/google

GOOGLE_MAPS_ENABLED=true
#GOOGLE_MAPS_API_KEY=

#S3_KEY=
#S3_SECRET=
#S3_REGION=
#S3_BUCKET=

#RACKSPACE_USERNAME=
#RACKSPACE_KEY=
#RACKSPACE_CONTAINER=
#RACKSPACE_REGION=

#RACKSPACE_TEMP_URL_SECRET=

# If this is set to anything, the URL secret will be set the next
# time a file is downloaded through the client portal.
# Only set this temporarily, as it slows things down.
#RACKSPACE_TEMP_URL_SECRET_SET=

#DOCUMENT_FILESYSTEM=

#MAX_DOCUMENT_SIZE # KB
#MAX_EMAIL_DOCUMENTS_SIZE # Total KB
#MAX_ZIP_DOCUMENTS_SIZE # Total KB (uncompressed)
#DOCUMENT_PREVIEW_SIZE # Pixels

WEPAY_CLIENT_ID=
WEPAY_CLIENT_SECRET=
WEPAY_ENVIRONMENT=production # production or stage
WEPAY_AUTO_UPDATE=true # Requires permission from WePay
WEPAY_ENABLE_CANADA=true
WEPAY_FEE_PAYER=payee
WEPAY_APP_FEE_MULTIPLIER=0.002
WEPAY_APP_FEE_FIXED=0
WEPAY_THEME='{"name":"Invoice Ninja","primary_color":"0b4d78","secondary_color":"0b4d78","background_color":"f8f8f8","button_color":"33b753"}' # See https://www.wepay.com/developer/reference/structures#theme

BLUEVINE_PARTNER_UNIQUE_ID=
BLUEVINE_PARTNER_TOKEN=
```

## Creating an instance

To use this image make sure you have a linked mysql database, e.g yobasystems/alpine-mariadb

## Docker Compose example:

```yalm
version: '2'
services:
  invoice-ninja:
    image: yobasystems/alpine-invoice-ninja
    environment:
      API_SECRET: JBG5ghf23ddrw3DRSXDFFDhgf4fvy7uy
      APP_CIPHER: rijndael-128
      APP_DEBUG: 'false'
      APP_ENV: production
      APP_KEY: base64:hjfhgYR9ik54E00RFe3fttfr+ttre334ertjiuHGFDF=
      APP_URL: http://ninja.dev
      DB_DATABASE: ninjadb
      DB_HOST: invoice-ninja-db
      DB_PASSWORD: hgearfngfgvetr45wrXC4bnuybt5rvecsfscrwer
      DB_TYPE: mysql
      DB_USERNAME: ninjauser
      INVOICENINJA_VERSION: 3.5.1
      MAIL_DRIVER: smtp
      MAIL_ENCRYPTION: tls
      MAIL_FROM_ADDRESS: accounts@gmail.com
      MAIL_FROM_NAME: '"Accounts"'
      MAIL_HOST: smtp.gmail.com
      MAIL_PASSWORD: BEFGHgfdfsw2dfddSvbgkjli8Hhtbry4rjhdtf667yt
      MAIL_PORT: '587'
      MAIL_USERNAME: accounts@gmail.com
    stdin_open: true
    volumes:
    - /data/invoice-ninja/html:/usr/html
    tty: true
    links:
    - invoice-ninja-db:invoice-ninja-db

  invoice-ninja-db:
    image: yobasystems/alpine-mariadb:latest
    environment:
      MYSQL_DATABASE: ninjadb
      MYSQL_PASSWORD: hgearfngfgvetr45wrXC4bnuybt5rvecsfscrwer
      MYSQL_ROOT_PASSWORD: hgearfngfgvetr45wrXC4bnuybt5rvecsfscrweR
      MYSQL_USER: ninjauser
    stdin_open: true
    volumes:
    - /data/invoice-ninja/sql:/var/lib/mysql
    tty: true

```

## Source Repository

* [Bitbucket - yobasystems/alpine-nginx](https://bitbucket.org/yobasystems/alpine-invoice-ninja/)

* [Github - yobasystems/alpine-nginx](https://github.com/yobasystems/alpine-invoice-ninja)

## Links

* [Yoba Systems](https://www.yobasystems.co.uk/)

* [Dockerhub - yobasystems](https://hub.docker.com/u/yobasystems/)

* [Quay.io - yobasystems](https://quay.io/organization/yobasystems)
