import argparse
import os.path
import sys
import time

import pandas as pd
from tqdm import tqdm
from transformers import AutoTokenizer, AutoModel

from add_embeddings_local import get_human_readable
from model import get_embeddings


def generate_embeddings(df, model, tokenizer, start, end):
    df = df[start:end].reset_index(drop=True)
    n_rows = len(df)
    embeddings = []
    beginning = time.time()
    start_time = beginning
    updated_interval = 3600

    print(f"Generating embedings for each passage: {start} - {end - 1}")
    sys.stdout.flush()
    for i, row in df.iterrows():
        chunk = row['passage']
        embedding = get_embeddings(chunk, model, tokenizer)
        embeddings.append(embedding)
        current_time = time.time()
        elapsed_time = current_time - start_time
        if (elapsed_time >= updated_interval) or i in [0, n_rows - 1]:
            duration = current_time - beginning
            print(
                f"\t [{i + 1} / {n_rows}] = {round((i + 1) * 100 / n_rows)} % => {get_human_readable(duration)}")
            sys.stdout.flush()
            time.sleep(60)  # Sleep for 60 s after each hour
            start_time = time.time()
    df['embedding'] = embeddings
    df.to_csv(f'judilibre_v/judilibre_v_embeddings_{start}_{end - 1}.tsv', index=False)

    return df


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Getting  embeddings")
    parser.add_argument('--batch_index', type=int, default=1, help='Batch Index')
    args = parser.parse_args()

    tokenizer = AutoTokenizer.from_pretrained('antoinelouis/biencoder-mMiniLMv2-L12-mmarcoFR')
    model = AutoModel.from_pretrained('antoinelouis/biencoder-mMiniLMv2-L12-mmarcoFR')
    df_passages = pd.read_csv('judilibre_v/judilibre_v_passages.tsv')

    step_size = 975395
    start = step_size * (args.batch_index - 1)
    end = step_size * args.batch_index
    df_embeddings = generate_embeddings(df_passages, model, tokenizer, start, end)
