# Hey Emacs, this is -*- coding: utf-8 -*-

from string import Template
from typing import TYPE_CHECKING

from autocodegen.utils import snake_case

if TYPE_CHECKING:
    from autocodegen import Context

template_str = """\
import logging

from ${project_name_snake} import __name__ as name

log_formatter = logging.Formatter("%(asctime)s - %(levelname)s - %(message)s")

logger = logging.getLogger(name)
logger.setLevel(logging.INFO)

# Log to stderr
console_handler = logging.StreamHandler()
console_handler.setLevel(logging.INFO)
console_handler.setFormatter(log_formatter)
logger.addHandler(console_handler)

# Create log file
file_handler = logging.FileHandler(f"{name}.log", mode="w")
file_handler.setLevel(logging.INFO)
file_handler.setFormatter(log_formatter)
logger.addHandler(file_handler)
"""


def generate(ctx: Context) -> str:
    project_name = ctx.template_config.project_name

    return Template(template_str).substitute(
        {
            "project_name_snake": snake_case(project_name),
        },
    )
