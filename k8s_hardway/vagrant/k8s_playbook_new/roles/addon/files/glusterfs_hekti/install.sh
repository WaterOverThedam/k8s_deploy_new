#!/bin/bash

export HEKETI_CLI_SERVER=http://localhost:8080
heketi-cli --user admin --secret 'My Secret' topology load --json=topology.json
