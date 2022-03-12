FROM python:3.10-alpine
LABEL maintaner="Danish Danial" 

ENV PYTHONBUFFERED 1

COPY ./requirements.txt /requirements.txt
RUN apk add --update --no-cache postgresql-client
RUN apk add --update --no-cache --virtual .tmp-build \
    gcc libc-dev linux-headers postgresql-dev
RUN pip install -r /requirements.txt
RUN apk del .tmp-build

RUN mkdir /application
WORKDIR /application
COPY ./application /application

RUN adduser -D user
USER user

