#!/bin/bash

TEMPDIR=/temp
PLOTSDIR=/plots
CONFDIR=/config
BINDIR=/Swar-Chia-Plot-Manager
AUTOSTART="no"

if [[ ! -d $TEMPDIR ]]; then
  echo "Temp directory does not exist. Please bind mount a volume with the docker '-v' option to '$TEMPDIR'."
  exit 1
fi
if [[ ! -d $PLOTSDIR ]]; then
  echo "Plots directory does not exist. Please bind mount a volume with the docker '-v' option to '$PLOTSDIR'."
  exit 1
fi
if [[ ! -d $CONFDIR ]]; then
  echo "Config directory does not exist. Please bind mount a volume with the docker '-v' option to '$CONFDIR'."
  exit 1
fi

# Always copy default config file
cp $BINDIR/config.yaml.default $CONFDIR/config.yaml.default

if [[ ! -f "$CONFDIR/config.yaml" ]]; then
  cp $BINDIR/config.yaml.default $CONFDIR/config.yaml
fi
ln -s $CONFDIR/config.yaml $BINDIR/config.yaml

if [[ ! -f "$CONFDIR/manager.log" ]]; then
  touch $CONFDIR/manager.log
fi
ln -s $CONFDIR/manager.log $BINDIR/manager.log

cd /chia-blockchain
. ./activate

if [[ ${AUTOSTART} == 'yes' ]]; then
  if cmp $CONFDIR/config.yaml.default $CONFDIR/config.yaml; then
    echo "Please edit $CONFDIR/config.yaml first".
    echo "Call from docker shell: python manager.py start"
  else
    python manager.py start
  fi
else
  echo "Call from docker shell: python manager.py start"
fi

echo "Call from docker shell: python manager.py view"

while true; do sleep 30; done
