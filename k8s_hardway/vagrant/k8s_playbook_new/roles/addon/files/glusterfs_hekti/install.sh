#!/bin/bash


path=$0
HOME=${path%/*}
[ "$HOME" == "$path" ] && HOME="$(pwd)"

export HEKETI_CLI_SERVER=http://localhost:8080
heketi-cli --user admin --secret 'My Secret' topology load --json=${HOME}/topology.json
