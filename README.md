# wg-easy-extended

All-in-one: [wg-easy](https://github.com/wg-easy/wg-easy) + [prometheus-wireguard-exporter](https://github.com/MindFlavor/prometheus_wireguard_exporter)

## Run

<pre>
$ docker run -d \
  --name=wg-easy-extended \
  -e WG_HOST=<b>🚨YOUR_SERVER_IP</b> \
  -e PASSWORD=<b>🚨YOUR_ADMIN_PASSWORD</b> \
  -v ~/.wg-easy:/etc/wireguard \
  -p 51820:51820/udp \
  -p 51821:51821/tcp \
  -p 9586:9586/tcp \
  --cap-add=NET_ADMIN \
  --cap-add=SYS_MODULE \
  --sysctl="net.ipv4.conf.all.src_valid_mark=1" \
  --sysctl="net.ipv4.ip_forward=1" \
  --restart unless-stopped \
  ghcr.io/tolkonepiu/wg-easy-extended
</pre>

> 💡 Replace `YOUR_SERVER_IP` with your WAN IP, or a Dynamic DNS hostname.
> 
> 💡 Replace `YOUR_ADMIN_PASSWORD` with a password to log in on the Web UI.

* Web UI - `http://0.0.0.0:51821`

* Exporter metrics - `http://0.0.0.0:9586/metrics`

> 💡 Your configuration files will be saved in `~/.wg-easy`
