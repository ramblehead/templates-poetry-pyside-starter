# Hey Emacs, this is -*- coding: utf-8 -*-

from string import Template
from typing import TYPE_CHECKING

from autocodegen.utils import snake_case

if TYPE_CHECKING:
    from autocodegen import Context

template_str = """\
# Qt GUI app entry file

import sys
import traceback
from types import TracebackType

from PySide6.QtWidgets import QApplication, QMessageBox

from ${project_name_snake}.utils import logger
from ${project_name_snake}.views import MainWindow


def handleException(
    _type: type[BaseException],
    _value: BaseException,
    _traceback: TracebackType,
) -> None:
    logger.exception(
        "Unhandled exception:",
        exc_info=(_type, _value, _traceback),
    )
    error_details = "".join(
        traceback.format_exception(_type, _value, _traceback),
    )
    QMessageBox.critical(
        None,  # type: ignore reportGeneralTypeIssues
        "Unhandled Exception",
        "An unhandled exception occurred.\\n\\n" + error_details,
    )
    QApplication.quit()


def main() -> None:
    # Start Qt application
    app = QApplication(sys.argv)
    window = MainWindow()
    window.show()

    # Exception handler
    sys.excepthook = handleException

    logger.info("Starting Qt application")
    sys.exit(app.exec())


if __name__ == "__main__":
    main()
"""


def generate(ctx: Context) -> str:
    project_name = ctx.project_config.autocodegen.project_name

    return Template(template_str).substitute(
        {
            "project_name_snake": snake_case(project_name),
        },
    )
