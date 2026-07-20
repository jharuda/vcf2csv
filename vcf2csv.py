#!/usr/bin/env python

import typing
import pathlib
import argparse
import json
import csv

def parse_vcf(path_input: str) -> list:
    data = []
    id = 0
    with open(path_input, 'r') as f:
        file_iter = iter(f)
        for line_delim in file_iter:
            line = line_delim.replace('\n', '')
            if line == "BEGIN:VCARD":
                is_field_skipped = False
                id += 1
                data_line = { 'ID': id }
            elif line == "END:VCARD":
                data.append(data_line)
            else:
                key = line.split(':')[0]
                if ';' in key:
                   key_part = key.split(';')[0]
                else:
                   key_part = key

                if key.startswith('N') or key.startswith('FN'):
                   # This is special treatment for UTF-8 characters and for multiline
                   is_utf8 = False
                   value = line.split(':')[1]
                   if "CHARSET=UTF-8" in key:
                       is_utf8 = True
                       key = key.split(';')[0]
                   if value.endswith('='):
                       value = value[:-1]
                       value += next(file_iter)
                   value = value.replace(';', '')
                   decoded_value = ""
                   if value.startswith('='):
                       for v in list(zip(*[iter(value)] * 3)):
                           if v[0] == '=':
                               decoded_value += f"{v[1]}{v[2]}"
                           else:
                               raise RuntimeError(f"= is not present in the N/FN data part. There is '{ v[0] }'")
                       value = bytes.fromhex(decoded_value).decode('utf-8')
                else:
                    key = key.replace(';', '_')
                    # 'TEL' is one example with multiple semicolons in the key
                    #if ";" in key:
                    #    key = key.split(';')[0]
                    value = line.split(':')[1]
                data_line[key] = value
    return data


def export_json(data: dict, path_output: str) -> None:
    with open(path_output, 'w') as f:
        json.dump(data, f)


def export_csv(data: dict, path_output: str) -> None:
    fieldnames = []
    for v in data:
        [fieldnames.append(field) for field in v.keys() if field not in fieldnames]

    with open(path_output, 'w') as f:
        writer = csv.DictWriter(f, fieldnames=fieldnames)
        writer.writeheader()

        writer.writerows(data)


def nice_print(data: Any) -> None:
    for d in data:
        print('=' * 10)
        for value in d.items():
            print(f"{value[0]}: {value[1]}")
        print('=' * 10)


def skip_fields(data: list[dict], fields_to_skip: list[str]) -> None:
    for d in data:
        for f in fields_to_skip:
            try:
                del d[f]
            except KeyError:
                raise ValueError(f"The field '{f}' cannot be deleted.") from None


def skip_contacts(data: list[dict], contacts_to_skip: list[str]) -> list[str]:
    data_skipped = []
    for c in contacts_to_skip:
        if int(c) <= 0 or int(c) > len(data):
            raise ValueError(f"The contact ID '{c}' is invalid. Can not remove it.")

    for r in data:
        if r['ID'] not in list(map(int, contacts_to_skip)):
            data_skipped.append(r)

    for i, d in enumerate(data_skipped):
        data_skipped[i]['ID'] = i + 1
    return data_skipped


def parse_args() -> Any:
    parser = argparse.ArgumentParser(
                        prog='vcf2csv',
                        description='The script converts Android contacts VCF file to CSV.')
    parser.add_argument('-i', '--input', help='Input path to the .vcf file', type=pathlib.Path, required=True)
    parser.add_argument('-o', '--output', help='Output path where to export .csv file', type=pathlib.Path)
    parser.add_argument('-j', '--json', help='Output path where to export JSON file', type=pathlib.Path)
    parser.add_argument('-s', '--skip-fields', help="Skip some VCF 'field' from output", nargs='*')
    parser.add_argument('-S', '--skip-contacts', help="Skip VCF 'contact' from output based on ID", nargs='*')
    parser.add_argument('-n', '--nice-print', help='Print data on STDOUT and format it properly', action="store_true")
    return parser.parse_args()


def main() -> list:
    args = parse_args()
    data = parse_vcf(args.input)

    if args.skip_fields: skip_fields(data, args.skip_fields)
    if args.skip_contacts: data = skip_contacts(data, args.skip_contacts)

    if args.json:
        export_json(data, args.json)
    elif args.output:
        export_csv(data, args.output)
    elif args.nice_print:
        nice_print(data)
    else:
        print(data)


if __name__ == "__main__":
    main()
