import sys
import os
import re
import pathlib


def extract_lab_info(filename):
    match = re.match(r"Lab_(\d+)_g(\d+).txt", filename)
    return int(match.group(1)), int(match.group(2))

def load_lab_results(filepath):
    results = {}
    students = {}
    labs = set()

    for filename in os.listdir(filepath):
        if filename.startswith('Lab') and filename.endswith('.txt'):
            lab, _ = extract_lab_info(filename)
            labs.add(lab)

            with open(filepath.resolve() / filename, 'r') as file:
                for line in file:
                    jmbag, result = line.rstrip().split()
                    if (jmbag, lab) in results:
                        print(f"Ponavlja se: {jmbag}, {lab}")
                    else:
                        results[(jmbag, lab)] = result
        elif filename == "studenti.txt":
            with open(filepath.resolve() / filename, 'r') as file:
                for line in file:
                    jmbag, name = line.rstrip().split(' ', 1)
                    students[jmbag] = name

    return results, sorted(labs), students

def print_results(students, results, labs):
    header = f"{'JMBAG':<15} {'Prezime, ime':<20}"
    for lab in labs:
        header += f"L{lab:<4}"

    print(header)

    for jmbag, name in students.items():
        line = f"{jmbag:<15} {name:<18}"
        for lab in labs:
            line += f"{results.get((jmbag, lab), '-'):>5}"
        else:
            print(line)

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Koristenje: python zadatak3.py <putanja_do_direktorija>")
        exit(1)

    filepath = pathlib.Path(sys.argv[1])
    results, labs, students = load_lab_results(filepath)
    print_results(students, results, labs)
