# Installs rbenv and ruby-build
if [ -d /usr/local/bin/ruby-build ]; then
  echo "ruby-build already installed"
else
  apt-get install -y \
    autoconf bison build-essential libssl-dev libyaml-dev \
    libreadline6 libreadline6-dev zlib1g zlib1g-dev

  git clone https://github.com/sstephenson/ruby-build.git
  ruby-build/install.sh
  rm -rf ruby-build
  ruby-build $1 $2
fi

# gem install bundler
gem install bundler
