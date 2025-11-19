## Hey Emacs, this is -*- coding: utf-8 -*-
<%
  project_name = utils.snake_case(config["project_name"])
%>\
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
