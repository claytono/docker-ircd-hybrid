FROM alpine:3.3

RUN apk --update add \
  ca-certificates gcc libc-dev make openssl-dev tar wget \
  && rm -rf /var/cache/apk/*

RUN wget https://github.com/ircd-hybrid/ircd-hybrid/archive/8.2.17.tar.gz \
  && tar xf *.tar.gz \
  && rm *.tar.gz \
  && cd ircd-hybrid* \
  && ./configure --prefix /usr ; cat config.log\
  && make \
  && make install \
  && cd .. \
  && rm -rf ircd-hybrid*
