import os

import pandas as pd
import torch
from tqdm import tqdm
from transformers import AutoTokenizer


def split_text_into_passages(text, tokenizer, prev_include=2):
    """
    Split text into passage with maximum number of char per passage and number of char of the previous
    passage to include in the following
    :param text:  string the text to split
    :param tokenizer: tokenizer utilise
    :param prev_include: int number of char of the previous to include in the following
    :return:
    """
    passages = []
    current_passage = []
    passage_ends = []
    lines = text.splitlines()

    current_passage_tokens = []
    for i, line in enumerate(lines):
        words = line.split()
        for j, word in enumerate(words):
            word_tokens = tokenizer.encode(word)
            if len(current_passage_tokens) + len(word_tokens) <= tokenizer.model_max_length:
                current_passage.append(word)
                current_passage_tokens.extend(word_tokens)
            else:
                passages.append(" ".join(current_passage))
                passage_ends.append(i + 1)
                old_current_passage = current_passage
                current_passage = [word]
                current_passage_tokens = word_tokens
                if prev_include > 0:
                    for z in range(prev_include):
                        token_to_add = old_current_passage[-1 * (z + 1)]
                        wt = tokenizer.encode(token_to_add)
                        if len(current_passage_tokens) + len(wt) <= tokenizer.model_max_length:
                            current_passage = [token_to_add] + current_passage
                            current_passage_tokens = wt + current_passage_tokens
                        else:
                            break

    if current_passage:
        passages.append(" ".join(current_passage))
        passage_ends.append(len(lines))

    chunks = list(range(1, len(passages) + 1))

    df = pd.DataFrame({'chunck': chunks, 'line': passage_ends, 'passage': passages})
    return df


def get_all_tsv_file():
    """
    Get the name of all data file
    :return:
    """
    path = 'judilibre_json/data'
    tsv_files = []
    if os.path.exists(path) and os.path.isdir(path):
        tsv_files = [f for f in os.listdir(path) if f.endswith(".tsv")]
    return tsv_files


def read_file(filename):
    """
    To read the file
    :param filename: string the name of the file
    :return: string  the content of the file
    """
    with open(f'judilibre_json/data/{filename}') as file:
        content = file.read()
    return content


def generate_passages(tokenizer, prev_include=2):
    all_tsv_files = get_all_tsv_file()
    all_dfs = []

    for filename in tqdm(all_tsv_files, total=len(all_tsv_files), desc="Generating Passages", unit=" file"):
        id_dec, _ = os.path.splitext(filename)
        text = read_file(filename)
        df = split_text_into_passages(text, tokenizer, prev_include)
        n_rows, _ = df.shape
        df.insert(0, 'id_dec', [id_dec] * n_rows)
        all_dfs.append(df)

    df_judilibre_v = pd.concat(all_dfs, ignore_index=True)
    df_judilibre_v.to_csv(f'judilibre_v/judilibre_v_passages.tsv', index=False)

    return df_judilibre_v


if __name__ == "__main__":
    tokenizer = AutoTokenizer.from_pretrained('antoinelouis/biencoder-mMiniLMv2-L12-mmarcoFR')
    df_passages = generate_passages(tokenizer)
