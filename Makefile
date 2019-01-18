ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

GIT_IGNORE_REPOSITORY = $(ROOT_DIR)/GitIgnoreRepository

PRECOMMIT_CONFIG = $(ROOT_DIR)/.pre-commit-config.yaml

.PHONY: install

clean:
	rm -f $(HOME)/.gitconfig
	rm -f $(HOME)/.gitignore
	rm -f $(PRECOMMIT_CONFIG)
	rm -fr GitIgnoreRepo
	rm -fr $(GIT_IGNORE_REPOSITORY)

install: | $(GIT_IGNORE_REPOSITORY) $(PRECOMMIT_CONFIG)
	ln -snf ${ROOT_DIR}/config ${HOME}/.gitconfig

$(PRECOMMIT_CONFIG):
	ln -snf ${ROOT_DIR}/pre-commit-config.yaml $(PRECOMMIT_CONFIG)
	pre-commit install --install-hooks

$(GIT_IGNORE_REPOSITORY):
	git clone git://github.com/github/gitignore.git $(GIT_IGNORE_REPOSITORY)

update: | $(GIT_IGNORE_REPOSITORY) $(PRECOMMIT_CONFIG)
	git --work-tree=$(GIT_IGNORE_REPOSITORY) checkout -f
	git --work-tree=$(GIT_IGNORE_REPOSITORY) pull
	pre-commit autoupdate
