#!/bin/bash

set -eu
set -o pipefail

SNAME="$(basename "${BASH_SOURCE[0]}")"
readonly SNAME

SDPATH="$(dirname "${BASH_SOURCE[0]}")"
if [[ ! -d "${SDPATH}" ]]; then SDPATH="${PWD}"; fi
SDPATH="$(cd "${SDPATH}" && pwd)"
readonly SDPATH

if [[ -z ${1:+-} ]]; then
  echo "Usage: \"${SNAME}\" <command>"
  echo "where command is poetry run <command>"
  exit 1
fi

readonly COMMAND=$1

PRJ_ROOT_PATH="${SDPATH}/.."
PRJ_ROOT_PATH="$(cd "${PRJ_ROOT_PATH}" && pwd)"
readonly PRJ_ROOT_PATH

cd "${PRJ_ROOT_PATH}" && echo + cd "${PWD}"

CMD=(poetry run "${COMMAND}")
echo + "${CMD[@]}" && "${CMD[@]}"
