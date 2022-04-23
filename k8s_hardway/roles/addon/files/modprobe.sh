#!/bin/bash


modprobe dm_snapshot && lsmod | grep dm_snapshot
modprobe dm_mirror && lsmod | grep dm_mirror
modprobe dm_thin_pool && lsmod | grep dm_thin_pool
