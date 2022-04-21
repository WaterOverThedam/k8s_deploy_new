#!/bin/bash

heketi_cli volume list|awk '{print "heketi_cli volume delete "gensub("Id:","","g",$1)}'|sh
