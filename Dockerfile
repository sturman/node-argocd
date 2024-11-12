FROM node:lts-alpine@sha256:f8c7230e119ab657a4adda992f7dad2b2b068029c7710f53d930673a8eb2a1e8

RUN addgroup -g 9999 argocd && \
    adduser -S -u 999 -G argocd -h /home/argocd argocd && \
    mkdir -p /home/argocd && \
    chown argocd:0 /home/argocd && \
    chmod g=u /home/argocd

USER argocd

WORKDIR /home/argocd
