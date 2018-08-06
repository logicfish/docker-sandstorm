FROM ubuntu:16.04

MAINTAINER Mark Fisher <logicfish@gmail.com>

ENV \
  COMPILER="vagrant-spk dev"

RUN apt-get update \
 && apt-get install -y gosu git virtualbox-dkms linux-headers-lowlatency vagrant 


RUN curl https://install.sandstorm.io | bash

RUN mkdir -p ~/projects/meteor-spk \
 && cd ~/projects/meteor-spk \
 && curl https://dl.sandstorm.io/meteor-spk-0.4.1.tar.xz | tar Jxf - \
 && cd meteor-spk-0.4.1
 && ln -s $PWD/meteor-spk /usr/bin/meteor-spk

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

EXPOSE 6080

ENTRYPOINT ["/entrypoint.sh"]
CMD ["${COMPILER}"]
