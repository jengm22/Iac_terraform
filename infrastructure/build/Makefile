

# Add targets here that aren't the name of files produced by the target. See http://stackoverflow.com/a/2145605 for details
.PHONY: all help setup_terraform validate plan apply test clean init_remote_state clean_modules fix_terraform_style fix_ruby_style checkstyle bundle

.DEFAULT_GOAL := help

setup_terraform: # Required when upgrading terraform and set a new version to use
	@tfenv install

validate: ##Runs terraform validate
	terraform validate

plan: init_remote_state  ## Runs terraform plan
	terraform plan 

apply: init_remote_state  ## Runs terraform apply
	terraform apply -auto-approve

destroy: init_remote_state  ## Runs terraform apply
	terraform destroy -auto-approve 

clean_modules:
	find . -name '.terraform' | xargs -n1 rm -rf

init_remote_state: setup_terraform | clean_modules fix_terraform_style ## Retrieves the terraform remote state
	terraform init 

fix_terraform_style: setup_terraform
	terraform fmt -write=true -list=true

checkstyle: fix_terraform_style 

clean:
	find . -name '*.terraform.tfstate' -delete
	find . -name '.terraform' | xargs -n1 rm -rf
	find . -name 'working' | xargs -n1 rm -rf

help:
	@grep -h -P '^[a-zA-Z0-9_%-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
