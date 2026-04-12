FROM python:3.10.8-slim-buster

# 🔧 Added archive fix (buster EOL)
RUN sed -i 's/deb.debian.org/archive.debian.org/g' /etc/apt/sources.list && \
    sed -i 's/security.debian.org/archive.debian.org/g' /etc/apt/sources.list

RUN apt update -o Acquire::Check-Valid-Until=false && apt upgrade -y
RUN apt install git -y

COPY requirements.txt /requirements.txt

RUN cd /
RUN pip3 install -U pip && pip3 install -U -r requirements.txt

RUN mkdir /VJ-Forward-Bot
WORKDIR /VJ-Forward-Bot

COPY . /VJ-Forward-Bot

CMD gunicorn app:app & python3 main.py
