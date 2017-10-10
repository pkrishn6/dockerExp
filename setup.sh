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
if [[ "$(sudo docker images -q $USER:serf_base 2> /dev/null)" == "" ]]; then
   sudo docker build --rm -t $USER:serf_base -f Dockerfile.base .
fi

# This will work only when the docker containers are running.
sudo docker ps | grep $USER | grep serf_master | awk -F " " '{print $1}' | xargs sudo docker rm -f

sudo docker ps | grep $USER | grep serf_test | awk -F " " '{print $1}' | xargs sudo docker rm -f

sudo docker rmi $USER:serf_master
sudo docker rmi $USER:serf_test

cp Dockerfile.master Dockerfile.temp
sed -i "s/USER/$USER/g" Dockerfile.temp
sudo docker build --rm -t $USER:serf_master -f Dockerfile.temp .
rm Dockerfile.temp
cp Dockerfile.test Dockerfile.temp
sed -i "s/USER/$USER/g" Dockerfile.temp
sudo docker build --rm -t $USER:serf_test -f Dockerfile.temp .
rm Dockerfile.temp
