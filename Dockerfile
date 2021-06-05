FROM ubuntu:latest

ARG BRANCH="latest"                                                      
ARG DEBIAN_FRONTEND="noninteractive"

COPY dpkg_excludes /etc/dpkg/dpkg.cfg.d/excludes 

RUN apt-get update \
 && apt-get --no-install-recommends -y install ca-certificates git lsb-release sudo nano python3 python3-pip python-is-python3

RUN git clone https://github.com/Chia-Network/chia-blockchain.git --branch ${BRANCH} --recurse-submodules \
 && cd chia-blockchain \
 && chmod +x install.sh && ./install.sh \
 && . ./activate && chia init

RUN git clone https://github.com/swar/Swar-Chia-Plot-Manager.git --branch main \
 && pip3 install -r /Swar-Chia-Plot-Manager/requirements.txt

ADD https://github.com/pechy/chiapos/releases/download/1.0.2-dev1/chiapos-1.0.2.dev1-cp38-cp38-manylinux2010_x86_64.whl /tmp/ \
 && cd /chia-blockchain \
 && venv/bin/pip install /tmp/chiapos-1.0.2.dev1-cp38-cp38-manylinux2010_x86_64.whl \
 && sed -i 's/chiapos==1.0.2/chiapos/' setup.py \
 && venv/bin/python setup.py install

WORKDIR /Swar-Chia-Plot-Manager 

VOLUME /config

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["bash", "/entrypoint.sh"]
