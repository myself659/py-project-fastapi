FROM python:3.9.9-slim

WORKDIR /app

# install poetry
ENV POETRY_VERSION=1.8.3
RUN pip install "poetry==$POETRY_VERSION"

# copy application
COPY ["pyproject.toml", "poetry.lock", "README.md", "./"]
COPY ["src/", "src/"]

# build wheel
RUN poetry build --format wheel

# install package
RUN pip install dist/*.whl