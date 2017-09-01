#!/bin/bash
set -x
main() {
    echo "***** Spawn docker instances "
#   create_node <container_name> <docker_image_name> 
    create_node h1 ubuntu:trusty
    create_node n1 snapos/flex:latest
    create_node n1 snapos/flex:latest
    create_node h2 ubuntu:trusty 
    sleep 20
#   ++++++++++            ++++++++++              ++++++++++            ++++++++++
#   +        +            +        +              +        +            +        +
#   +   h1    if1------if2    n1    if3--------if4    n2    if5------if6    h2   +
#   +        +            +        +              +        +            +        +
#   ++++++++++            ++++++++++              ++++++++++            ++++++++++
#   create_link <intf1> <intf2> <node1> <node2>
    create_link if1 if2 h1 n1
    create_link if3 if4 n1 n2
    create_link if5 if6 n2 h2
    echo -e "done!\n"
}
function get_pid {
    echo `docker inspect -f '{{.State.Pid}}' $1`
}
function create_ns {
    mkdir -p /var/run/netns
    pid=$(get_pid $1)
    ln -s /proc/$pid/ns/net /var/run/netns/$pid
}
function create_link {
    ip link add $1 type veth peer name $2
    ip link set $1 netns $(get_pid $3)
    ip link set $2 netns $(get_pid $4)
}
function create_node {
    docker run -dt --privileged --log-driver=syslog --cap-add=ALL  --name $1 -P $2
    create_ns $1
}

