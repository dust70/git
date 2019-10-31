ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

GIT_IGNORE_REPOSITORY = $(ROOT_DIR)/GitIgnoreRepository
GIT_TEMPLATE_REPOSITORY = $(ROOT_DIR)/GitTemplate
LOCAL_BIN = ${HOME}/.local/bin

clean:
	rm -f $(ROOT_DIR)/template
	rm -f ${HOME}/.gitconfig
	rm -f ${HOME}/.gitignore
	rm -f ${HOME}/.tig_history
	rm -fr $(GIT_IGNORE_REPOSITORY)
	rm -fr $(GIT_TEMPLATE_REPOSITORY)

install: | install_repos ${HOME}/.git
	ln -snf ${ROOT_DIR}/config ${HOME}/.gitconfig

${HOME}/.git:
	ln -snf $(ROOT_DIR) ${HOME}/.git

update: | install_repos
	git --work-tree=$(GIT_IGNORE_REPOSITORY) checkout -f
	git --work-tree=$(GIT_IGNORE_REPOSITORY) pull
	git --work-tree=$(GIT_TEMPLATE_REPOSITORY) checkout -f
	git --work-tree=$(GIT_TEMPLATE_REPOSITORY) pull

$(GIT_IGNORE_REPOSITORY):
	git clone git://github.com/github/gitignore.git $(GIT_IGNORE_REPOSITORY)


$(GIT_TEMPLATE_REPOSITORY):
	git clone https://github.com/greg0ire/git_template $(GIT_TEMPLATE_REPOSITORY)
	ln -snf $(GIT_TEMPLATE_REPOSITORY)/template $(ROOT_DIR)/template

install_repos: | $(GIT_IGNORE_REPOSITORY) $(GIT_TEMPLATE_REPOSITORY)

.PHONY: install_repos
