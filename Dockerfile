FROM golang:1.19.1

ENV BGG_USERNAME=""
ENV BGG_PASSWORD=""

WORKDIR /app

RUN apt-get update && apt-get install -y \
  libxml2 \
  libxml2-dev \
 && rm -rf /var/lib/apt/lists/*

COPY go.mod go.sum ./
RUN go mod download
COPY *.go ./
RUN go build -o /usr/local/bin/bgg-ranked-csv

COPY bgg-ranked-csv.sh /usr/local/bin/bgg-ranked-csv.sh

CMD [ "bgg-ranked-csv.sh" ]
