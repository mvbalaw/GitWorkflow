#!/bin/sh +x

originUri="$(git remote -v | grep origin | head -1 | awk '{print $2}')"
echo "cloning ${originUri} ..."
if [ -e temp ]
then
	rm -rf temp
fi
mkdir temp
pushd temp >& /dev/null
git clone $originUri . >& /dev/null

TESTS=../tests/*
for f in $TESTS
do
	"$f"
	if [ $? -ne 0 ]
	then
		printf '\nError occurred!'
		exit 1
	fi
done
popd >& /dev/null
rm -rf temp