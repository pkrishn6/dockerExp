#!/bin/bash
#./cleanup.sh d_pkumar d_pkumar2 d_pkumar3
pushd $(pwd)
cd $SR_CODE_BASE/snaproute/src/mino-masterd
make
cd $SR_CODE_BASE/snaproute/src/mino-testd
make
popd
cp $SR_CODE_BASE/snaproute/src/out/bin/masterd .
cp $SR_CODE_BASE/snaproute/src/out/bin/testd .
sudo docker build --rm -t $USER:serf_base -f Dockerfile.base .
cp Dockerfile.master Dockerfile.temp
sed -i "s/USER/$USER/g" Dockerfile.temp
sudo docker build --rm -t $USER:serf_master -f Dockerfile.temp .
rm Dockerfile.temp
cp Dockerfile.test Dockerfile.temp
sed -i "s/USER/$USER/g" Dockerfile.temp
sudo docker build --rm -t $USER:serf_test -f Dockerfile.temp .
rm Dockerfile.temp
