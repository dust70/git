ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

GIT_IGNORE_REPOSITORY = GitIgnoreRepository

.PHONY: install

clean:
	rm -f ${HOME}/.gitconfig
	rm -f ${HOME}/.gitignore
	rm -fr GitIgnoreRepo

install: | $(GIT_IGNORE_REPOSITORY)
	ln -snf ${ROOT_DIR}/config ${HOME}/.gitconfig

$(GIT_IGNORE_REPOSITORY):
	git clone git://github.com/github/gitignore.git $(GIT_IGNORE_REPOSITORY)

update: | $(GIT_IGNORE_REPOSITORY)
	git --work-tree=GitIgnoreRepo checkout -f
	git --work-tree=GitIgnoreRepo pull
