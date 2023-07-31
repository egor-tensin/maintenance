include prelude.mk

LIMIT ?= all
$(eval $(call noexpand,LIMIT))

args := --inventory src/inventory.ini --limit '$(call escape,$(LIMIT))'

.PHONY: all
all: run

.PHONY: deps
deps:
	ansible-galaxy collection install -r src/requirements.yml

.PHONY: run
run:
	ansible-playbook $(args) src/playbook.yml

.PHONY: reboot
reboot:
	ansible $(args) --become -m reboot '*'
	ansible $(args) -m wait_for_connection '*'

.PHONY: reboot/cloud
reboot/cloud: LIMIT := cloud
reboot/cloud: run
