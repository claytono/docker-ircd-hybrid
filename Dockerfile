FROM alpine:3.3

RUN adduser -D ircd -s /bin/false ircd

RUN apk --update add \
  ca-certificates gcc libc-dev make openssl-dev tar wget \
  && rm -rf /var/cache/apk/*

RUN wget https://github.com/ircd-hybrid/ircd-hybrid/archive/8.2.22.tar.gz \
  && tar xf *.tar.gz \
  && rm *.tar.gz \
  && cd ircd-hybrid* \
  && ./configure --prefix / \
                 --exec-prefix /usr \
                 --sysconfdir /etc/ircd-hybrid \
  && make \
  && make install \
  && cd .. \
  && rm -rf ircd-hybrid*
