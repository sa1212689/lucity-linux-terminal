
FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=UTC
ENV PORT=7681
ENV HOME=/workspace

# Install PHP, Python and Linux utilities
RUN apt-get update && apt-get install -y \
    bash \
    curl \
    wget \
    git \
    nano \
    vim \
    sudo \
    ca-certificates \
    build-essential \
    cmake \
    pkg-config \
    libjson-c-dev \
    libwebsockets-dev \
    libuv1-dev \
    libssl-dev \
    zlib1g-dev \
    php-cli \
    php-curl \
    php-mbstring \
    php-xml \
    php-zip \
    php-bcmath \
    composer \
    python3 \
    python3-pip \
    python3-venv \
    python3-dev \
    nodejs \
    npm \
    unzip \
    zip \
    procps \
    htop \
    iputils-ping \
    dnsutils \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Build ttyd
ARG TTYD_VERSION=1.7.7

RUN git clone --depth 1 --branch ${TTYD_VERSION} \
    https://github.com/tsl0922/ttyd.git /tmp/ttyd \
    && cmake -S /tmp/ttyd -B /tmp/ttyd/build \
       -DCMAKE_BUILD_TYPE=Release \
    && cmake --build /tmp/ttyd/build -j2 \
    && cmake --install /tmp/ttyd/build \
    && rm -rf /tmp/ttyd

# Create non-root user
RUN useradd -m -u 10001 -s /bin/bash terminal \
    && mkdir -p /workspace \
    && chown -R terminal:terminal /workspace

WORKDIR /workspace

COPY entrypoint.sh /entrypoint.sh

RUN chmod 755 /entrypoint.sh

USER terminal

EXPOSE 7681

ENTRYPOINT ["/entrypoint.sh"]
