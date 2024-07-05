
# Use an official Go runtime as a parent image
FROM golang:1.20.4-buster

# Install system dependencies and Git
RUN apt-get update && apt-get install -y wget git net-tools tcpdump iperf


RUN echo 6
# Clone the go-gtp repository
RUN git clone https://github.com/AbdallahRustom/OKS_GO_GTP.git /go-gtp

RUN groupadd -g 1000 open5gs \
    && useradd -r -g open5gs -u 1000 -s /bin/sh open5gs \
    && mkdir /open5gs && chown open5gs:open5gs /open5gs

USER 1000 

WORKDIR /go-gtp
RUN go mod tidy
RUN go build -o ./examples/gw-tester/mme/mme ./examples/gw-tester/mme
RUN go build -o ./examples/gw-tester/enb/enb ./examples/gw-tester/enb


WORKDIR /go-gtp
COPY --chown=open5gs:open5gs init.sh /go-gtp/init.sh
COPY --chown=open5gs:open5gs enb.yml /mnt/enb.yml
COPY --chown=open5gs:open5gs mme.yml /mnt/mme.yml
RUN chmod 777 /mnt/mme.yml
RUN chmod 777 /mnt/enb.yml
CMD /go-gtp/init.sh
