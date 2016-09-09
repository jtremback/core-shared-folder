#!/bin/sh

touch babel_log
~/host/babeld/babeld eth0 -d 1 > babel_log
