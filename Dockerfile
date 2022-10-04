FROM docker.io/library/node:alpine
RUN npm i -g @bitwarden/cli
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]