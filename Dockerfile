FROM weejewel/wg-easy:4

COPY --from=mindflavor/prometheus-wireguard-exporter:3.5.1 /usr/local/bin/prometheus_wireguard_exporter /usr/local/bin/

RUN apk add -U --no-cache \
  wireguard-tools

COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

EXPOSE 51821/tcp

ENTRYPOINT ["/app/entrypoint.sh"]
CMD ["/usr/bin/dumb-init", "node", "server.js"]
