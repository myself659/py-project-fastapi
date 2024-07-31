# py-project-fastapi

## Overview [![lint](https://github.com/myself659/py-project-fastapi/actions/workflows/lint.yml/badge.svg?branch=main)](https://github.com/myself659/py-project-fastapi/actions)

![Testing](https://github.com/myself659/py-project-fastapi/actions/workflows/test.yml/badge.svg?branch=main)](https://github.com/myself659/py-project-fastapi/actions/workflows/test.yml)

[![Documentation](https://github.com/myself659/py-project-fastapi/actions/workflows/pages.yml/badge.svg?branch=main)](https://github.com/myself659/py-project-fastapi/actions/workflows/pages.yml)

# python-project-johannes

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

### [act](https://github.com/nektos/act)

```
scoop install  act
```

```
act
```

```
Error: Error response from daemon: Head "https://registry-1.docker.io/v2/library/node/manifests/16-buster-slim": EOF
```

act 有一个限制必备是 public 的 repo 才可以。

## part3 Part (Testing, CI)

### workflow status badge

[Adding a workflow status badge](https://docs.github.com/zh/actions/monitoring-and-troubleshooting-workflows/monitoring-workflows/adding-a-workflow-status-badge)

### pytest

```
poetry add --group test respx pytest-asyncio trio

poetry add --group test pytest-cov
```

[4 Proven Ways To Define Pytest PythonPath and Avoid Module Import Errors](https://pytest-with-eric.com/introduction/pytest-pythonpath/)

pythonpath 默认是当前目录。

## part4 (Documentation, CI/CD)

### mkdocs

```
poetry add --group docs mkdocs mkdocs-material
```

```
mkdocs build
```

server by `Go Live`

```
mkdocs gh-deploy -m "docs: update documentation" -v --force
```

```
GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

对 github action 开放对该 repository 的写权限。

```
By default, the GITHUB_TOKEN only has restricted access. If we head over to our GitHub repository → Settings → Actions → General → And scroll down to Workflow permissions, we’ll see that it’s currently set to Read repository contents and package permissions.
```

### format

[Formatting Python in VS Code](https://code.visualstudio.com/docs/python/formatting)

[Supercharge your Python Code with Ruff](https://medium.com/bitgrit-data-science-publication/supercharge-your-python-code-with-ruff-4c75b890ed40)

## part5 Versioning & Releases, CI/CD

### tag

```
git tag -a v0.1.0 -m "version v0.1.0"
```

```
❯ git tag
v0.1.0
```

```
git show v0.1.0
```

```
git push origin v0.1.0
```

fix

feat

### semantic-release

```
 poetry add --group semver python-semantic-release
```

[Automating Versioning and Releases Using Semantic Release](https://medium.com/agoda-engineering/automating-versioning-and-releases-using-semantic-release-6ed355ede742)

[Semantic Release cmd](https://python-semantic-release.readthedocs.io/en/latest/commands.html)

### auto release

profile create GH_TOKEN.

Repository secrets for GH_TOKEN.

## part6 (Containerisation, Docker, CI/CD)

### docker

```
docker build --file Dockerfile --tag py-project-fastapi:latest .
```

```
docker run -it --rm py-project-fastapi
```

```
docker run -it --rm py-project-fastapi /bin/bash
```

```
root@068315bab695:/app/src/example_app# uvicorn app:app --host 0.0.0.0 --port 80 --workers 1
```

```
docker run -p 9000:80 -it --rm  py-project-fastapi

http://localhost:9000/docs
```

```
docker build --file Dockerfile --tag py-project-fastapi:latest --target production .
```

```
docker run -p 9000:80 -it --rm  py-project-fastapi

http://localhost:9000/docs
```

```
docker tag py-project-fastapi:latest ghcr.io/myself659/py-project-fastapi:latest

 docker push ghcr.io/myself659/py-project-fastapi:latest
```

### package

create a Personal access tokens: CR_PAT

```
docker login ghcr.io -u myself659 -p ..

docker tag py-project-fastapi:latest ghcr.io/myself659/py-project-fastapi:latest

docker push ghcr.io/myself659/py-project-fastapi:latest
```

package connects to the repository.
