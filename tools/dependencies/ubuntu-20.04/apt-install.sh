#!/bin/bash

set -eu
set -o pipefail

echo
CMD=(sudo apt install libxcb-cursor0)
echo + "${CMD[@]}" && "${CMD[@]}"
