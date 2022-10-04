FROM docker.io/library/node:alpine
RUN npm i -g @bitwarden/cli \
  && apk --update --no-cache add jq
COPY entrypoint.sh /entrypoint.sh
COPY index.js /index.js
ENTRYPOINT ["/entrypoint.sh"]