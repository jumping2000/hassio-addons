ARG BUILD_FROM
FROM $BUILD_FROM

ENV LANG C.UTF-8

RUN echo "http://nl.alpinelinux.org/alpine/edge/main/" >> /etc/apk/repositories
RUN echo "http://nl.alpinelinux.org/alpine/edge/testing/" >> /etc/apk/repositories
#RUN apk add nut jq --update-cache

# Setup base
RUN apk add --no-cache \
    nut=2.7.4-r6 \
    jq=1.6-r0

RUN mkdir /var/run/nut
RUN chown root:nut /var/run/nut
RUN chmod 770 /var/run/nut

# Copy data for add-on
COPY data/run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
