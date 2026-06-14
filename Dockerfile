FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Tehran

# Update and install essentials (WITHOUT nodejs from ubuntu repo)
RUN apt-get update && apt-get install -y \
    curl wget git vim nano htop \
    python3 python3-pip \
    php php-cli php-curl php-mbstring php-mysql \
    mysql-client \
    nginx \
    build-essential \
    unzip zip \
    sudo \
    tzdata \
    ttyd \
    && apt-get clean

# Install Node.js 20 (remove conflicting packages first)
RUN apt-get remove -y libnode-dev libnode72 nodejs nodejs-doc npm 2>/dev/null || true \
    && curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs \
    && apt-get clean

# Install useful global npm packages
RUN npm install -g pm2 serve

# Set root password
RUN echo 'root:root123' | chpasswd

# Create working directory
WORKDIR /root/workspace

# Copy startup script
COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 8080

CMD ["/start.sh"]
