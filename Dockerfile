FROM node:lts-alpine@sha256:f70403e87646dc51b45295f4b8b70cdad0b63d2297c4c9899119b03f7af7a6b3

RUN addgroup -g 9999 argocd && \
    adduser -S -u 999 -G argocd -h /home/argocd argocd && \
    mkdir -p /home/argocd && \
    chown argocd:0 /home/argocd && \
    chmod g=u /home/argocd

USER argocd

WORKDIR /home/argocd
