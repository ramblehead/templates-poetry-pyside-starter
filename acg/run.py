#!/usr/bin/env python
# Hey Emacs, this is -*- coding: utf-8; mode: python -*-

from pathlib import Path

from autocodegen import expand_and_implode

if __name__ == "__main__":
    acg_path = (Path(__file__).parent / "poetry-pyside-starter").resolve(
        strict=True,
    )

    expand_and_implode(acg_path)
