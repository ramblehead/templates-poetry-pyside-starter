# Hey Emacs, this is -*- coding: utf-8 -*-

from string import Template
from typing import TYPE_CHECKING

if TYPE_CHECKING:
    from autocodegen import Context

template_str = """\
{
  "include": ["${project_name}"],

  "exclude": ["**/__pycache__", "**/.*"],

  "useLibraryCodeForTypes": true,
  "typeCheckingMode": "strict",

  "reportMissingTypeStubs": "warning",
  "reportUnknownMemberType": "warning",
  "reportUnknownArgumentType": "warning",
  "reportUnknownVariableType": "warning",
  "reportGeneralTypeIssues": "warning",
  // "reportUnknownParameterType": "warning",
  // "reportUnknownLambdaType": "warning",
  // "reportMissingTypeArgument": "warning",
  // "reportInvalidTypeVarUse": "warning",
  // "reportUnusedImport": "warning",
  // "reportUnusedClass": "warning",
  // "reportUnusedFunction": "warning",
  // "reportUnusedVariable": "warning",

  "pythonVersion": "3.11",
  "pythonPlatform": "Linux"
}
"""


def generate(ctx: Context) -> str:
    project_name = ctx.template_config.project_name

    return Template(template_str).substitute(
        {
            "project_name": project_name,
        },
    )
