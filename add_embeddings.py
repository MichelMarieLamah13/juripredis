import os.path
import sys
import time

import pandas as pd
from tqdm import tqdm
from transformers import AutoTokenizer, AutoModel

from model import get_embeddings


def get_human_readable(duration):
    minutes, seconds = divmod(int(duration), 60)
    hours, minutes = divmod(minutes, 60)
    days, hours = divmod(hours, 24)
    return f"Duration {days} days, {hours} hours, {minutes} minutes, {seconds} seconds"


def generate_embeddings(df, model, tokenizer):
    n_rows = len(df)
    embeddings = []
    beginning = time.time()
    start_time = beginning
    updated_interval = 3600

    print(f"Generating embedings for each passage: ")
    for i, row in df.iterrows():
        chunk = row['passage']
        embedding = get_embeddings(chunk, model, tokenizer)
        embeddings.append(embedding)
        current_time = time.time()
        elapsed_time = current_time - start_time
        if (elapsed_time >= updated_interval) or i == 0:
            duration = current_time - beginning
            print(f"\t [{i + 1} / {n_rows}] = {round((i + 1) / n_rows)} % => {get_human_readable(duration)}")
            time.sleep(60)  # Sleep for 60 s after each hour
            start_time = time.time()
    df['embedding'] = embeddings
    df.to_csv(f'judilibre_v/judilibre_v_embeddings.tsv', index=False)

    return df


if __name__ == "__main__":
    tokenizer = AutoTokenizer.from_pretrained('antoinelouis/biencoder-mMiniLMv2-L12-mmarcoFR')
    model = AutoModel.from_pretrained('antoinelouis/biencoder-mMiniLMv2-L12-mmarcoFR')
    df_passages = pd.read_csv('judilibre_v/judilibre_v_passages.tsv')

    df_embeddings = generate_embeddings(df_passages, model, tokenizer)
