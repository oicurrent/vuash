user=$1

if [ -d /home/$user ]; then
  echo "$user user already exists, skipping."
else
  useradd -m $user

  mkdir -p /home/$user/.ssh
  cp /root/.ssh/authorized_keys /home/$user/.ssh/authorized_keys
  chown -R $user:$user /home/$user/.ssh
  chmod -R 700 /home/$user/.ssh
fi
