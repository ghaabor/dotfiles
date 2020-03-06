ensure: ## Runs ansible-playbook to ensure system is set up
	ansible-playbook --ask-become-pass -i "localhost," playbook.yml

