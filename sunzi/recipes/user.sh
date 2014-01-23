if [ -d /home/$1 ]; then
  echo "$1 user already exists, skipping."
else
  useradd -m $1

  mkdir -p /home/$1/.ssh
  cp /root/.ssh/authorized_keys /home/$1/.ssh/authorized_keys
  chown -R $1:$1 /home/$1/.ssh
  chmod -R 700 /home/$1/.ssh

  mkdir -p /var/www
  chown -R $1:$1 /var/www
  chmod g+s /var/www
fi
