FROM ubuntu:latest

MAINTAINER James Williams <james.williams@networktocode.com>

WORKDIR /opt/nautobot

COPY pb_nautobot_install.yml .

COPY templates templates

COPY supervisord.conf /etc/supervisord.conf

RUN apt-get update -y && apt-get install -y python3 python3-psycopg2 python3-pip python3-venv python3-dev python3-apt

RUN pip3 install pip --upgrade

RUN pip install ansible==3.0.0 supervisor

RUN ansible-galaxy collection install community.postgresql

RUN ansible-playbook pb_nautobot_install.yml

EXPOSE 8000/tcp

CMD /usr/local/bin/supervisord -c /etc/supervisord.conf
