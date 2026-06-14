# استفاده از Alpine به جای Ubuntu (خیلی سبک‌تر)
FROM alpine:3.19

RUN apk add --no-cache \
    curl wget git vim nano \
    nodejs npm \
    openssh-server \
    socat \
    && apk add --no-cache --virtual .build-deps python3 make g++ \
    && rm -rf /var/cache/apk/*

# نصب X-UI (نسخه سبک)
RUN curl -L https://github.com/alireza0/x-ui/releases/download/v3.0.2/x-ui-linux-amd64.tar.gz -o /tmp/x-ui.tar.gz \
    && tar -xzf /tmp/x-ui.tar.gz -C /usr/local/ \
    && rm /tmp/x-ui.tar.gz
