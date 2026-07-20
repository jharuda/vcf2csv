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


test_1() {
    id_test="1"
    header_start "$id_test"
    file="${DATA_DIR}/contacts_1_version2-1.vcf"
    test_folder="test_${id_test}"

    print_info "Check for printed result with short opt input"
    output_file_1="${TMP_DIR}/test${id_test}_print.out"
    params_1="-i ${file}"
    print_params "$params_1"
    $PROGRAM_EXEC $params_1 > "${output_file_1}"
    check_test_result "${output_file_1}" "${DATA_DIR}/${test_folder}/test_print.out" $? 0

    print_info "Check for printed result long opt input"
    output_file_2="${TMP_DIR}/test${id_test}_print.out"
    params_2="--input ${file}"
    print_params "$params_2"
    $PROGRAM_EXEC $params_2 > "${output_file_2}"
    check_test_result "${output_file_2}" "${DATA_DIR}/${test_folder}/test_print.out" $? 0

    print_info "Check for output JSON with long option"
    output_file_3="${TMP_DIR}/test${id_test}_long_opt.json"
    params_3="-i ${file} --json ${output_file_3}"
    print_params "$params_3"
    $PROGRAM_EXEC $params_3
    check_test_result "${output_file_3}" "${DATA_DIR}/${test_folder}/test.json" $? 0

    print_info "Check for output JSON with short option"
    output_file_4="${TMP_DIR}/test${id_test}_short_opt.json"
    params_4="-i ${file} -j ${output_file_4}"
    print_params "$params_4"
    $PROGRAM_EXEC $params_4
    check_test_result "${output_file_4}" "${DATA_DIR}/${test_folder}/test.json" $? 0

    print_info "Check for output CSV with long option"
    output_file_5="${TMP_DIR}/test${id_test}_long_opt.csv"
    params_5="-i ${file} --output ${output_file_5}"
    print_params "$params_5"
    $PROGRAM_EXEC $params_5
    check_test_result "${output_file_5}" "${DATA_DIR}/${test_folder}/test.csv" $? 0

    print_info "Check for output CSV with short option"
    output_file_6="${TMP_DIR}/test${id_test}_short_opt.csv"
    params_6="-i ${file} --output ${output_file_6}"
    print_params "$params_6"
    $PROGRAM_EXEC $params_6
    check_test_result "$output_file_6" "${DATA_DIR}/${test_folder}/test.csv" $? 0

    print_info "Check for printed nice result with short opt input"
    output_file_7="${TMP_DIR}/test${id_test}_nice_print_long_opt.out"
    params_7="-i ${file} --nice"
    print_params "$params_7"
    $PROGRAM_EXEC $params_7 > "${output_file_7}"
    check_test_result "${output_file_7}" "${DATA_DIR}/${test_folder}/test_nice_print.out" $? 0

    print_info "Check for printed nice result long opt input"
    output_file_8="${TMP_DIR}/test${id_test}_nice_print_short_opt.out"
    params_8="-i ${file} -n"
    print_params "$params_8"
    $PROGRAM_EXEC $params_8 > "${output_file_8}"
    check_test_result "${output_file_8}" "${DATA_DIR}/${test_folder}/test_nice_print.out" $? 0

    footer_end
}

test_2() {
    id_test="2"
    header_start "$id_test"
    file="${DATA_DIR}/contacts_2_version2-1.vcf"
    test_folder="test_${id_test}"

    print_info "Check for printed result with short opt input"
    output_file_1="${TMP_DIR}/test${id_test}_print.out"
    params_1="-i ${file}"
    print_params "$params_1"
    $PROGRAM_EXEC $params_1 > "${output_file_1}"
    check_test_result "${output_file_1}" "${DATA_DIR}/${test_folder}/test_print.out" $? 0

    print_info "Check for printed result long opt input"
    output_file_2="${TMP_DIR}/test${id_test}_print.out"
    params_2="--input ${file}"
    print_params "$params_2"
    $PROGRAM_EXEC $params_2 > "${output_file_2}"
    check_test_result "${output_file_2}" "${DATA_DIR}/${test_folder}/test_print.out" $? 0

    print_info "Check for output JSON with long option"
    output_file_3="${TMP_DIR}/test${id_test}_long_opt.json"
    params_3="-i ${file} --json ${output_file_3}"
    print_params "$params_3"
    $PROGRAM_EXEC $params_3
    check_test_result "${output_file_3}" "${DATA_DIR}/${test_folder}/test.json" $? 0

    print_info "Check for output JSON with short option"
    output_file_4="${TMP_DIR}/test${id_test}_short_opt.json"
    params_4="-i ${file} -j ${output_file_4}"
    print_params "$params_4"
    $PROGRAM_EXEC $params_4
    check_test_result "${output_file_4}" "${DATA_DIR}/${test_folder}/test.json" $? 0

    print_info "Check for output CSV with long option"
    output_file_5="${TMP_DIR}/test${id_test}_long_opt.csv"
    params_5="-i ${file} --output ${output_file_5}"
    print_params "$params_5"
    $PROGRAM_EXEC $params_5
    check_test_result "${output_file_5}" "${DATA_DIR}/${test_folder}/test.csv" $? 0

    print_info "Check for output CSV with short option"
    output_file_6="${TMP_DIR}/test${id_test}_short_opt.csv"
    params_6="-i ${file} --output ${output_file_6}"
    print_params "$params_6"
    $PROGRAM_EXEC $params_6
    check_test_result "$output_file_6" "${DATA_DIR}/${test_folder}/test.csv" $? 0

    print_info "Check for printed nice result with short opt input"
    output_file_7="${TMP_DIR}/test${id_test}_nice_print_long_opt.out"
    params_7="-i ${file} --nice"
    print_params "$params_7"
    $PROGRAM_EXEC $params_7 > "${output_file_7}"
    check_test_result "${output_file_7}" "${DATA_DIR}/${test_folder}/test_nice_print.out" $? 0

    print_info "Check for printed nice result long opt input"
    output_file_8="${TMP_DIR}/test${id_test}_nice_print_short_opt.out"
    params_8="-i ${file} -n"
    print_params "$params_8"
    $PROGRAM_EXEC $params_8 > "${output_file_8}"
    check_test_result "${output_file_8}" "${DATA_DIR}/${test_folder}/test_nice_print.out" $? 0

    footer_end
}

test_3() {
    id_test="3"
    header_start "$id_test"
    file="${DATA_DIR}/contacts_3_version2-1.vcf"
    test_folder="test_${id_test}"

    print_info "Check for printed result with short opt input"
    output_file_1="${TMP_DIR}/test${id_test}_print.out"
    params_1="-i ${file}"
    print_params "$params_1"
    $PROGRAM_EXEC $params_1 > "${output_file_1}"
    check_test_result "${output_file_1}" "${DATA_DIR}/${test_folder}/test_print.out" $? 0

    print_info "Check for printed result long opt input"
    output_file_2="${TMP_DIR}/test${id_test}_print.out"
    params_2="--input ${file}"
    print_params "$params_2"
    $PROGRAM_EXEC $params_2 > "${output_file_2}"
    check_test_result "${output_file_2}" "${DATA_DIR}/${test_folder}/test_print.out" $? 0

    print_info "Check for output JSON with long option"
    output_file_3="${TMP_DIR}/test${id_test}_long_opt.json"
    params_3="-i ${file} --json ${output_file_3}"
    print_params "$params_3"
    $PROGRAM_EXEC $params_3
    check_test_result "${output_file_3}" "${DATA_DIR}/${test_folder}/test.json" $? 0

    print_info "Check for output JSON with short option"
    output_file_4="${TMP_DIR}/test${id_test}_short_opt.json"
    params_4="-i ${file} -j ${output_file_4}"
    print_params "$params_4"
    $PROGRAM_EXEC $params_4
    check_test_result "${output_file_4}" "${DATA_DIR}/${test_folder}/test.json" $? 0

    print_info "Check for output CSV with long option"
    output_file_5="${TMP_DIR}/test${id_test}_long_opt.csv"
    params_5="-i ${file} --output ${output_file_5}"
    print_params "$params_5"
    $PROGRAM_EXEC $params_5
    check_test_result "${output_file_5}" "${DATA_DIR}/${test_folder}/test.csv" $? 0

    print_info "Check for output CSV with short option"
    output_file_6="${TMP_DIR}/test${id_test}_short_opt.csv"
    params_6="-i ${file} --output ${output_file_6}"
    print_params "$params_6"
    $PROGRAM_EXEC $params_6
    check_test_result "$output_file_6" "${DATA_DIR}/${test_folder}/test.csv" $? 0

    print_info "Check for printed nice result with short opt input"
    output_file_7="${TMP_DIR}/test${id_test}_nice_print_long_opt.out"
    params_7="-i ${file} --nice"
    print_params "$params_7"
    $PROGRAM_EXEC $params_7 > "${output_file_7}"
    check_test_result "${output_file_7}" "${DATA_DIR}/${test_folder}/test_nice_print.out" $? 0

    print_info "Check for printed nice result long opt input"
    output_file_8="${TMP_DIR}/test${id_test}_nice_print_short_opt.out"
    params_8="-i ${file} -n"
    print_params "$params_8"
    $PROGRAM_EXEC $params_8 > "${output_file_8}"
    check_test_result "${output_file_8}" "${DATA_DIR}/${test_folder}/test_nice_print.out" $? 0

    footer_end
}


test_4() {
    id_test="4"
    header_start "$id_test"
    file="${DATA_DIR}/contacts_3_version2-1.vcf"
    test_folder="test_${id_test}"

    print_info "Check for printed result with skipped field"
    output_file_1="${TMP_DIR}/test${id_test}_print_skip_field.out"
    params_1="-i ${file} --skip-fields FN"
    print_params "$params_1"
    $PROGRAM_EXEC $params_1 > "${output_file_1}"
    check_test_result "${output_file_1}" "${DATA_DIR}/${test_folder}/test_print.out" $? 0

    print_info "Check for printed result with skipped field"
    output_file_2="${TMP_DIR}/test${id_test}_print_skip_field.out"
    params_2="-i ${file} -s FN"
    print_params "$params_2"
    $PROGRAM_EXEC $params_2 > "${output_file_2}"
    check_test_result "${output_file_2}" "${DATA_DIR}/${test_folder}/test_print.out" $? 0

    print_info "Check for output JSON with skipped field"
    output_file_3="${TMP_DIR}/test${id_test}_skip_field.json"
    params_3="-i ${file} --json ${output_file_3} -s FN"
    print_params "$params_3"
    $PROGRAM_EXEC $params_3
    check_test_result "${output_file_3}" "${DATA_DIR}/${test_folder}/test.json" $? 0

    print_info "Check for output CSV with skipped field"
    output_file_4="${TMP_DIR}/test${id_test}_skip_field.csv"
    params_4="-i ${file} --output ${output_file_4} -s FN"
    print_params "$params_4"
    $PROGRAM_EXEC $params_4
    check_test_result "${output_file_4}" "${DATA_DIR}/${test_folder}/test.csv" $? 0

    print_info "Check for output nice print with skipped field"
    output_file_5="${TMP_DIR}/test${id_test}_nice_print_skip_field.out"
    params_5="-i ${file} --nice -s FN"
    print_params "$params_5"
    $PROGRAM_EXEC $params_5 > "${output_file_5}"
    check_test_result "${output_file_5}" "${DATA_DIR}/${test_folder}/test_nice_print.out" $? 0

    footer_end
}


main() {
    TMP_DIR="$( mktemp -d )"
    failed_tests=0
    succ_tests=0

    test_1 # one record
    test_2 # two records
    test_3 # three resords
    test_4 # skip field and three records

    echo "=========================="
    echo -e "${BHF_COLOR_RED}FAILED TESTS:${BHF_COLOR_DEFAULT}    $failed_tests"
    echo -e "${BHF_COLOR_GREEN}PASSED TESTS:${BHF_COLOR_DEFAULT}    $succ_tests"
    echo -e "NUMBER OF TESTS: $(( failed_tests + succ_tests  ))"
}


main
