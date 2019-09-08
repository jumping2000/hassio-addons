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

# Build arguments
ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_REF
ARG BUILD_VERSION

# Labels
LABEL \
    io.hass.name="Network UPS Tools" \
    io.hass.description="Network UPS Tools for Hass.io" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="Jumping>" \
    org.label-schema.description="Network UPS Tools for Hass.io" \
    org.label-schema.build-date=${BUILD_DATE} \
    org.label-schema.name="Addon NUT for ${BUILD_ARCH}" \
    org.label-schema.schema-version="1.1.0" \
    org.label-schema.url="https://github.com/jumping2000/hassio-addons/tree/master/nut" \
    org.label-schema.usage="https://github.com/jumping2000/hassio-addons/blob/master/nut/README.md" \
    org.label-schema.vcs-ref=${BUILD_REF} \
    org.label-schema.vcs-url="https://github.com/jumping2000/hassio-addons/tree/master/nut" \
    org.label-schema.vendor="Jumping"

RUN mkdir /var/run/nut
RUN chown root:nut /var/run/nut
RUN chmod 770 /var/run/nut

# Copy data for add-on
COPY data/run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
