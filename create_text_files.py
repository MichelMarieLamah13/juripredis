import os
import shutil

from tqdm import tqdm


def init_dir():
    path = 'judilibre_json/data'
    if os.path.exists(path):
        shutil.rmtree(path)
        print(f"Directory '{path}' and its contents have been removed.")
    os.makedirs(path)


def create_files():
    init_dir()
    with open('judilibre_json/judilibre_json.tsv') as file:
        # Get total line
        total_lines = sum(1 for _ in file)
        # Reset the file pointer to the beginning of the file
        file.seek(0)

        for line in tqdm(file, total=total_lines, desc="Creating Data File", unit="lines"):
            # Split the line into fields based on tabs
            fields = line.split('\t')

            # We get the id and the text_raw
            if len(fields) == 2:
                id_dec = fields[0]
                text_raw = fields[1]
            else:
                print(fields)
                continue

            with open(f"judilibre_json/data/{id_dec}.tsv", 'a+') as passage_file:
                # Append the data to the file
                passage_file.write(text_raw)


if __name__ == "__main__":
    create_files()
