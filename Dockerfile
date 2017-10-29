FROM ubuntu:16.04

MAINTAINER Mark Fisher <logicfish@gmail.com>

ENV \
  COMPILER="vagrant-spk dev"

RUN apt-get update \
 && apt-get install -y gosu git virtualbox-dkms linux-headers-lowlatency vagrant \
 && /etc/init.d/vboxdrv setup

RUN git clone https://github.com/sandstorm-io/vagrant-spk.git \
 && cd vagrant-spk && ln -s $PWD/vagrant-spk /usr/bin/vagrant-spk && cd .. \
 && VBoxManage --version

RUN git clone https://github.com/meteor/clock && cd clock \
 && vagrant-spk setupvm meteor \
 && vagrant-spk vm up \
 && vagrant-spk pack ../clock.spk 

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

EXPOSE 6080

ENTRYPOINT ["/entrypoint.sh"]
CMD ["${COMPILER}"]
