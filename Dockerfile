FROM jenkinsci/jnlp-slave

USER root
RUN apt-get update
RUN apt-get -y install apt-transport-https ca-certificates curl software-properties-common --no-install-recommends && rm -rf /var/lib/apt/lists/*
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
RUN apt-key fingerprint 0EBFCD88

RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu zesty stable"
RUN apt-get update
RUN apt-get install docker-ce -y --no-install-recommends

RUN curl -L https://github.com/docker/compose/releases/download/1.17.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
RUN chmod +x /usr/local/bin/docker-compose

RUN gpasswd -a jenkins docker
ENTRYPOINT ["jenkins-slave"]
