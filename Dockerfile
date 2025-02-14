FROM node:lts-alpine@sha256:f93d93d31e202006196d5d22babb9bec7615b9a101744717df815d3d87e275f8

RUN addgroup -g 9999 argocd && \
    adduser -S -u 999 -G argocd -h /home/argocd argocd && \
    mkdir -p /home/argocd && \
    chown argocd:0 /home/argocd && \
    chmod g=u /home/argocd

USER argocd

WORKDIR /home/argocd
