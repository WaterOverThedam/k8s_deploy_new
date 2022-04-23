#!/bin/sh

export ANSIBLE_TIMEOUT=60
vagrant up --no-provision "${@}" \
    && vagrant provision --provision-with shell \
    && vagrant provision --provision-with ansible \

# if [ $? -eq 0 ] && [[ "x$(vagrant plugin list | grep sahara)" != "x" ]]; then
#   vagrant sandbox on
# fi
