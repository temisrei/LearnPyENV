FROM nvidia/cuda:10.2-cudnn7-runtime-ubuntu18.04

LABEL maintainer="Rei Lin" email="temisrei@gmail.com" version="v0.2.0"

ENV PYTHONIOENCODING UTF-8

# install python 3.6, 3.7 and pip
RUN apt-get update \
    && apt-get install -y python3.7-dev \
    && apt-get install -y python3-pip \
    && cd /usr/local/bin \
    && ln -s /usr/bin/python3 python \
    && pip3 install --upgrade pip

# install requirements and prerequisite
RUN apt-get install -y --assume-yes --no-install-recommends build-essential \
    && rm -rf /var/lib/apt/lists/*

# copy require
COPY ./requirements.txt ./

# install required packages
RUN pip install --no-cache-dir --requirement ./requirements.txt

WORKDIR /workspace
COPY ./hello.py /workspace

EXPOSE 8888

CMD [ "python", "hello.py" ]
