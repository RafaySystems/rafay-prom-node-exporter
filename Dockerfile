FROM golang:1.20.5 AS build

COPY . /src
WORKDIR /src
RUN go mod download


RUN make build


FROM busybox:latest
LABEL maintainer="The Prometheus Authors <prometheus-developers@googlegroups.com>"

COPY --from=build /src/node_exporter /bin/node_exporter

EXPOSE      9100
USER        nobody
ENTRYPOINT  [ "/bin/node_exporter" ]
