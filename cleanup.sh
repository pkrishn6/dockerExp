#!/bin/bash
for dkr in "$@"
do
  sudo docker kill $dkr
  sudo docker rm $dkr
done
sudo docker rmi $USER:serf_master
sudo docker rmi $USER:serf_test
