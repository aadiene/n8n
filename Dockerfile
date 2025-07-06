FROM n8nio/n8n:latest
USER root
RUN npm install -g @google/gemini-cli


# Gemini CLI : https://github.com/google-gemini/gemini-cli/blob/main/Dockerfile
# Base image of N8N: https://github.com/n8n-io/n8n/blob/master/docker/images/n8n-base/Dockerfile
# Install minimal set of packages, then clean up
RUN apk update && apk add --no-cache \
  bc \
#   dnstools (bind-tools) \
  bind-tools \
  ca-certificates \
  curl \
  g++ \
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

# From N8N's official Dockerfile
# https://github.com/n8n-io/n8n/blob/master/docker/images/n8n/Dockerfile
USER node
ENTRYPOINT ["tini", "--", "/docker-entrypoint.sh"]
