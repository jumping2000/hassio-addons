ARG BUILD_FROM=hassioaddons/base:4.1.1
# hadolint ignore=DL3006
FROM ${BUILD_FROM}

# Environment variables
ENV \
    S6_BEHAVIOUR_IF_STAGE2_FAILS=2 \
    S6_CMD_WAIT_FOR_SERVICES=1 \
    TERM="xterm-256color"

# Copy root filesystem
COPY rootfs /

# Setup base
RUN apk add --no-cache \
    coreutils=8.31-r0 \
    
# Build arguments
ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_REF
ARG BUILD_VERSION

# Labels
LABEL \
    io.hass.name="Nut UPS Software" \
    io.hass.description="NUT UPS for HomeAssistant" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="jumping <jumping@aa.aa>" \
    org.label-schema.description="NUT UPS for HomeAssistant" \
    org.label-schema.build-date=${BUILD_DATE} \
    org.label-schema.name="Addon NUT UPS for ${BUILD_ARCH}" \
    org.label-schema.schema-version="3.0.0" \
    org.label-schema.url="https://aaa.aa" \
    org.label-schema.usage="https://github.com/jumping2000/hassio-addons/nut_new/README.md" \
    org.label-schema.vcs-ref=${BUILD_REF} \
    org.label-schema.vcs-url="https://github.com/jumping2000/hassio-addons/nut_new" \
    org.label-schema.vendor="Jumping2000"
