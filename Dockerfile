FROM node:16-alpine AS builder
WORKDIR /build/usr/local/bin/
RUN npm install --production --no-save @zxteam/cancellation @zxteam/configuration @zxteam/errors @zxteam/launcher @zxteam/logger mustache
COPY docker-entrypoint.js /build/usr/local/bin/docker-entrypoint.js
COPY log4js.json /build/usr/local/bin/log4js.json

FROM node:16-alpine
COPY --from=builder /build/ /
VOLUME [ "/data" ]
WORKDIR /data
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.js"]
CMD ["--config-env"]

