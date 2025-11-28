#!/usr/bin/env python
# Hey Emacs, this is -*- coding: utf-8; mode: python -*-

from pathlib import Path

from autocodegen import generate

if __name__ == "__main__":
    project_root = Path(__file__).parent.parent.resolve(strict=True)
    acg_root = project_root / "acg"
    acg_template_name = "poetry-pyside-starter"

    generate(project_root, acg_root, acg_template_name)
