# Makefile
format-black:
	@black ./src
format-isort:
	@isort ./src
lint-black:
	@black ./src --check
lint-isort:
	@isort ./src --check
lint-flake8:
	@flake8 ./src
lint-mypy:
	@mypy ./src
	@mypy ./tests
lint-mypy-report:
	@mypy ./src --html-report ./mypy_html
unit-tests:
	@pytest

unit-tests-cov:
	@pytest --cov=src --cov-report term-missing --cov-report=html

unit-tests-cov-fail:
	@pytest --cov=src --cov-report term-missing --cov-report=html --cov-fail-under=0

ruff:
	@ruff check
	@ruff format
##@ Documentation
docs-build: ## build documentation locally
	@mkdocs build

create_openapi: ## create openapi.json
	@python scripts/create_openapi_json.py

docs-deploy: ## build & deploy documentation to "gh-pages" branch
	@mkdocs gh-deploy -m "docs: update documentation" -v --force

format: format-black format-isort
lint: lint-black lint-isort lint-flake8 lint-mypy