.DEFAULT: help
PYTHON=python3.8

help: ## Display this help message
	@echo "Please use \`make <target>\` where <target> is one of"
	@awk -F ':.*?## ' '/^[a-zA-Z]/ && NF==2 {printf "\033[36m  %-25s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

clean: ## Remove general artifact files
	find . -name '.coverage' -delete
	find . -name '*.pyc' -delete
	find . -name '*.pyo' -delete
	find . -name '.pytest_cache' -type d | xargs rm -rf
	find . -name '__pycache__' -type d | xargs rm -rf
	find . -name '.ipynb_checkpoints' -type d | xargs rm -rf

reset: clean ## Remove virtual environment and all dependencies
	rm -rf venv
	rm -rf requirements.txt

venv: ## Create virtual environment if venv directory not present
	${PYTHON} -m venv venv
	venv/bin/pip install -U pip pip-tools wheel setuptools

upgrade-venv: venv ## Upgrade pip, pip-tools, wheel and setuptools
	venv/bin/pip install --upgrade pip pip-tools wheel setuptools

requirements.txt: venv requirements.in ## Generate and update requirements.txt to fulfil dependencies minimally
	venv/bin/pip-compile -o requirements.txt requirements.in --resolver=backtracking

upgrade-req: venv requirements.in ## Force upgrades on all packages to fulfil dependencies fully
	venv/bin/pip-compile --upgrade -o requirements.txt --resolver=backtracking requirements.in

install: requirements.txt  ## Install dependencies
	venv/bin/pip-sync requirements.txt

nb: install ## Run Jupyter Notebook
	venv/bin/jupyter notebook 

lab: install ## Run JupyterLab
	venv/bin/jupyter lab

update-subrepos: ## Update submodules
	git submodule update --rebase --remote