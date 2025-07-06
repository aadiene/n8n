FROM n8nio/n8n:latest
USER root
RUN npm install -g @google/gemini-cli
USER node
ENTRYPOINT ["tini", "--", "/docker-entrypoint.sh"]
