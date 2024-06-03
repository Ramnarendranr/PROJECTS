# Wordpress-website-launching
Launching a Wordpress website on UBUNTU (AWS EC2 server)


# WordPress Website Launch Documentation

This document provides a step-by-step guide to launching a WordPress website on an EC2 instance using Ubuntu on AWS.

## Table of Contents

                    1. Prerequisites
                    2. Launch EC2 Instance
                    3. Install Dependencies
                    4. Install WordPress
                    5. Configure Apache for WordPress
                    6. Configure Database
                    7. Configure WordPress to Connect to the Database
                    8. Final Configuration


### 1. Prerequisites

* AWS account
* Basic knowledge of AWS services
* Basic knowledge of Linux command line

### 2. Launch EC2 Instance

Follow AWS documentation to launch an EC2 instance with Ubuntu AMI.

### 3. Install Dependencies

Connect to the instance using the public IP and the private key in your terminal and execute the following commands:

```
sudo apt update
sudo apt install apache2 \
                 ghostscript \
                 libapache2-mod-php \
                 mysql-server \
                 php \
                 php-bcmath \
                 php-curl \
                 php-imagick \
                 php-intl \
                 php-json \
                 php-mbstring \
                 php-mysql \
                 php-xml \
                 php-zip
```

### 4. Install WordPress

Create the installation directory and download WordPress:
```
sudo mkdir -p /srv/www
sudo chown www-data: /srv/www
curl https://wordpress.org/latest.tar.gz | sudo -u www-data tar zx -C /srv/www
```

### 5. Configure Apache for WordPress

Create a site configuration for WordPress:

Create **/etc/apache2/sites-available/wordpress.conf** with the following content:
```
<VirtualHost *:80>
    DocumentRoot /srv/www/wordpress
    <Directory /srv/www/wordpress>
        Options FollowSymLinks
        AllowOverride Limit Options FileInfo
        DirectoryIndex index.php
        Require all granted
    </Directory>
    <Directory /srv/www/wordpress/wp-content>
        Options FollowSymLinks
        Require all granted
    </Directory>
</VirtualHost>
```

Enable the site, URL rewriting, and disable the default site:

```
sudo a2ensite wordpress
sudo a2enmod rewrite
sudo a2dissite 000-default
sudo service apache2 reload
```

### 6. Configure Database

Create MySQL database and user:
```
sudo mysql -u root
CREATE DATABASE wordpress;
CREATE USER wordpress@localhost IDENTIFIED BY '<your-password>';
GRANT SELECT,INSERT,UPDATE,DELETE,CREATE,DROP,ALTER ON wordpress.* TO wordpress@localhost;
FLUSH PRIVILEGES;
quit
```

Start MySQL service:
```
sudo service mysql start
```

### 7. Configure WordPress to Connect to the Database

Copy the sample configuration file and set database credentials:
```
sudo -u www-data cp /srv/www/wordpress/wp-config-sample.php /srv/www/wordpress/wp-config.php
```

Next, set the database credentials in the configuration file (do not replace database_name_here or username_here in the commands below. Do replace <your-password> with your database password.):
```
sudo -u www-data sed -i 's/database_name_here/wordpress/' /srv/www/wordpress/wp-config.php
sudo -u www-data sed -i 's/username_here/wordpress/' /srv/www/wordpress/wp-config.php
sudo -u www-data sed -i 's/password_here/<your-password>/' /srv/www/wordpress/wp-config.php
````

Edit the configuration file:
```
sudo -u www-data nano /srv/www/wordpress/wp-config.php
```

Replace the authentication keys and salts with secure values.
```
Find the following:

define( 'AUTH_KEY',         'put your unique phrase here' );
define( 'SECURE_AUTH_KEY',  'put your unique phrase here' );
define( 'LOGGED_IN_KEY',    'put your unique phrase here' );
define( 'NONCE_KEY',        'put your unique phrase here' );
define( 'AUTH_SALT',        'put your unique phrase here' );
define( 'SECURE_AUTH_SALT', 'put your unique phrase here' );
define( 'LOGGED_IN_SALT',   'put your unique phrase here' );
define( 'NONCE_SALT',       'put your unique phrase here' );

replace the above with

define('AUTH_KEY',         '`M%syb@=dv@|)O2))S -A^H%c3M-5#6|EhIGw||74z5gr9O4`-;za$u%Ak|TVqJ?');
define('SECURE_AUTH_KEY',  's3sBONFo8mH+9PlG|~%S~<w,*l~0w!}O-+ T#Iu/b;*l%:|{9K+&kM7*%KRH-)Eq');
define('LOGGED_IN_KEY',    '/<>xt C#;gaGC$qW{4{j5.)&>p>,yVXDQ[|df-aK|+_cpDgt]y6*4*EH_?Xa2-)_');
define('NONCE_KEY',        '^$=F-B+-|q3|b%W~_tL9G.r|BTrJ8YKt?@kSBWCfQdGW@r;{om$:u_{79IX;~XUE');
define('AUTH_SALT',        'u-DBlQoi&*e`PXd3WS/og_|h+F+]eoZEf]N&Eamqzf u**Lo=:gjBHhUFC?q~6NS');
define('SECURE_AUTH_SALT', 'IF8~2a/VFJHq@(N4J-S}Gtr?)SR+b=^4&P3Z}k8go4d*7Y G4Y:5U./`?=*$<N^j');
define('LOGGED_IN_SALT',   '_`-&D~d+JkB$%^06 dOmys|c:::[G]nc0]|-pM0j=bEDt``H^+Z?sHP@P`4wu#s:');
define('NONCE_SALT',       'g51S;<!-vKa510Bq7qIHfGS@Fq?k+3178w:Bd;DHY3@zMSSyB4=Ggt1hE(~6hh5,');
```

### 8. Final Configuration

Access WordPress using the public IP of the EC2 instance.
```
http://<ec2-instance-public-ip>
```


### MY EC2 instance


<img width="1470" alt="ec2-instance" src="https://github.com/Ramnarendranr/Wordpress-website-launching/assets/122247354/6916a970-811f-40eb-a681-8b49cb0bba57">


### My wordpress server launched from the public ip of the instance

<img width="1470" alt="wordpress" src="https://github.com/Ramnarendranr/Wordpress-website-launching/assets/122247354/4af72ae6-69cb-43ef-a21a-4faaa9471f1b">

