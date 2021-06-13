#!/bin/bash

TEMPDIR=/temp
FARMDIR=/farm
CONFDIR=/config
BINDIR=/madmax-plotter
AUTOSTART="no"

if [[ ! -d $TEMPDIR ]]; then
  echo "Temp directory does not exist. Please bind mount a volume with the docker '-v' option to '$TEMPDIR'."
  exit 1
fi
if [[ ! -d $FARMDIR ]]; then
  echo "Plots directory does not exist. Please bind mount a volume with the docker '-v' option to '$FARMDIR'."
  exit 1
fi
if [[ ! -d $CONFDIR ]]; then
  echo "Config directory does not exist. Please bind mount a volume with the docker '-v' option to '$CONFDIR'."
  exit 1
fi

# Always copy default config file
cp $BINDIR/plotter.cfg.default $CONFDIR/plotter.cfg.default

if [[ ! -f "$CONFDIR/plotter.cfg" ]]; then
  cp $BINDIR/plotter.cfg.default $CONFDIR/plotter.cfg
fi
ln -s $CONFDIR/plotter.cfg $BINDIR/plotter.cfg

if [[ ${AUTOSTART} == 'yes' ]]; then
  if cmp $CONFDIR/plotter.cfg.default $CONFDIR/plotter.cfg; then
    echo "Please edit $CONFDIR/plotter.cfg first".
    exit 1
  else
    ./start.sh
  fi
else
  echo "Call from docker shell: ./start.sh"
fi

while true; do sleep 30; done
