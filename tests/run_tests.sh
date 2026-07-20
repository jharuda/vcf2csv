#!/bin/bash


this_script_path="$(realpath "$0")"
this_script_dir="$(dirname $this_script_path)"
DATA_DIR="${this_script_dir}/data"
PROGRAM_EXEC="python3 ${this_script_dir}/../vcf2csv.py"

# Definitions taken from `Bash Helper Functions` framework
# ========================================================
declare -ri _EC_SCRIPT_IS_SOURCED=1

declare -r BHF_COLOR_RED='\033[0;31m'
declare -r BHF_COLOR_GREEN='\033[0;32m'
declare -r BHF_COLOR_DEFAULT='\033[0m'
declare -r BHF_COLOR_BLUE_LIGHT='\033[0;36m'


bhf_print_info() {
    if [ -n "$BHF_NO_COLOR" ]; then
        echo "INFO:    ${1}"
    else
        echo -e "${BHF_COLOR_BLUE_LIGHT}INFO:${BHF_COLOR_DEFAULT}    ${1}"
   fi
} >&2


bhf_print_error() {
    if [ -n "$BHF_NO_COLOR" ]; then
        echo "ERROR:   ${1}"
    else
        echo -e "${BHF_COLOR_RED}ERROR:${BHF_COLOR_DEFAULT}   ${1}"
    fi
} >&2


bhf_error_exit() {
    # Optional 2nd parameter is a number for exit code in range 2-255
    # If the parameter is not supplied then 1 exit code is used by default
    bhf_print_error "$1"
    local -i exit_code="${2:-1}"
    bhf_print_info "Exiting"
    exit "$exit_code"
}


bhf_is_file_identical() {
    diff "$1" "$2" &>/dev/null
}


is_this_script_sourced() {
    # @return 0 if it is sourced, otherwise 1
    [[ "$0" != "${BASH_SOURCE[0]}" ]]
}
# BHF END=================================================


if is_this_script_sourced; then
    bhf_print_error "This script can't be sourced"
    return "$_EC_SCRIPT_IS_SOURCED"
fi


check_test_result() {
    local -r file_given="$1"
    local -r file_expected="$2"
    local -r ec_given="$3"
    local -r ec_expected="$4"
    echo "    output: ${file_given}" 1>&2
    echo "    expected: ${file_expected}" 1>&2
    echo "    exit code is '$ec_given' and expected code is '$ec_expected'" 1>&2
    if bhf_is_file_identical "$file_given" "$file_expected"; then
        if [[ "$ec_given" == "$ec_expected" ]]; then
            ((succ_tests++))
            echo -e "  ${BHF_COLOR_GREEN}passed${BHF_COLOR_DEFAULT}"
            return
        fi
    fi
    ((failed_tests++))
    echo "  files does not match"
    echo -e "  ${BHF_COLOR_RED}failed${BHF_COLOR_DEFAULT}"
}


print_info() {
    bhf_print_info "$1" 2>&1
}


print_params() {
    echo "    params: $1" 1>&2
}


header_start() {
    echo  "===TEST SET $1==="
}

footer_end() {
    echo "---------------"
}


main() {
    TMP_DIR="$( mktemp -d )"
    failed_tests=0
    succ_tests=0


    source ${this_script_dir}/tests_data.sh
    run_tests

    echo "=========================="
    echo -e "${BHF_COLOR_RED}FAILED TESTS:${BHF_COLOR_DEFAULT}    $failed_tests"
    echo -e "${BHF_COLOR_GREEN}PASSED TESTS:${BHF_COLOR_DEFAULT}    $succ_tests"
    echo -e "NUMBER OF TESTS: $(( failed_tests + succ_tests  ))"
}


main
