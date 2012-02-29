#!/bin/sh +x
# hack: rebase your changes onto the latest changes from the remote branch

die () {
    echo >&2 "$@"
    exit 1
}

. "git.lib" || die 'unable to load git.lib library'

mode="live"
specifiedRemote=""
while getopts "tr:" optname
do
	case "$optname" in
		"r")
			specifiedRemote=$OPTARG
			echo "using specified remote branch: ${specifiedRemote}"
			;;
		"t")
			mode="test"
			;;
	esac
done

CURRENT="$(git branch | grep '\*' | awk '{print $2}')"
echo "current branch is: ${CURRENT}"
if [ ! -z "$specifiedRemote" ]
then
	remote=$specifiedRemote
else
	determine_remote_branch
fi
echo "remote branch is: ${remote}"
if [ -z "$remote" ]
then
	echo "Unable to determine remote branch. Consider specifying it e.g.: hack.sh -r master"
	echo "Please consider adding the ability to determine the correct remote branch given"
	echo "your current state and submit a patch."
	exit 1
fi
assert_working_on_feature_branch
require_clean_work_tree


if [ "$mode" == "test" ]
then
	echo "-- test complete --"
	exit 0
fi

set -x

# do the work
git checkout $remote
git pull origin $remote
git checkout ${CURRENT}
git rebase $remote
