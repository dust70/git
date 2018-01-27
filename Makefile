SOURCE = ${HOME}/.dotfiles/git

clean:
	rm -f ${HOME}/.git
	rm -f ${HOME}/.gitconfig
	rm -f ${HOME}/.gitignore
	rm -fr GitIgnoreRepo

install:
	git clone git://github.com/github/gitignore.git GitIgnoreRepo
	ln -snf ${SOURCE} ${HOME}/.git
	ln -snf ${SOURCE}/gitconfig ${HOME}/.gitconfig
	ln -snf ${SOURCE}/gitignore ${HOME}/.gitignore
