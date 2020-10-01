.DEFAULT_GOAL := install
install: ## Runs ansible-playbook to ensure system is set up
	ansible-playbook --ask-become-pass -i "localhost," playbook.yml
config:
	ansible-playbook -i "localhost," --tags config playbook.yml
