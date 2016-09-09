#!/bin/sh

touch log
~/host/babeld/babeld eth0 -d 1 > log
