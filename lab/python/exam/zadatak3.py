import sys
import pathlib


def print_addresses(list_of_items):
    print("--------------------------------")
    print("  IP adrese   |  Br. pristupa")
    print("--------------------------------")

    for ip, num in sorted(list_of_items, key=lambda x: x[1], reverse=True):
        print(f"{ip:>12}     {num}")

    print("--------------------------------")

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Upute: python zadatak3.py <ime_log_datoteke>")
        sys.exit(1)

    filename = pathlib.Path(sys.argv[1])

    with open(filename, "r") as f:
        lines = [x.strip() for x in f.readlines()]

    ip_addr = {}

    for line in lines:
        parts = line.split()
        
        ip = parts[0]
        addresses = ip.split(".")
        subnet = addresses[0] + "." + addresses[1] + ".*.*"
        no_of_bytes = parts[-1]

        if no_of_bytes != "-":
            if subnet in ip_addr:
                ip_addr[subnet] += int(no_of_bytes)
            else:
                ip_addr[subnet] = int(no_of_bytes)
   
    list_of_items = []

    for elem in ip_addr:
        list_of_items.append((elem, ip_addr[elem]))

    print_addresses(list_of_items)
