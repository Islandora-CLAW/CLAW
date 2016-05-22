#!/bin/sh
# Alpaca
echo "Building Alpaca"

HOME_DIR=$1

if [ -f "$HOME_DIR/islandora/install/configs/variables" ]; then
  . "$HOME_DIR"/islandora/install/configs/variables
fi

# Chown everything over to the vagrant user just in case
chown -R vagrant:vagrant "$HOME_DIR/.m2"

cd "$HOME_DIR"
git clone https://github.com/Islandora-CLAW/Alpaca.git
cd Alpaca

mvn -q install

# Chown everything over to the vagrant user just in case
chown -R vagrant:vagrant "$HOME_DIR/.m2"
chown -R vagrant:vagrant "$HOME_DIR/Alpaca"
