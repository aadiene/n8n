FROM n8nio/n8n:latest
USER root
RUN npm install -g @google/gemini-cli

# Gemini CLI : https://github.com/google-gemini/gemini-cli/blob/main/Dockerfile
# Install minimal set of packages, then clean up
RUN apt-get update && apt-get install -y --no-install-recommends \
  python3 \
  make \
  g++ \
  man-db \
  curl \
  dnsutils \
  less \
  jq \
  bc \
  gh \
  git \
  unzip \
  rsync \
  ripgrep \
  procps \
  psmisc \
  lsof \
  socat \
  ca-certificates \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# From N8N's official Dockerfile
# https://github.com/n8n-io/n8n/blob/master/docker/images/n8n/Dockerfile
USER node
ENTRYPOINT ["tini", "--", "/docker-entrypoint.sh"]
