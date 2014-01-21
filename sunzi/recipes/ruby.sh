source recipes/rbenv.sh

rbenv install $1
rbenv shell $1
gem install bundler
