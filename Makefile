
.PHONY: setup_terraform validate apply apply_with_rds test plan taint destroy clean help


validate: setup_terraform | ## Runs terraform validate for volume and instance instance
	set -o allexport; \
	pushd infrastructure/instance && $(MAKE) validate  && popd && \
	pushd infrastructure/rds/instance && $(MAKE) validate && popd 

# run_shell_linter is disabled until we install shellcheck on Jenkins
checkstyle: check_terraform_style ## Validate Style/Lint

fixstyle: fix_terraform_style ## Fix Style/Lint

check_terraform_style:
	terraform fmt -write=false | wc -l | grep '^0$$'

fix_terraform_style:
	terraform fmt -write=true -list=true

apply:setup_terraform | ## Creates a volume and instance instance
	set -o allexport; \
	pushd infrastructure/instance && $(MAKE) apply && popd

apply_with_rds:setup_terraform | ## Creates a volume,instance and rds db
	set -o allexport; \
	pushd infrastructure/instance && $(MAKE) apply && popd && \
	pushd infrastructure/rds/instance && $(MAKE) apply && popd

pipeline_deploy:setup_terraform | ## Deploys a volume,instance and rds db
	set -o allexport; \
	pushd infrastructure/build/ && $(MAKE) apply && popd 

plan: setup_terraform | ## Runs all plans
	set -o allexport; \
	pushd infrastructure/instance && make plan && popd \
	pushd infrastructure/rds/instance && make plan && popd \
	pushd infrastructure/build/ && make plan && popd

destroy: ## Destroy all instances and volumes
	set -o allexport; \
	pushd infrastructure/instance && $(MAKE) destroy && popd && \
	pushd infrastructure/rds/instance && $(MAKE) destroy && popd

setup_terraform:
	@tfenv install

clean: ## Delete .terraform, working, stray .tfstate
	set -o allexport; \
	pushd infrastructure/instance && $(MAKE) clean && popd && \
	pushd infrastructure/rds/instance && $(MAKE) clean && popd

help:
	@grep -h -P '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
