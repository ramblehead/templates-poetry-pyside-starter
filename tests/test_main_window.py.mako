## Hey Emacs, this is -*- coding: utf-8 -*-
<%
  project_name = utils.snake_case(config["project_name"])
%>\
import sys
import unittest
from typing import Self, TypeVar

from PySide6.QtWidgets import QApplication

from ${project_name}.views.main_window import MainWindow

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
        self.assertIn("PySide Application", self.window.windowTitle())

    def test_label(self: Self) -> None:
        self.assertIn("Hello world", self.window.label.text())


if __name__ == "__main__":
    unittest.main()
