import sys
import pathlib


def parse_matrices(input_file):
    with open(input_file, "r") as file:
        matrices = []
        while True:
            line = file.readline().strip()
            if not line:
                break
            rows, cols = map(int, line.split())
            matrix = {'shape': (rows, cols), 'values': {}}
            while True:
                line = file.readline().strip()
                if not line:
                    break
                row, col, value = line.split()
                matrix['values'][(int(row), int(col))] = float(value)
            matrices.append(matrix)

    return matrices

def multiply_matrices(A, B):
    rows1, cols1 = A['shape']
    rows2, cols2 = B['shape']

    if cols1 != rows2:
        raise ValueError("Ne mogu pomnoziti matrice zbog neispravnih dimenzija!")

    result = [[0] * cols2 for _ in range(rows1)]

    for (i, k), value1 in A['values'].items():
        for j in range(cols2):
            if (k, j) in B['values']:
                result[i][j] += value1 * B['values'][(k, j)]

    sparse_matrix = {'shape': (len(result), len(result[0])), 'values': {}}

    for i, row in enumerate(result):
        for j, value in enumerate(row):
            if value != 0:
                sparse_matrix['values'][(i, j)] = value

    return sparse_matrix

def print_matrix(matrix):
    rows, cols = matrix['shape']
    full_matrix = [[0] * cols for _ in range(rows)]

    for (i, j), value in matrix['values'].items():
        full_matrix[i][j] = value

    for row in full_matrix:
        print('  '.join(f"{value:.2f}" for value in row))
    else:
        print()

def save_result(matrix, output_file):
    with open(output_file, 'w') as file:
        rows, cols = matrix['shape']
        file.write(f"{rows} {cols}\n")

        for (i, j), value in matrix['values'].items():
            file.write(f"{i} {j} {value}\n")
        file.write("\n")

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Koristenje: python zadatak1.py <ulazna_datoteka> <izlazna_datoteka>")
        exit(1)

    input_file = pathlib.Path(sys.argv[1])
    output_file = pathlib.Path(sys.argv[2])
    mat_a, mat_b = parse_matrices(input_file)

    mat_c = multiply_matrices(mat_a, mat_b)

    print("A:")
    print_matrix(mat_a)
    print("B:")
    print_matrix(mat_b)
    print("A*B:")
    print_matrix(mat_c)

    save_result(mat_c, output_file)
