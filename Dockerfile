FROM alpine:3.16

COPY requirements.txt .

RUN apk add --no-cache python3 py3-pip && \
    pip3 install --upgrade pip && \
    pip3 install --no-cache-dir -r requirements.txt && \
    rm -rf /var/cache/apk/* && \
    rm requirements.txt

RUN aws --version
