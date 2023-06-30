include prelude.mk

.SECONDEXPANSION:

LIMIT ?= all

args := --inventory inventory.ini --limit '$(LIMIT)'

.PHONY: all
all: run

.PHONY: deps
deps:
	ansible-galaxy collection install -r requirements.yml

.PHONY: run
run:
	ansible-playbook $(args) maintenance.yml

.PHONY: reboot
reboot:
	ansible $(args) --become -m reboot '*'
	ansible $(args) -m wait_for_connection '*'

.PHONY: reboot/cloud
reboot/cloud: LIMIT := cloud
reboot/cloud: run
