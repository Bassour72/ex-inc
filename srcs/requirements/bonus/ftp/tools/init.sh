#!/bin/sh

set -e

FTP_PWD=$(cat /run/secrets/ftp_user_password)
echo "Mandatory directory for vsftpd to run.."
# mkdir -p /var/run/vsftpd/empty
echo "Create the FTP user..."

if ! id "$FTP_USER" >/dev/null 2>&1; then
    adduser -D -u 1000 -h /var/www/wordpress -s /bin/sh $FTP_USER
    echo "$FTP_USER:$FTP_PWD" | chpasswd
fi

echo "Fixing permissions for the WordPress volume..."
chown -R 1000:1000 /var/www/wordpress

find /var/www/wordpress -type d -exec chmod 775 {} \;
find /var/www/wordpress -type f -exec chmod 664 {} \;

chmod -R 777 /var/www/wordpress/wp-content

echo "Starting vsftpd on port 21..."
exec /usr/sbin/vsftpd /etc/vsftpd.conf



