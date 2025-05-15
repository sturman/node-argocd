FROM node:lts-alpine@sha256:2145b76a5c24b7b1c1c0bca6d2b63e92c5c3dc08d514f77447ac32694c083dc8

RUN addgroup -g 9999 argocd && \
    adduser -S -u 999 -G argocd -h /home/argocd argocd && \
    mkdir -p /home/argocd && \
    chown argocd:0 /home/argocd && \
    chmod g=u /home/argocd

USER argocd

WORKDIR /home/argocd
