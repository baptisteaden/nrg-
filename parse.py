import argparse
import pdfplumber


def parse_args():
    arg_parser = argparse.ArgumentParser()

    arg_parser.add_argument("--type", "-t", required=True, help="Options: edf")

    arg_parser.add_argument("file", help="Path to the file to process")

    args = arg_parser.parse_args()

    print(f"Args detected: type={args.type} file={args.file}")

    return args


def parse_pdf(type, file):
    data = ""

    with pdfplumber.open(file) as pdf:
        for page in pdf.pages:
            data += page.extract_text()

    return data


args = parse_args()

data = parse_pdf(args.type, args.file)

print("parsed data:\n")

print(data)

# TODO:
# - Get just the info we want (see db.sql)
# - Store them in the db
