# Hey Emacs, this is -*- coding: utf-8 -*-

from string import Template
from typing import TYPE_CHECKING

from autocodegen.utils import pascal_case

if TYPE_CHECKING:
    from autocodegen import Context

template_str = """\
from typing import Self

from PySide6.QtCore import Qt
from PySide6.QtWidgets import QLabel, QMainWindow


class MainWindow(QMainWindow):
    def __init__(self: Self) -> None:
        super().__init__()
        self.initUI()

    def initUI(self: Self) -> None:
        # Window config
        self.setWindowTitle("${project_name_pascal} Application")
        self.setFixedSize(400, 200)

        # Child widgets
        self.label = QLabel("Hello world")
        self.label.setAlignment(Qt.AlignmentFlag.AlignCenter)
        self.setCentralWidget(self.label)
"""


def generate(ctx: Context) -> str:
    project_name = ctx.project_config.autocodegen.project_name

    return Template(template_str).substitute(
        {
            "project_name_pascal": pascal_case(project_name),
        },
    )
