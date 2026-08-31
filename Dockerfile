FROM node:lts-alpine@sha256:e67514e5d0f6c46656005e1b693b2ec9d52e80b641307de684d4a015ba7a4eaf

RUN addgroup -g 9999 argocd && \
    adduser -S -u 999 -G argocd -h /home/argocd argocd && \
    mkdir -p /home/argocd && \
    chown argocd:0 /home/argocd && \
    chmod g=u /home/argocd

USER argocd

WORKDIR /home/argocd
