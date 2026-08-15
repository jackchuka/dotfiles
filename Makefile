.DEFAULT_GOAL := help

list: ## List all options available
	@$(PWD)/install.sh list

install: ## Run interactive installer
	@$(PWD)/install.sh

all: ## Run all setup
	@$(PWD)/install.sh all

help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
