
# https://xrpl.org/install-rippled-on-ubuntu.html

FROM debian:9
SHELL ["/bin/bash", "-c"]

WORKDIR /opt
EXPOSE 6005

RUN apt update -y && apt install -y apt-transport-https ca-certificates wget gnupg
RUN wget -q -O - https://repos.ripple.com/repos/api/gpg/key/public | apt-key add -
RUN echo "deb https://repos.ripple.com/repos/rippled-deb stretch stable" | tee -a /etc/apt/sources.list.d/ripple.list
RUN apt update -y && apt install -y rippled
RUN rm -rf /var/lib/apt/lists/*

# configure
RUN perl -i -p0e 's/\[ssl_verify\].1/\[ssl_verify\]\n0/s' /etc/opt/ripple/rippled.cfg && \
  sed -i 's/#port_ws_public/port_ws_public/g' /etc/opt/ripple/rippled.cfg && \
  echo -e "\n[port_ws_public]\nport = 6005\nip = 0.0.0.0\nprotocol = ws,wss" >> /etc/opt/ripple/rippled.cfg

ENTRYPOINT ["/usr/local/bin/rippled"]
CMD ["--fg", "--conf=/etc/opt/ripple/rippled.cfg"]
