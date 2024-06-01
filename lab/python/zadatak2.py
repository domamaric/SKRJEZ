import sys
import pathlib


def calculate_quantiles(values):
    quantiles = []
    n = len(values)

    for q in range(10, 100, 10):
        index = (q * n) // 101
        quantiles.append(values[index])

    return quantiles

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Koristenje: python zadatak2.py <hipoteze>")
        exit(1)

    input_file = pathlib.Path(sys.argv[1])

    with open(input_file, "r") as file:
        lines = file.readlines()

    print("Hyp#Q10#Q20#Q30#Q40#Q50#Q60#Q70#Q80#Q90")

    for i, line in enumerate(lines):
        values = sorted(map(float, line.split()))

        quantiles = calculate_quantiles(values)
        out_line = f"{i + 1:03d}"
        out_line += ''.join(f"#{q:.1f}" for q in quantiles)

        print(out_line)
