import sys
import pathlib

from collections import defaultdict


def print_addresses(list_of_items):
    print("--------------------------------")
    print("  IP adrese   |  Br. pristupa   ")
    print("--------------------------------")

    for ip, num in sorted(list_of_items, key=lambda pair: pair[1], reverse=True):
        print(f"{ip:>12}{num:>11}")

    print("--------------------------------")

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Upute: python zadatak3.py <ime_log_datoteke>")
        sys.exit(1)

    filename = pathlib.Path(sys.argv[1])
    ip_addresses = defaultdict(int)

    with open(filename, "r") as f:
        for line in f:
            parts = line.strip().split()

            addresses = parts[0].split(".")
            subnet = f"{addresses[0]}.{addresses[1]}.*.*"
            no_of_bytes = parts[-1]

            if no_of_bytes.isdigit():  # Is not '-'
                ip_addresses[subnet] += int(no_of_bytes)

    print_addresses(list(ip_addresses.items()))
