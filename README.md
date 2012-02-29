These are the Git workflow scripts we use. They came from [here][deadsimple] and evolved to the form you see in the scripts directory. We added functions that 1) prevent you from getting latest if you have uncommitted changes, 2) remind you to work in a feature branch, and 3) automatically determine the remote branch associated with the current feature branch.

## Usage

Copy the contents of the scripts directory to bash bin directory (e.g. C:\Users\USERNAME\bin). Then use them from the bash command line after you checkin. For example:


	git add .
	git commit -am"fixed bug #..."
	hack.sh
	# fix merge conflicts if any
	ship.sh

If hack.sh fails to automatically determine the remote branch associated with your current branch you can specify it as follows:

	hack.sh -r master
	
## License		

[MIT License][mitlicense]

This project is part of [MVBA Law Commons][mvbalawcommons].

[deadsimple]: http://jonrohan.me/guide/git/dead-simple-git-workflow-for-agile-teams/
[mvbalawcommons]: http://code.google.com/p/mvbalaw-commons/
[mitlicense]: http://www.opensource.org/licenses/mit-license.php   