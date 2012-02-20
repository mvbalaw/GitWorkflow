#!/bin/sh +x
# Git workflow ship script
CURRENT="$(git branch | grep '\*' | awk '{print $2}')"
echo "current branch is: ${CURRENT}"
remoteBranches="$(git branch -r | tr '/' ' ' | awk '{print $2}')"
for branch in ${remoteBranches}
do
	if [ "${CURRENT}" == "$(git branch --contains ${branch} | grep '\*' | awk '{print $2}')" ]
	then
		currentBranches="$(git branch --contains ${branch} | grep -v '\*' | awk '{print $1}')"
		remote="$(echo ${remoteBranches} ${currentBranches} | tr ' ' '\n' | sort | uniq -c | grep "2" | awk '{print $2}' | head -1)"
	fi
done
echo "remote branch is: ${remote}"
if [ "${CURRENT}" == "${remote}" -o "" == "${remote}" ] 
then
	echo "This command should be run from a feature branch, not from ${CURRENT}."
	exit 1;
fi
set -x
git checkout $remote
git merge ${CURRENT}
git push origin $remote
git checkout ${CURRENT}