ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

GIT_IGNORE_REPOSITORY = $(ROOT_DIR)/GitIgnoreRepository
LOCAL_BIN = ${HOME}/.local/bin
PRECOMMIT_CONFIG = $(ROOT_DIR)/.pre-commit-config.yaml

clean:
	rm -f $(HOME)/.gitconfig
	rm -f $(HOME)/.gitignore
	rm -f $(PRECOMMIT_CONFIG)
	rm -fr GitIgnoreRepo
	rm -fr $(GIT_IGNORE_REPOSITORY)

install: | $(GIT_IGNORE_REPOSITORY) template/hooks/prepare-commit $(LOCAL_BIN)/pre-commit $(LOCAL_BIN)/ansible-lint $(LOCAL_BIN)/yamllint
	ln -snf ${ROOT_DIR}/config ${HOME}/.gitconfig

update: | $(GIT_IGNORE_REPOSITORY) template/hooks/prepare-commit $(LOCAL_BIN)/pre-commit $(LOCAL_BIN)/ansible-lint $(LOCAL_BIN)/yamllint
	git --work-tree=$(GIT_IGNORE_REPOSITORY) checkout -f
	git --work-tree=$(GIT_IGNORE_REPOSITORY) pull
	pre-commit autoupdate

$(PRECOMMIT_CONFIG):
	ln -snf ${ROOT_DIR}/pre-commit-config.yaml $(PRECOMMIT_CONFIG)

template/hooks/prepare-commit: | $(LOCAL_BIN)/pre-commit $(PRECOMMIT_CONFIG)
	pre-commit install --overwrite --install-hooks

$(GIT_IGNORE_REPOSITORY):
	git clone git://github.com/github/gitignore.git $(GIT_IGNORE_REPOSITORY)

$(LOCAL_BIN)/pre-commit:
	pip install --user pre-commit

$(LOCAL_BIN)/ansible-lint:
	pip install --user ansible-lint

$(LOCAL_BIN)/yamllint:
	pip install --user yamllint
