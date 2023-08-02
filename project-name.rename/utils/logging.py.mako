## Hey Emacs, this is -*- coding: utf-8 -*-
<%
  project_name = utils.snake_case(config["project_name"])
%>\
import logging

from ${project_name} import __name__ as name

log_formatter = logging.Formatter("%(asctime)s - %(levelname)s - %(message)s")

logger = logging.getLogger(name)
logger.setLevel(logging.INFO)

# Log to stderr
console_handler = logging.StreamHandler()
console_handler.setLevel(logging.INFO)
console_handler.setFormatter(log_formatter)
logger.addHandler(console_handler)

# Create log file
file_handler = logging.FileHandler(f"{name}.log", mode="w")
file_handler.setLevel(logging.INFO)
file_handler.setFormatter(log_formatter)
logger.addHandler(file_handler)
