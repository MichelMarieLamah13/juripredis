import os.path
import sys

import pandas as pd


def remove_files(files):
    for file in files:
        path = f'judilibre_v/{file}'
        if os.path.exists(path):
            os.remove(path)
    print(f"{len(files)} files removed successfully")
    sys.stdout.flush()


def create_data(files):
    dfs = [pd.read_csv(f'judilibre_v/{file}') for file in files]
    df = pd.concat(dfs, ignore_index=True)
    df = df.rename(columns={'chunck': 'chunk'})
    df.to_csv('judilibre_v/judilibre_v_data.tsv', index=False)
    print("Data created successfully")
    sys.stdout.flush()


if __name__ == "__main__":
    files = [
        "judilibre_v_embeddings_0_975394.tsv",
        "judilibre_v_embeddings_975395_1950789.tsv",
        "judilibre_v_embeddings_1950790_2926184.tsv",
        "judilibre_v_embeddings_2926185_3901579.tsv",
        "judilibre_v_embeddings_3901580_4876974.tsv",
        "judilibre_v_embeddings_4876975_5852369.tsv",
        "judilibre_v_embeddings_5852370_6827764.tsv",
        "judilibre_v_embeddings_6827765_7803159.tsv",
        "judilibre_v_embeddings_7803160_8778554.tsv",
        "judilibre_v_embeddings_8778555_9753949.tsv"
    ]
    create_data(files)
    remove_files(files)
