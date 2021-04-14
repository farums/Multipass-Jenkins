#!/usr/bin/env bash

pushd $(dirname 0)

function include(){
    source "$1" #source from deafult env file
    source "include/load.bash"
}

include "instance.env"
choose_action_from_menu $1







