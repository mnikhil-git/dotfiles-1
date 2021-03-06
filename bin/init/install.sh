#!/bin/bash

# Bootstrap a fresh Debian install based on my dotfiles and gems/debs lists.

set -e -u

ME=$1

cd /home/$ME/bin/init

# um... dude?
update-alternatives --install /usr/bin/ruby ruby /usr/bin/ruby1.9.1 500
update-alternatives --install /usr/bin/gem gem /usr/bin/gem1.9.1 500
update-alternatives --install /usr/bin/irb irb /usr/bin/irb1.9.1 500

# don't write atimes
chattr +A /

echo "Installing packages via apt-get and rubygems..."

apt-get install -y $(ruby -ryaml -e "puts YAML.load_file('debs.yml').join ' '")

if [ "$DISPLAY" != "" ] ; then
  apt-get install -y \
    $(ruby -ryaml -e "puts YAML.load_file('gui-debs.yml').join ' '")
  gem install --no-rdoc --no-ri \
    $(ruby -ryaml -e "puts YAML.load_file('gems.yml').join ' '")
  cp xsession.desktop /usr/share/xsessions/xsession.desktop

  # No thank you:
  rm -rf Desktop Documents Music Pictures Public Templates Videos Downloads

  ./nix.sh $ME
fi

if [ -f /etc/mpd.conf ]; then
    sed -i "s/var\/lib\/mpd\/music/home\/phil\/music/" /etc/mpd.conf
fi

if [ ! -x /usr/bin/heroku ]; then
  wget -qO- https://toolbelt.heroku.com/install.sh | sh
fi

sudo -u $ME gconftool --load $HOME/.gconf.xml

echo "All done! Happy hacking."
