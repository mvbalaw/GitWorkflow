#!/bin/sh +x

originUri="$(git remote -v | grep origin | head -1 | awk '{print $2}')"
echo "cloning ${originUri} ..."
mkdir temp
pushd temp >& /dev/null
git clone $originUri . >& /dev/null

TESTS=../tests/*
for f in $TESTS
do
	"$f"
	if [ $? -ne 0 ]
	then
		echo "Error occurred!"
		exit 1
	fi
done
popd >& /dev/null
rm -rf temp