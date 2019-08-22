ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

GIT_IGNORE_REPOSITORY = $(ROOT_DIR)/GitIgnoreRepository
LOCAL_BIN = ${HOME}/.local/bin

clean:
	rm -f ${HOME}/.gitconfig
	rm -f ${HOME}/.gitignore
	rm -f ${HOME}/.tig_history
	rm -fr GitIgnoreRepo
	rm -fr $(GIT_IGNORE_REPOSITORY)

install: | install_repos ${HOME}/.git
	ln -snf ${ROOT_DIR}/config ${HOME}/.gitconfig

${HOME}/.git:
	ln -snf $(ROOT_DIR) ${HOME}/.git

update: | install_repos
	git --work-tree=$(GIT_IGNORE_REPOSITORY) checkout -f
	git --work-tree=$(GIT_IGNORE_REPOSITORY) pull

$(GIT_IGNORE_REPOSITORY):
	git clone git://github.com/github/gitignore.git $(GIT_IGNORE_REPOSITORY)

install_repos: | $(GIT_IGNORE_REPOSITORY)

.PHONY: install_repos
