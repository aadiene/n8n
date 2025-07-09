FROM n8nio/n8n:latest
USER root

# Gemini CLI : https://github.com/google-gemini/gemini-cli/blob/main/Dockerfile
# Base image of N8N: https://github.com/n8n-io/n8n/blob/master/docker/images/n8n-base/Dockerfile
# Install minimal set of packages, then clean up
RUN apk update && apk add --no-cache \
  bash \
  bc \
#   dnstools (bind-tools) \
  bind-tools \
  ca-certificates \
  curl \
  g++ \
  gcompat \
  git \
#   gh (github-cli) \
  github-cli \
  jq \
  less \
  lsof \
  make \
  man-db \
  procps \
  psmisc \
  python3 \
  ripgrep \
  rsync \
  socat \
  unzip \
  && rm -rf /tmp/* /root/.npm /root/.cache/node /opt/yarn* \
  && apk del apk-tools

# Set up npm global package folder under /usr/local/share
# Give it to non-root user node, already set up in base image
RUN mkdir -p /usr/local/share/npm-global \
  && chown -R node:node /usr/local/share/npm-global
ENV NPM_CONFIG_PREFIX=/usr/local/share/npm-global
ENV PATH=$PATH:/usr/local/share/npm-global/bin

# From N8N's official Dockerfile
# https://github.com/n8n-io/n8n/blob/master/docker/images/n8n/Dockerfile
USER node
RUN npm install -g @google/gemini-cli
RUN npm install -g @anthropic-ai/claude-code
ENTRYPOINT ["tini", "--", "/docker-entrypoint.sh"]
