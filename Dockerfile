FROM node:lts-alpine@sha256:b5b4f313535a50a4f7f9f23a592236e40e3cbf24391f0ac36fa173a10640a7ee

RUN addgroup -g 9999 argocd && \
    adduser -S -u 999 -G argocd -h /home/argocd argocd && \
    mkdir -p /home/argocd && \
    chown argocd:0 /home/argocd && \
    chmod g=u /home/argocd

USER argocd

WORKDIR /home/argocd
