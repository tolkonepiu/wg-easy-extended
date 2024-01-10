FROM ghcr.io/wg-easy/wg-easy:10

# hadolint ignore=DL3022,DL3023
COPY --from=mindflavor/prometheus-wireguard-exporter:3.6.6 /usr/local/bin/prometheus_wireguard_exporter /usr/local/bin/

# hadolint ignore=SC2016
RUN sed \
  -i '1,/^\[Peer\]/{s//[Peer]\n# friendly_name = ${client.name}\n# (${clientId})/}' \
  lib/WireGuard.js

COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

EXPOSE 9586/tcp

ENTRYPOINT ["/app/entrypoint.sh"]
CMD ["/usr/bin/dumb-init", "node", "server.js"]
