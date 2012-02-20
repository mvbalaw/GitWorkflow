These are the Git workflow scripts we use. They came from [here][deadsimple] and evolved to the form you see below. We added functions that 1) prevent you from getting latest if you have uncommitted changes, 2) remind you to work in a feature branch, and 3) automatically determine the remote branch associated with the current feature branch.

## Usage

Name these scripts hack.sh and ship.sh and put them in your bash bin directory (e.g. C:\Users\USERNAME\bin). Then use them from the bash command line after you checkin. For example:


	git add .
	git commit -am"fixed bug #..."
	hack.sh
	ship.sh

## License		

[MIT License][mitlicense]

This project is part of [MVBA Law Commons][mvbalawcommons].

[deadsimple]: http://jonrohan.me/guide/git/dead-simple-git-workflow-for-agile-teams/
[mvbalawcommons]: http://code.google.com/p/mvbalaw-commons/
[mitlicense]: http://www.opensource.org/licenses/mit-license.php   