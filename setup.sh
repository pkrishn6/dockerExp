#!/bin/bash
./cleanup.sh
pushd $(pwd)
cd $SR_CODE_BASE/snaproute/src/mino-masterd
make
cd $SR_CODE_BASE/snaproute/src/mino-testd
make
popd
cp $SR_CODE_BASE/snaproute/src/out/bin/masterd .
cp $SR_CODE_BASE/snaproute/src/out/bin/testd .
sudo docker build --rm -t $USER:serf_master -f Dockerfile.master .
sudo docker build --rm -t $USER:serf_test -f Dockerfile.test .
