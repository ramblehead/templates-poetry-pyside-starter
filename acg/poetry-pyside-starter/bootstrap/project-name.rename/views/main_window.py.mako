<%
  project_name_pascal = utils.pascal_case(config["project_name"])
%>\
# Qt application main window

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
