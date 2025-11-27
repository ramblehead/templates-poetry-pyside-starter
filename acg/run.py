#!/usr/bin/env python
# Hey Emacs, this is -*- coding: utf-8; mode: python -*-

from pathlib import Path

from autocodegen import generate

if __name__ == "__main__":
    project_root = Path(__file__).parent.resolve(strict=True)
    acg_template_path = project_root / "poetry-pyside-starter"

    generate(project_root, acg_template_path)
