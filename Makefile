ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

GIT_IGNORE_REPOSITORY = $(ROOT_DIR)/GitIgnoreRepository
LOCAL_BIN = ${HOME}/.local/bin

clean:
	rm -f ${HOME}/.gitconfig
	rm -f ${HOME}/.gitignore
	rm -f ${HOME}/.tig_history
	rm -fr GitIgnoreRepo
	rm -fr $(GIT_IGNORE_REPOSITORY)
	#
	gem uninstall --all --user-install overcommit || true
	gem uninstall --all --user-install puppet-lint || true

install: | install_repos packages ${HOME}/.git
	ln -snf ${ROOT_DIR}/config ${HOME}/.gitconfig

${HOME}/.git:
	ln -snf $(ROOT_DIR) ${HOME}/.git

update: | install_repos packages
	git --work-tree=$(GIT_IGNORE_REPOSITORY) checkout -f
	git --work-tree=$(GIT_IGNORE_REPOSITORY) pull
	#
	gem update --user-install overcommit
	gem update --user-install puppet-lint

$(GIT_IGNORE_REPOSITORY):
	git clone git://github.com/github/gitignore.git $(GIT_IGNORE_REPOSITORY)

packages:
	gem install --user-install overcommit
	gem install --user-install puppet-lint

install_repos: | $(GIT_IGNORE_REPOSITORY)

.PHONY: install_repos
