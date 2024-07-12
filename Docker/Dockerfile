
# Use an official Go runtime as a parent image
FROM golang:1.20.4-buster as builder

# Install system dependencies and Git
RUN apt-get update && apt-get install -y wget git net-tools tcpdump iperf


# Clone the go-gtp repository
RUN git clone https://github.com/AbdallahRustom/OKS_GO_GTP.git /go-gtp

WORKDIR /go-gtp
RUN go mod tidy
RUN go build -o ./examples/gw-tester/mme/mme ./examples/gw-tester/mme
RUN go build -o ./examples/gw-tester/enb/enb ./examples/gw-tester/enb

FROM golang:1.20.4-buster

RUN apt-get update && apt-get install -y wget git net-tools tcpdump iperf

# RUN groupadd -g 1000 gogtp \
#     && useradd -r -g gogtp -u 1000 -s /bin/sh gogtp \
#     && mkdir /go-gtp && chown gogtp:gogtp /go-gtp

# USER 1000

WORKDIR /go-gtp

COPY --from=builder /go-gtp /go-gtp
RUN chmod 777 /go-gtp
RUN chmod 777 /go-gtp/examples/gw-tester/mme/
RUN chmod 777 /go-gtp/examples/gw-tester/mme/*
RUN chmod 777 /go-gtp/examples/gw-tester/enb/
RUN chmod 777 /go-gtp/examples/gw-tester/enb/*
COPY  init.sh /go-gtp/init.sh
COPY  enb.yml examples/gw-tester/enb/enb.yml
COPY  mme.yml examples/gw-tester/mme/mme.yml
# RUN chmod 777 /go-gtp/examples/gw-tester/enb/enb.yml
# RUN chmod 777 /go-gtp/examples/gw-tester/mme/mme.yml

# COPY --chown=open5gs:open5gs /mnt/enb.yml examples/gw-tester/enb/enb.yml
# COPY --chown=open5gs:open5gs /mnt/mme.yml examples/gw-tester/mme/mme.yml


CMD /go-gtp/init.sh
