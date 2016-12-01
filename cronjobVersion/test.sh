#!/bin/bash

myLine=$(grep johcembafasdfadsfadsdasf ../etc/passwd)

echo "-->${myLine}<--"

if [ "$myLine" == "" ]; then
	echo "it is null (i.e. \"\")"
else
	echo "false, it is definitely NOT null"
fi
