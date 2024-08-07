#!/bin/bash

# BSD 2-Clause License

# Copyright (c) 2020, Supreeth Herle
# All rights reserved.

# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:

# 1. Redistributions of source code must retain the above copyright notice, this
#    list of conditions and the following disclaimer.

# 2. Redistributions in binary form must reproduce the above copyright notice,
#    this list of conditions and the following disclaimer in the documentation
#    and/or other materials provided with the distribution.

# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
# SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
# CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
# OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


ETH0_IP=$(ip addr show dev eth0 | grep -oP 'inet \K[\d.]+')

cp /mnt/mme.yml /go-gtp/examples/gw-tester/mme/mme.yml
cp /mnt/enb.yml /go-gtp/examples/gw-tester/enb/enb.yml

sed -i 's|MCC|'$MCC'|g' examples/gw-tester/enb/enb.yml
sed -i 's|MNC|'$MNC'|g' examples/gw-tester/enb/enb.yml
sed -i 's|ETH0_IP|'$ETH0_IP'|g' examples/gw-tester/enb/enb.yml
sed -i 's|UE1_IMSI|'$UE1_IMSI'|g' examples/gw-tester/enb/enb.yml
sed -i 's|UE1_IMEISV|'$UE1_IMEISV'|g' examples/gw-tester/enb/enb.yml
sed -i 's|UE_IPV4_INTERNET|'$UE_IPV4_INTERNET'|g' examples/gw-tester/enb/enb.yml
sed -i 's|HTTP_SERVER_IP|'$HTTP_SERVER_IP'|g' examples/gw-tester/enb/enb.yml
sed -i 's|MMEADDR|'$MMEADDR'|g' examples/gw-tester/enb/enb.yml


sed -i 's|MCC|'$MCC'|g' /go-gtp/examples/gw-tester/mme/mme.yml
sed -i 's|MNC|'$MNC'|g' /go-gtp/examples/gw-tester/mme/mme.yml
sed -i 's|SGWC_IP|'$SGWC_IP'|g' /go-gtp/examples/gw-tester/mme/mme.yml
sed -i 's|SMF_IP|'$SMF_IP'|g' /go-gtp/examples/gw-tester/mme/mme.yml
sed -i 's|ETH0_IP|'$ETH0_IP'|g' /go-gtp/examples/gw-tester/mme/mme.yml
sed -i 's|APN|'$APN'|g' /go-gtp/examples/gw-tester/mme/mme.yml


if [[ ${COMPONENT} == MME ]];
then
    cd /go-gtp/examples/gw-tester/mme/
    ./mme
fi

if [[ ${COMPONENT} == ENB ]];
then
    cd /go-gtp/examples/gw-tester/enb/
    ./enb
fi


# Sync docker time
#ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
