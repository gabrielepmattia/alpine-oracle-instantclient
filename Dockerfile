FROM alpine:3.14

RUN apk update && apk add libaio gcc libc-dev wget 

RUN mkdir /install
WORKDIR /install

RUN wget https://download.oracle.com/otn_software/linux/instantclient/211000/instantclient-basiclite-linux.x64-21.1.0.0.0.zip

RUN unzip instantclient-basiclite-linux.x64-21.1.0.0.0.zip && \
    mkdir -p /opt/oracle/instantclient_21_1 && \
    mv instantclient_21_1 /opt/oracle/ && \
    mkdir -p /opt/oracle/instantclient_21_1/lib && \
    ln -sfv /opt/oracle/instantclient_21_1/*.so* /opt/oracle/instantclient_21_1/lib/ && \
    ln -sfv /usr/lib/libc.so /usr/lib/libresolv.so.2 && \
    ln -sfv /lib/libc.musl-x86_64.so.1 /lib/ld-linux-x86-64.so.2

ENV ORACLE_BASE=/opt/oracle/instantclient_21_1
ENV LD_LIBRARY_PATH=/opt/oracle/instantclient_21_1:/lib:/usr/lib
ENV TNS_ADMIN=/opt/oracle/instantclient_21_1
ENV ORACLE_HOME=/opt/oracle/instantclient_21_1

RUN rm -rfv /install
RUN apk del wget
WORKDIR /