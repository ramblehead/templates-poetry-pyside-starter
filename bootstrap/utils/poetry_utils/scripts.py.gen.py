# Hey Emacs, this is -*- coding: utf-8 -*-

from string import Template
from typing import TYPE_CHECKING

from autocodegen.utils import snake_case

if TYPE_CHECKING:
    from autocodegen import Context

template_str = """\
import platform
import subprocess

from PyInstaller import __main__ as pyinstaller

APP_NAME: str = "${project_name_snake}"


def lint() -> None:
    print("Running pyright...")
    subprocess.run("pyright", shell=True)

    print()
    print("Running ruff...")
    subprocess.run("poetry run ruff check .", shell=True)


def format_() -> None:
    print("Formatting files...")
    subprocess.run("poetry run black .", shell=True)


def build() -> None:
    print("Building application...")
    pyinstaller.run(
        [
            "${project_name_snake}/main.py",
            "--name",
            APP_NAME,
            "-y",
            "--windowed",
        ],
    )


def start() -> None:
    print("Running application...")

    command = (
        f".\\dist\\{APP_NAME}\\{APP_NAME}.exe"
        if platform.system() == "Windows"
        else f"./dist/{APP_NAME}/{APP_NAME}"
    )
    subprocess.run(command, shell=True)


def test() -> None:
    print("Starting tests...")
    subprocess.run("python -u -m unittest discover", shell=True)
"""


def generate(ctx: Context) -> str:
    project_name = ctx.project_config.autocodegen.project_name

    return Template(template_str).substitute(
        {
            "project_name_snake": snake_case(project_name),
        },
    )
