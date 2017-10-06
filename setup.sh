#!/bin/bash
./cleanup.sh
cd $opticd/../mino-masterd/
make
cd $opticd/../mino-testd/
make
cd /home/pkumar/dockerExp/
cp $out/masterd .
cp $out/testd .
sudo docker build --rm -t pkumar:serf_master -f Dockerfile.master .
sudo docker build --rm -t pkumar:serf_test -f Dockerfile.test .
