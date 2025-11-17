FROM alpine:3.17

COPY requirements.txt .

RUN apk add --no-cache python3 py3-pip gcc musl-dev python3-dev libffi-dev yaml-dev && \
    pip3 install --upgrade pip && \
    pip3 install --no-cache-dir -r requirements.txt && \
    apk del gcc musl-dev python3-dev libffi-dev yaml-dev && \
    rm -rf /var/cache/apk/* && \
    rm requirements.txt

RUN aws --version
