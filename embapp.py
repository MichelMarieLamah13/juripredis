import torch
from transformers import AutoTokenizer, AutoModel
from flask import Flask, request, jsonify

app = Flask(__name__)

# Load the model and tokenizer
# model_name = "antoinelouis/biencoder-all-MiniLM-L12-v2-mmarcoFR"
model_name = "antoinelouis/biencoder-mMiniLMv2-L12-mmarcoFR"
tokenizer = AutoTokenizer.from_pretrained(model_name)
model = AutoModel.from_pretrained(model_name)


def mean_pooling(model_output, attention_mask):
    token_embeddings = model_output[0]  # First element of model_output contains all token embeddings
    input_mask_expanded = attention_mask.unsqueeze(-1).expand(token_embeddings.size()).float()
    return torch.sum(token_embeddings * input_mask_expanded, 1) / torch.clamp(input_mask_expanded.sum(1), min=1e-9)


def get_embeddings(chunck, model, tokenizer):
    """
    Get the embedding of a passage
    :param chunck: the passage
    :param model: the model
    :param tokenizer: the tokenizer
    :return:
    """
    # Tokenize sentences
    encoded_input = tokenizer(chunck, padding=True, truncation=True, return_tensors='pt')

    # Compute token embeddings
    with torch.no_grad():
        model_output = model(**encoded_input)

    chunk_embeddings = mean_pooling(model_output, encoded_input['attention_mask'])
    return chunk_embeddings.view(-1).numpy().tolist()


@app.route('/embed_new', methods=['GET'])
def embed():
    chunk = request.args.get('data')
    # Generate embeddings
    with torch.no_grad():
        embedding = get_embeddings(chunk, model, tokenizer)

    return jsonify(embedding)


if __name__ == '__main__':
    # app.run(host='0.0.0.0', port=56000)
    app.run(host='0.0.0.0', port=56002)
