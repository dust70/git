ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

clean:
	rm -f ${HOME}/.gitconfig
	rm -f ${HOME}/.gitignore
	rm -fr GitIgnoreRepo

install:
	git clone git://github.com/github/gitignore.git GitIgnoreRepo
	ln -snf ${ROOT_DIR}/config ${HOME}/.gitconfig

update:
	git --work-tree=GitIgnoreRepo checkout -f
	git --work-tree=GitIgnoreRepo pull
