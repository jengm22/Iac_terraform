
.PHONY: validate apply apply_with_rds test plan taint destroy clean help


validate: ## Runs terraform validate for volume and instance instance
	cd infrastructure/instance && $(MAKE) validate  && \
	cd infrastructure/rds/instance && $(MAKE) validate 

# run_shell_linter is disabled until we install shellcheck on Jenkins
checkstyle: check_terraform_style ## Validate Style/Lint

fixstyle: fix_terraform_style ## Fix Style/Lint

check_terraform_style:
	terraform fmt -write=false | wc -l | grep '^0$$'

fix_terraform_style:
	terraform fmt -write=true -list=true

apply:## Creates a volume and instance instance
	cd infrastructure/instance && $(MAKE) apply

apply_with_rds:## Creates a volume,instance and rds db
	cd infrastructure/instance && $(MAKE) apply && \
	cd ../rds/instance && $(MAKE) apply

pipeline_deploy:## Deploys a volume,instance and rds on the pipeline
	cd infrastructure/build/ && $(MAKE) apply

pipeline_destroy: ## Destroy all instances and volumes and rds on the pipeline
	cd infrastructure/build/ && $(MAKE) destroy && \
	cd ../instance && $(MAKE) destroy && \
	cd ../rds/instance && $(MAKE) destroy

plan_ec2: ## Runs all plans
	cd infrastructure/instance && $(MAKE) plan 

plan_rds: ## Runs all plans
	cd infrastructure/rds/instance && $(MAKE) plan 

plan: ## Runs all plans
	cd infrastructure/instance && $(MAKE) plan && \
	cd ../rds/instance && $(MAKE) plan 

destroy: ## Destroy all instances and volumes
	cd infrastructure/instance && $(MAKE) destroy && \
	cd ../rds/instance && $(MAKE) destroy

clean: ## Delete .terraform, working, stray .tfstate
	cd infrastructure/instance && $(MAKE) clean && \
	cd infrastructure/rds/instance && $(MAKE) clean

help:
	@grep -h -P '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
