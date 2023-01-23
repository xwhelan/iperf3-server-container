# Build an iperf3 container
FROM alpine:latest AS alpine
RUN apk --no-cache add iperf3

FROM alpine AS iperf
EXPOSE 5201
CMD ["/usr/bin/iperf3", "--server", "--port", "5201"]
