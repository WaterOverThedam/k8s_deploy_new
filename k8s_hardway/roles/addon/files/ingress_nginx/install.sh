#!/bin/bash


ls -l|grep yml|awk '{print "kubectl apply -f "$NF}'|sh
