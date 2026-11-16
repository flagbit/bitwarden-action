FROM docker.io/library/node:22-alpine
RUN npm i -g @bitwarden/cli@2026.10.1 \
  && apk --update --no-cache add jq
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
