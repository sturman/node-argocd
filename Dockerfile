FROM node:lts-alpine@sha256:e1300ecc3dfad6e051ed58ae8158c7dde91fb23a37f2f0f4cf23061add16a5d9

RUN addgroup -g 9999 argocd && \
    adduser -S -u 999 -G argocd -h /home/argocd argocd && \
    mkdir -p /home/argocd && \
    chown argocd:0 /home/argocd && \
    chmod g=u /home/argocd

USER argocd

WORKDIR /home/argocd
