# py-project-fastapi

## part1 (GitHub, IDE, Python environment, configuration, app)

### setup project in github

```
❯ dust  -i .
20B   ┌── README.md│█████████████████████████████████████████████████████████████████████████████████████████████ │ 100%
20B ┌─┴ .
```

```
❯ dust  -i .
  3B   ┌── LICENSE  │█                                                                                            │   1%
389B   ├── README.md│████████████████████████████████████████████████████████████████████████████████████████████ │  99%
392B ┌─┴ .          │████████████████████████████████████████████████████████████████████████████████████████████ │ 100%

```

### poetry init

```
poetry init  --name  fastapitemplate --no-interaction
```

```
poetry lock
```

### peotry add

```
poetry add  httpx
```

```
❯ poetry show
anyio             4.4.0    High level compatibility layer for multiple asynchronous event loop implementations
certifi           2024.7.4 Python package for providing Mozilla's CA Bundle.
exceptiongroup    1.2.2    Backport of PEP 654 (exception groups)
h11               0.14.0   A pure-Python, bring-your-own-I/O implementation of HTTP/1.1
httpcore          1.0.5    A minimal low-level HTTP client.
httpx             0.27.0   The next generation HTTP client.
idna              3.7      Internationalized Domain Names in Applications (IDNA)
sniffio           1.3.1    Sniff out which async library your code is running under
typing-extensions 4.12.2   Backported and Experimental Type Hints for Python 3.8+
```

```
dust  -i .
  3B   ┌── LICENSE        │█                                                                                      │   0%
  0B   │   ┌── app.py     │█                                                                                      │   0%
 52B   │   ├── __init__.py│█                                                                                      │   0%
 52B   │ ┌─┴ example_app  │█                                                                                      │   0%
 52B   ├─┴ src            │█                                                                                      │   0%
450B   ├── pyproject.toml │████                                                                                   │   4%
2.0K   ├── README.md      │████████████████                                                                       │  18%
5.1K   ├── poetry.lock    │██████████████████████████████████████                                                 │  44%
 11K ┌─┴ .                │██████████████████████████████████████████████████████████████████████████████████████ │ 100%
```

```
poetry add fastapi
```

```
peotry add  "uvicorn[standard]"
```

### ren example_app

```
(fastapitemplate-py3.9) I:\pyenv\py-project-fastapi>python src/example_app/app.py
```

http://localhost:9000/docs

## part2 (Formatting, Linting, Command management, CI)

### setup lint

```
poetry add --group lint isort black flake8 mypy
```

```
> isort . --check
Skipped 2 files
> black . --check
would reformat src/example_app/app.py
Oh no! 💥 💔 💥
1 file would be reformatted, 1 file would be left unchanged.
> flake8 .
...
> mypy .
Success: no issues found in 2 source files
```

```
(fastapitemplate-py3.9) I:\pyenv\py-project-fastapi>flake8  src
src\example_app\__init__.py:3:22: W292 no newline at end of file
src\example_app\app.py:31:73: W292 no newline at end of file

(fastapitemplate-py3.9) I:\pyenv\py-project-fastapi>flake8 src
```

```
(fastapitemplate-py3.9) I:\pyenv\py-project-fastapi>make format
Makefile:3: *** missing separator.  Stop.
```

Makefile 需要使用 tab 而不是 space

### lint.yml

we give the workflow a name:

```
name: Linting
```

define on which signals/events, this workflow should be started:

```
on:
  pull_request:
    branches:
      - main
  push:
    branches:
      - main
```

git pull 与 git push

```
jobs:
  Linting:
    runs-on: ubuntu-20.4
    steps:
      # check-out repo
      - name: Checkout repository
        uses: actions/checkout@v3
        with:
          ref: ${{ github.head_ref }}
      # install poetry
      - name: Install poetry
        run: pipx install poetry==1.8.3
      # set-up python with cache
      - name: Setup Python 3.9
        uses: actions/setup-python@v4
        with:
          python-version: "3.9"
          cache: "poetry"
      # install requirements (including dev dependencies)
      - name: Install requirements
        run: poetry install --only lint
      # run linters
      - name: Run linters
        run: |
          set -o pipefail
          poetry run make lint
```

按定义顺序执行。

The job runs in an ubuntu-latest\* (runs-on) environment and executes the following steps:

- checkout the repository using the branch name that is stored in the default environment variable ${{ github.head_ref }} . GitHub action: checkout@v3

- install Poetry with pipx because it’s pre-installed on all GitHub runners. If you have a self-hosted runner in e.g. Azure, you’d need to install it yourself or use an existing GitHub action that does it for you.

- Setup the python environment and caching the virtualenv based on the content in the poetry.lock file. GitHub action: setup-python@v4

- Install only the requirements that are needed to run the different linters with poetry install --only lint \*\*

- Running the linters with the make command: poetry run make lint Please note, that running the tools is only possible in the virtualenv, which we can access through poetry run.

[](https://raw.githubusercontent.com/actions/python-versions/main/versions-manifest.json)

[选择作业的运行器](https://docs.github.com/zh/actions/using-jobs/choosing-the-runner-for-a-job)

[run linter failed](https://github.com/myself659/py-project-fastapi/actions/runs/10109003492/job/27956016609)
