OPTIONS := xcode brew dir git mas zsh
.DEFAULT_GOAL := help

list: ## List all options available
	@$(foreach option, $(OPTIONS), echo $(option);)

install: ## Run intractive installer
	@$(PWD)/install.sh

all: ## Run all setup 
	@$(PWD)/install.sh all

help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
