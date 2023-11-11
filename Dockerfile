FROM ubuntu AS base
WORKDIR /usr/local/bin
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y software-properties-common curl git build-essential vim && \
    apt-add-repository -y ppa:ansible/ansible && \
    apt-get update && \
    apt-get install -y curl git ansible build-essential sudo && \
    apt-get clean autoclean && \
    apt-get autoremove --yes

FROM base AS kaan
ARG TAGS
RUN addgroup --gid 1000 kaan
RUN adduser --gecos "" --uid 1000 --gid 1000 --disabled-password kaan
RUN echo "kaan ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/kaan
USER kaan

WORKDIR /home/kaan
FROM kaan
COPY . .
