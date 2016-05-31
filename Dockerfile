FROM alpine:3.3

RUN apk --update add alpine-sdk openssl-dev \
  && rm -rf /var/cache/apk/*

RUN wget https://github.com/ircd-hybrid/ircd-hybrid/archive/8.2.17.tar.gz \
  && tar xf *.tar.gz \
  && rm *.tar.gz

RUN cd ircd-hybrid* \
  && ./configure --prefix /usr \
  && make \
  && make install
