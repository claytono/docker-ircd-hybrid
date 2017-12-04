FROM debian:stable

RUN adduser --disabled-login --gecos "" --shell /bin/false ircd

COPY build.sh patch.diff /tmp/
RUN  chmod 755 /tmp/build.sh && /tmp/build.sh

