# LLM

## Setup
### Requirements
1. make
2. python3.8 (set with pyenv)

### Steps
1. Setup environment variables and OpenAPI credentials
```sh
cp -i .env.template .env
```
2. Run notebooks via Jupyter lab
```sh
$ make lab  # setup all dependencies from scratch and run Jupyterlab
$ make # show all Makefile recipes
```

## Content
### AzureOpenAI
Notebooks using AzureOpenAI
### OpenAI
Notebooks using OpenAI

### Subrepos:
Reference notebooks from other repos
- https://github.com/Azure-Samples/openai
- https://github.com/openai/openai-cookbook
- https://github.com/microsoft/azure-openai-in-a-day-workshop/