## Hey Emacs, this is -*- coding: utf-8 -*-
<%
  project_name_snake = utils.snake_case(config["project_name"])
  project_name_pascal = utils.pascal_case(config["project_name"])
%>\
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
