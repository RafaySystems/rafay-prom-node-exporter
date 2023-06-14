FROM golang:1.20.5 AS build

WORKDIR /go/src/RafaySystems/rafay-prom-node-exporter
COPY . .
RUN go mod download

RUN make build

ARG ARCH="amd64"
ARG OS="linux"
FROM quay.io/prometheus/busybox:latest
LABEL maintainer="The Prometheus Authors <prometheus-developers@googlegroups.com>"

COPY --from=build /go/src/RafaySystems/rafay-prom-node-exporter/node_exporter /bin/node_exporter

EXPOSE      9100
USER        nobody
ENTRYPOINT  [ "/bin/node_exporter" ]
