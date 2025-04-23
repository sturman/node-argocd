FROM node:lts-alpine@sha256:26af2660b4251770e85475170641b3cd2c1b3785f8801309e738ee35eb29acc2

RUN addgroup -g 9999 argocd && \
    adduser -S -u 999 -G argocd -h /home/argocd argocd && \
    mkdir -p /home/argocd && \
    chown argocd:0 /home/argocd && \
    chmod g=u /home/argocd

USER argocd

WORKDIR /home/argocd
