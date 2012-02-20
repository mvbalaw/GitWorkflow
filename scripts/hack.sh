#!/bin/sh +x
# hack: rebase your changes onto the latest changes from the remote branch

require_clean_work_tree () {
	# http://stackoverflow.com/questions/3878624/how-do-i-programmatically-determine-if-there-are-uncommited-changes
    # Update the index
    git update-index -q --ignore-submodules --refresh
    err=0

    # Disallow unstaged changes in the working tree
    if ! git diff-files --quiet --ignore-submodules --
    then
        echo >&2 "cannot $1: you have unstaged changes."
        git diff-files --name-status -r --ignore-submodules -- >&2
        err=1
    fi

    # Disallow uncommitted changes in the index
    if ! git diff-index --cached --quiet HEAD --ignore-submodules --
    then
        echo >&2 "cannot $1: your index contains uncommitted changes."
        git diff-index --cached --name-status -r --ignore-submodules HEAD -- >&2
        err=1
    fi

    if [ $err = 1 ]
    then
        echo >&2 "Please commit or stash them."
        exit 1
    fi
}

determine_remote_branch () {
	remoteBranches="$(git branch -r | grep -v 'HEAD' | tr '/' ' ' | awk '{print $2}')"
	for branch in ${remoteBranches}
	do
	    if [ "${CURRENT}" == "${branch}" ] 
		then
			remote=""
			return
		fi
	done
	for branch in ${remoteBranches}
	do
		if [ "${CURRENT}" == "$(git branch --contains ${branch} | grep '\*' | awk '{print $2}')" ]
		then
			remote=$branch
			return
		fi
	done
	if [ "" == "${remote}" ] 
	then
		currentBranches="$(git branch --contains ${CURRENT} | grep -v '\*' | awk '{print $1}')"
		remote="$(echo ${remoteBranches} ${currentBranches} | tr ' ' '\n' | sort | uniq -c | grep "2" | awk '{print $2}' | head -1)"
	fi
}

assert_working_on_feature_branch () {
	if [ "${CURRENT}" == "${remote}" -o "" == "${remote}" ] 
	then
		echo "This command should be run from a feature branch, not from ${CURRENT}."
		exit 1;
	fi
}

require_clean_work_tree
CURRENT="$(git branch | grep '\*' | awk '{print $2}')"
echo "current branch is: ${CURRENT}"
determine_remote_branch
echo "remote branch is: ${remote}"
assert_working_on_feature_branch
set -x

# do the work
git checkout $remote
git pull origin $remote
git checkout ${CURRENT}
git rebase $remote
