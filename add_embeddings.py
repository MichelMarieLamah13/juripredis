import pandas as pd
from tqdm import tqdm
from transformers import AutoTokenizer, AutoModel

from model import get_embeddings


def generate_embeddings(df, model, tokenizer):
    n_rows, _ = df.shape
    embeddings = []
    for i in tqdm(range(n_rows), desc="Generating Embeddings", unit=" passage"):
        chunk = df['passage'][i]
        embedding = get_embeddings(chunk, model, tokenizer)
        embeddings.append(embedding)
    df['embedding'] = embeddings
    df.to_csv(f'judilibre_v/embeddings.tsv', index=False)
    return df


if __name__ == "__main__":
    tokenizer = AutoTokenizer.from_pretrained('antoinelouis/biencoder-mMiniLMv2-L12-mmarcoFR')
    model = AutoModel.from_pretrained('antoinelouis/biencoder-mMiniLMv2-L12-mmarcoFR')
    df_passages = pd.read_csv('judilibre_v/passages.tsv')

    df_embeddings = generate_embeddings(df_passages, model, tokenizer)
