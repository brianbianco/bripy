FROM debian:latest
MAINTAINER ajenkins@cargometrics.com

RUN apt-get update && \
    apt-get install -y python3 python3-pip

COPY inference.py bri.py requirements.txt bundler.sh /root/

WORKDIR /root
RUN pip3 install  --break-system-packages -r requirements.txt
RUN python3 bri.py

ENV TAR_FILE=model_bundle.tar.gz
RUN ./bundler.sh

CMD bash -c "cat $TAR_FILE"
