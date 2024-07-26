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
