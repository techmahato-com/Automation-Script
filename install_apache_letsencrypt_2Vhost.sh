#!/bin/bash

# Define domain names
DEV_DOMAIN="dev.techmahato.com"
PROD_DOMAIN="prod.techmahato.com"
YOUR_EMAIL="your_email@example.com"

# Step 1: Update and upgrade packages
sudo apt update
sudo apt upgrade -y

# Step 2: Install Apache HTTP Server
sudo apt install -y apache2
sudo systemctl enable apache2
sudo systemctl start apache2
sudo systemctl status apache2

# Step 3: Configure Firewall
sudo ufw allow OpenSSH
sudo ufw allow 'Apache Full'
sudo ufw enable

# Step 4: Create Apache Virtualhosts for dev.techmahato.com and prod.techmahato.com
sudo mkdir -p /var/www/html/$DEV_DOMAIN/
sudo mkdir -p /var/www/html/$PROD_DOMAIN/

# Create dev.techmahato.com virtualhost configuration
sudo tee /etc/apache2/sites-available/$DEV_DOMAIN.conf > /dev/null <<EOF
<VirtualHost *:80>
   ServerName $DEV_DOMAIN
   ServerAlias www.$DEV_DOMAIN
   ServerAdmin admin@$DEV_DOMAIN
   DocumentRoot /var/www/html/$DEV_DOMAIN
   ErrorLog \${APACHE_LOG_DIR}/$DEV_DOMAIN_error.log
   CustomLog \${APACHE_LOG_DIR}/$DEV_DOMAIN_access.log combined
   <Directory /var/www/html/$DEV_DOMAIN>
      Options FollowSymlinks
      AllowOverride All
      Require all granted
   </Directory>
</VirtualHost>
EOF

# Create prod.techmahato.com virtualhost configuration
sudo tee /etc/apache2/sites-available/$PROD_DOMAIN.conf > /dev/null <<EOF
<VirtualHost *:80>
   ServerName $PROD_DOMAIN
   ServerAlias www.$PROD_DOMAIN
   ServerAdmin admin@$PROD_DOMAIN
   DocumentRoot /var/www/html/$PROD_DOMAIN
   ErrorLog \${APACHE_LOG_DIR}/$PROD_DOMAIN_error.log
   CustomLog \${APACHE_LOG_DIR}/$PROD_DOMAIN_access.log combined
   <Directory /var/www/html/$PROD_DOMAIN>
      Options FollowSymlinks
      AllowOverride All
      Require all granted
   </Directory>
</VirtualHost>
EOF

# Enable the virtualhosts and required Apache modules
sudo a2ensite $DEV_DOMAIN.conf
sudo a2ensite $PROD_DOMAIN.conf
sudo a2enmod ssl rewrite
sudo systemctl restart apache2

# Step 5: Secure Apache with Let's Encrypt
sudo apt install -y certbot python3-certbot-apache
sudo certbot --apache --non-interactive --agree-tos --email $YOUR_EMAIL -d $DEV_DOMAIN -d www.$DEV_DOMAIN -d $PROD_DOMAIN -d www.$PROD_DOMAIN

# Step 6: Check SSL renewal status
sudo systemctl status certbot.timer
sudo certbot renew --dry-run

