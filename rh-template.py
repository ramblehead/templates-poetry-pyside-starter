#!python
# Hey Emacs, this is -*- coding: utf-8; mode: python -*-

import os
import subprocess
from pathlib import Path
from rh_template import expand_and_implode

if __name__ == "__main__":
    expand_and_implode(__file__)

    # sd_path = Path(__file__).parent
    # os.startfile(str(sd_path / "rh_template" / "ms-implode.bat"))


    # subprocess.Popen(
    #     f'python -c "import time; time.sleep(1);" && "{sd_path / "ms-implode.bat"}"',
    #     shell=True,
    # )
