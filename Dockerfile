FROM python:3.6-alpine

# Install new packages
RUN apk add --update build-base python3-dev py-pip jpeg-dev zlib-dev libffi-dev openssl-dev git openssh-client sshpass \
zip jq netcat-openbsd curl openldap-clients

# Upgrade pip
RUN pip install --upgrade pip

# Install pip libs
RUN pip install pipenv hvac ansible-modules-hashivault

# Install Vault
RUN curl https://releases.hashicorp.com/vault/1.5.3/vault_1.5.3_linux_amd64.zip -o /tmp/vault.zip && \
unzip -o /tmp/vault.zip && \
cp vault /usr/bin && \
rm -fv /tmp/vault.zip

# Change LIBRARY_PATH environment variable because of error in building zlib
ENV LIBRARY_PATH=/lib:/usr/lib

# Set Workdir
WORKDIR /ansible

# Define volumes
VOLUME [ "/ansible" ]

# Install ansible
ARG ANSIBLE_VERSION=2.9.12

RUN pip install ansible==$ANSIBLE_VERSION
