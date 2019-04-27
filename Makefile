PROJECT_NAME?=idris-project-template

NIXPKGS_OWNER?=NixOS
NIXPKGS_REPO?=nixpkgs
NIXPKGS_REV?=80738ed9dc0ce48d7796baed5364eef8072c794d

INSTALL_ROOT?=${PWD}/dist
DOC_ROOT?=$(INSTALL_ROOT)/doc

.PHONY: build
build:
	idris --build $(PROJECT_NAME).ipkg

.PHONY: install
install:
	idris --install $(PROJECT_NAME).ipkg --ibcsubdir $(INSTALL_ROOT)/libs
	IDRIS_DOC_PATH=$(DOC_ROOT) idris --installdoc $(PROJECT_NAME).ipkg
	install -D -m555 -T $(PROJECT_NAME) $(INSTALL_ROOT)/bin/$(PROJECT_NAME)

.PHONY: check
check:
	idris --testpkg $(PROJECT_NAME).ipkg

.PHONY: typecheck
typecheck:
	idris --checkpkg $(PROJECT_NAME).ipkg

.PHONY: mkdoc
mkdoc:
	idris --mkdoc $(PROJECT_NAME).ipkg

.PHONY: run
run: build
	./$(PROJECT_NAME)

.PHONY: update-nixpkgs
update-nixpkgs:
	nix-shell --pure nix/scripts/generate-nixpkgs-json.nix \
		--argstr owner $(NIXPKGS_OWNER) \
		--argstr repo $(NIXPKGS_REPO) \
		--argstr rev $(NIXPKGS_REV)

.PHONY: change-project-name
change-project-name:
	find . -type f -not -path './.git/*' -not -name '*.swp' \
		| xargs -r sed -i -e "s/idris-project-template/$(PROJECT_NAME)/g"
	mv idris-project-template.ipkg $(PROJECT_NAME).ipkg

.PHONY: clean
clean:
	idris --clean $(PROJECT_NAME).ipkg
	rm -f $(PROJECT_NAME)
	rm -rf $(PROJECT_NAME)_doc
	rm -rf dist
	rm -f result
