FROM debian:bullseye-slim

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -y update && \
    apt-get -y install --no-install-recommends \
        netcat ping bash \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /code
COPY app.sh /code/
RUN apt-get update && apt-get install -y netcat ping
CMD ["bash", "/code/app.sh"]

