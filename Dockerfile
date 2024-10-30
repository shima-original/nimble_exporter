FROM golang:1.19.7 AS build
ADD .  /build
RUN cd /build &&  CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o /nimble_exporter && strip /nimble_exporter

FROM ubuntu AS app
COPY --from=build /nimble_exporter /nimble_exporter
CMD ["/nimble_exporter"]
