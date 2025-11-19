## Hey Emacs, this is -*- coding: utf-8 -*-
<%
  project_name_kebab = utils.kebab_case(config["project_name"])
  project_name_snake = utils.snake_case(config["project_name"])
%>\
[tool.poetry]
name = "${project_name_kebab}"
version = "0.1.0"
description = ""
authors = []
readme = "README.md"
packages = [
  { include = "${project_name_snake}" },
  { include = "poetry_utils", from = "utils" },
]

[tool.poetry.scripts]
lint = "poetry_utils.scripts:lint"
dev = "${project_name_snake}.main:main"
build = "poetry_utils.scripts:build"
start = "poetry_utils.scripts:start"
format = "poetry_utils.scripts:format_"
test = "poetry_utils.scripts:test"

[tool.poetry.dependencies]
python = ">=3.11,<3.12"
pyside6 = "^6.5.2"
pyinstaller = "^5.13.0"

[tool.poetry.group.dev.dependencies]
black = "^23.3.0"
pyright = "^1.1.320"
ruff = "^0.0.276"
ruff-lsp = "^0.0.35"
mypy = "^1.3.0"
typing-extensions = "^4.6.3"

[tool.ruff]
select = ["ALL"]
ignore = [
  # No need
  "DJ",    # flake8-django
  "UP009", # UTF-8 encoding declaration is unnecessary
  # subprocess call with shell=True seems safe, but
  # may be changed in the future; consider rewriting without shell
  "S602",
  "S607", # Starting a process with a partial executable path
  "N802", # Function name {name} should be lowercase

  # Should be enabled later when project is more mature
  "D", # pydocstyle

  # Should be enabled for releases
  "ERA001", # eradicate (e.g. comments)
  "T20",    # flake8-print

  # PySide C APIs do not accept keyword arguments
  "FBT003", # boolean-positional-value-in-function-call

  # Using unittest for tests so needs to be disabled
  "PT009", # pytest-unittest-assertion
]
line-length = 79
exclude = ["**/__pycache__", "**/.*"]

[tool.black]
line-length = 79

[build-system]
requires = ["poetry-core"]
build-backend = "poetry.core.masonry.api"
