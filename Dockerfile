FROM ghcr.io/wg-easy/wg-easy:9

# hadolint ignore=DL3022,DL3023
COPY --from=mindflavor/prometheus-wireguard-exporter:3.6.6 /usr/local/bin/prometheus_wireguard_exporter /usr/local/bin/

# shellcheck disable=SC2016
RUN apk add -U --no-cache \
  wireguard-tools=1.0.20200102-r0 \
  && sed \
  -i '1,/^\[Peer\]/{s//[Peer]\n# friendly_name = ${client.name}\n# (${clientId})/}' \
  lib/WireGuard.js

COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

EXPOSE 9586/tcp

ENTRYPOINT ["/app/entrypoint.sh"]
CMD ["/usr/bin/dumb-init", "node", "server.js"]
