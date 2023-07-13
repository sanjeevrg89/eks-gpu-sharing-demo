FROM tensorflow/tensorflow:latest-gpu

COPY . /app

WORKDIR /app

RUN pip install -r requirements.txt

CMD ["python", "cifar10_cnn.py"]
