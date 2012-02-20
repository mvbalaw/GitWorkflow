#!/bin/sh +x
# ship: fast forward merge and push your changes to the remote branch

die () {
    echo >&2 "$@"
    exit 1
}

. "git.lib" || die 'unable to load git.lib library'

require_clean_work_tree
CURRENT="$(git branch | grep '\*' | awk '{print $2}')"
echo "current branch is: ${CURRENT}"
determine_remote_branch
echo "remote branch is: ${remote}"
assert_working_on_feature_branch

mode="live"
while getopts "t" optname
do
	case "$optname" in
		"t")
			mode="test"
			;;
	esac
done

if [ "$mode" == "test" ]
then
	echo "-- test complete --"
	exit 0
fi

set -x

# do the work
git checkout $remote
git merge ${CURRENT}
git push origin $remote
git checkout ${CURRENT}
