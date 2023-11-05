import os.path
import sys
import time

import pandas as pd

from add_embeddings_local import get_human_readable


def remove_files(files):
    for file in files:
        path = f'judilibre_v/{file}'
        if os.path.exists(path):
            os.remove(path)
    print(f"{len(files)} files removed successfully")
    sys.stdout.flush()


def create_data(files):
    dfs = []
    n_files = len(files)
    duration = 0
    for i, file in enumerate(files):
        start = time.time()
        dfs.append(pd.read_csv(f'judilibre_v/{file}'))
        end = time.time()
        duration += end - start
        print(
            f"\t [{i + 1} / {n_files}] = {round((i + 1) * 100 / n_files)} % => {get_human_readable(end-start)}")
        sys.stdout.flush()
        time.sleep(60)

    print(f"Data array created in: {get_human_readable(duration)}")
    sys.stdout.flush()

    start = time.time()
    df = pd.concat(dfs, ignore_index=True)
    df = df.rename(columns={'chunck': 'chunk'})
    df.to_csv('judilibre_v/judilibre_v_data.tsv', index=False)
    end = time.time()

    print(f"Data saved in: {get_human_readable(end-start)}")
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
