#!/bin/sh +x

TESTS=./tests/*
for f in $TESTS
do
	"$f"
done