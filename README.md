# vcf2csv

## Introduction

This program converts [vCard also know as VCF (Virtual Contact File)](https://en.wikipedia.org/wiki/VCard) to human readable format such as [CSV](https://en.wikipedia.org/wiki/Comma-separated_values). There are some supported output formats like CSV, JSON, Python dictionary and formated print. This program requires Python programming language installed on your system.

This has only been tested on VCF version `2.1`.

## Usage

### Basic usage (Python dictionary)

This will print output data to stdout. It uses input file as required parameter.
All of those examples have also short version of parameters.

```
python ./vcf2csv.py --input tests/data/contacts_3_version2-1.vcf

# or short version

python ./vcf2csv.py -i tests/data/contacts_3_version2-1.vcf
```

### CSV

```
python ./vcf2csv.py -i tests/data/contacts_3_version2-1.vcf --output ./out.csv
```

### JSON

```
python ./vcf2csv.py -i tests/data/contacts_3_version2-1.vcf --json ./out.json
```

### Nice print

```
python ./vcf2csv.py -i tests/data/contacts_3_version2-1.vcf --nice
```

### Skip field

There are fields such as ID, N, FN, TEL_CELL_PREF and others. You can skip this field.

```
python ./vcf2csv.py -i tests/data/contacts_3_version2-1.vcf --skip-fields FN
```

### Skip contacts

You can skip contacts based on ID.

```
python ./vcf2csv.py -i tests/data/contacts_3_version2-1.vcf --skip-contacts 2
```

### Help

```
usage: vcf2csv [-h] -i INPUT [-o OUTPUT] [-j JSON] [-s [SKIP_FIELDS ...]] [-S [SKIP_CONTACTS ...]] [-n]

The script converts Android contacts VCF file to CSV.

options:
  -h, --help            show this help message and exit
  -i, --input INPUT     Input path to the .vcf file
  -o, --output OUTPUT   Output path where to export .csv file
  -j, --json JSON       Output path where to export JSON file
  -s, --skip-fields [SKIP_FIELDS ...]
                        Skip some VCF 'field' from output
  -S, --skip-contacts [SKIP_CONTACTS ...]
                        Skip VCF 'contact' from output based on ID
  -n, --nice-print      Print data on STDOUT and format it properly
```

### Tests

Tests are placed in the [tests](tests) folder. The test writes to temp folder. The tests are writen in BASH. To run the test use the following command.

```
bash tests/run_tests.sh
```


## License

[MIT](LICENSE)