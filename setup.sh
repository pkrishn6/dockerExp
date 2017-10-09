#!/bin/bash
./cleanup.sh
cd $SR_CODE_BASE/snaproute/src/mino-masterd
make
cd $SR_CODE_BASE/snaproute/src/mino-testd
make
cd ~/dockerExp/
cp $out/masterd .
cp $out/testd .
sudo docker build --rm -t pkumar:serf_master -f Dockerfile.master .
sudo docker build --rm -t pkumar:serf_test -f Dockerfile.test .
