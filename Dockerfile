FROM weejewel/wg-easy:7

# hadolint ignore=DL3022,DL3023
COPY --from=mindflavor/prometheus-wireguard-exporter:3.6.4 /usr/local/bin/prometheus_wireguard_exporter /usr/local/bin/

RUN apk add -U --no-cache \
  wireguard-tools=1.0.20200102-r0

RUN sed \
    -i '1,/^\[Peer\]/{s//[Peer]\n# friendly_name = ${client.name}\n# (${clientId})/}' \
    lib/WireGuard.js

COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

EXPOSE 9586/tcp

ENTRYPOINT ["/app/entrypoint.sh"]
CMD ["/usr/bin/dumb-init", "node", "server.js"]
