FROM node:lts-alpine@sha256:7704dc18955b08192f9d7b8f897224800c081af3cba22cf353eb26259484361f

RUN addgroup -g 9999 argocd && \
    adduser -S -u 999 -G argocd -h /home/argocd argocd && \
    mkdir -p /home/argocd && \
    chown argocd:0 /home/argocd && \
    chmod g=u /home/argocd

USER argocd

WORKDIR /home/argocd
