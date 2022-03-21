set -euo pipefail
e() { 2>&1 printf "%s%s%s\n" "$(tput setaf 1)" "$@" "$(tput sgr0)"; }
w() { 2>&1 printf "%s%s%s\n" "$(tput setaf 3)" "$@" "$(tput sgr0)"; }
i() { 2>&1 printf "%s%s%s\n" "$(tput setaf 7)" "$@" "$(tput sgr0)"; }
t() { local s=$?; e "$0:${BASH_LINENO[0]} $BASH_COMMAND"; exit $s; }
trap t ERR

script_dir="$(cd "$(dirname "${BASH_SOURCE[1]}")/" && pwd)"
root_dir="$(cd "$(dirname "$script_dir")/" && pwd)"
docker_tag_name="python-chromedriver"
export script_dir root_dir docker_tag_name
