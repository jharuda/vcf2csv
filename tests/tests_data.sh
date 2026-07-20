#!/bin/bash


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


run_tests() {
    test_1 # one record$
    test_2 # two records$
    test_3 # three resords$
    test_4 # skip field and three records$
}
