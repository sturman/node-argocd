FROM node:lts-alpine@sha256:7e0bd0460b26eb3854ea5b99b887a6a14d665d14cae694b78ae2936d14b2befb

RUN addgroup -g 9999 argocd && \
    adduser -S -u 999 -G argocd -h /home/argocd argocd && \
    mkdir -p /home/argocd && \
    chown argocd:0 /home/argocd && \
    chmod g=u /home/argocd

USER argocd

WORKDIR /home/argocd
