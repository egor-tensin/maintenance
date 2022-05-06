MAKEFLAGS += --no-builtin-rules --no-builtin-variables --warn-undefined-variables
unexport MAKEFLAGS
.DEFAULT_GOAL := all
.DELETE_ON_ERROR:
.SUFFIXES:
SHELL := bash
.SHELLFLAGS := -eu -o pipefail -c

escape = $(subst ','\'',$(1))

define noexpand
ifeq ($$(origin $(1)),environment)
    $(1) := $$(value $(1))
endif
ifeq ($$(origin $(1)),environment override)
    $(1) := $$(value $(1))
endif
ifeq ($$(origin $(1)),command line)
    override $(1) := $$(value $(1))
endif
endef

limit ?= all
$(eval $(call noexpand,limit))

.PHONY: all
all: run

.PHONY: deps
deps:
	ansible-galaxy collection install -r requirements.yml

.PHONY: run
run:
	ansible-playbook --inventory inventory.ini --limit '$(call escape,$(limit))' maintenance.yml
