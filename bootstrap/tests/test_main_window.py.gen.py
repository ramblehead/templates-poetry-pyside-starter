# Hey Emacs, this is -*- coding: utf-8 -*-

from string import Template
from typing import TYPE_CHECKING

from autocodegen.utils import pascal_case, snake_case

if TYPE_CHECKING:
    from autocodegen import Context

template_str = """\
import sys
import unittest
from typing import Self, TypeVar

from PySide6.QtWidgets import QApplication

from ${project_name_snake}.views.main_window import MainWindow

T = TypeVar("T", bound="TestMainWindow")


class TestMainWindow(unittest.TestCase):
    @classmethod
    def setUpClass(cls: type[T]) -> None:
        cls.app = QApplication.instance() or QApplication(sys.argv)

    @classmethod
    def tearDownClass(cls: type[T]) -> None:
        cls.app.quit()

    def setUp(self: Self) -> None:
        self.window = MainWindow()

    def test_window_title(self: Self) -> None:
        self.assertIn("${project_name_pascal} Application", self.window.windowTitle())

    def test_label(self: Self) -> None:
        self.assertIn("Hello world", self.window.label.text())


if __name__ == "__main__":
    unittest.main()
"""


def generate(ctx: Context) -> str:
    project_name = ctx.template_config.project_name

    return Template(template_str).substitute(
        {
            "project_name_snake": snake_case(project_name),
            "project_name_pascal": pascal_case(project_name),
        },
    )
