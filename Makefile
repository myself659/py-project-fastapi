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
lint-mypy-report:
	@mypy ./src --html-report ./mypy_html
format: format-black format-isort
lint: lint-black lint-isort lint-flake8 lint-mypy