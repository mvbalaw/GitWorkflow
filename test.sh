#!/bin/sh +x

TESTS=./tests/*
for f in $TESTS
do
	"$f"
	if [ $? -ne 0 ]
	then
		echo "Error occurred!"
		exit 1
	fi
done