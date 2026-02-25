#!/bin/bash

# ==============================
# WordPress Farsi Auto Installer
# ==============================

DOMAIN=
DB_NAME="wp"
DB_USER="wpuser"
DB_PASS="123456789"

echo "Updating system..."
apt update -y

echo "Installing packages..."
apt install -y nginx mariadb-server php-fpm php-mysql wget unzip curl

echo "Creating database..."
mysql -u root <<EOF
CREATE DATABASE IF NOT EXISTS $DB_NAME;
CREATE USER IF NOT EXISTS '$DB_USER'@'localhost' IDENTIFIED BY '$DB_PASS';
GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'localhost';
FLUSH PRIVILEGES;
EXIT;
EOF

echo "Downloading WordPress Farsi..."
cd /var/www/
rm -rf wordpress latest-fa_IR.tar.gz
wget https://fa.wordpress.org/latest-fa_IR.tar.gz
tar -xzf latest-fa_IR.tar.gz

chown -R www-data:www-data wordpress
chmod -R 755 wordpress

PHPV=$(php -r "echo PHP_MAJOR_VERSION.'.'.PHP_MINOR_VERSION;")

echo "Configuring Nginx..."
cat > /etc/nginx/sites-available/wp <<EOL
server {
    listen 80;
    server_name $DOMAIN;

    root /var/www/wordpress;
    index index.php;

    location / {
        try_files \$uri \$uri/ /index.php?\$args;
    }

    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/run/php/php${PHPV}-fpm.sock;
    }
}
EOL

ln -sf /etc/nginx/sites-available/wp /etc/nginx/sites-enabled/wp
rm -f /etc/nginx/sites-enabled/default

nginx -t && systemctl restart nginx

echo "Installation complete!"
echo "Open: http://$DOMAIN"
