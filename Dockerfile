FROM node:lts-alpine@sha256:52928d8fea4e3d872286d724affcb96b994ac1886c88ec6259013312ce76ca62

RUN addgroup -g 9999 argocd && \
    adduser -S -u 999 -G argocd -h /home/argocd argocd && \
    mkdir -p /home/argocd && \
    chown argocd:0 /home/argocd && \
    chmod g=u /home/argocd

USER argocd

WORKDIR /home/argocd
