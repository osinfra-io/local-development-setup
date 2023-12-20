FROM mcr.microsoft.com/vscode/devcontainers/base:1.0.19-ubuntu22.04

COPY setup.sh /tmp/setup.sh

RUN chsh vscode -s /usr/bin/zsh && \
	/bin/bash /tmp/setup.sh && \
	rm /tmp/setup.sh

USER vscode

# Reasonable defaults for Powerlevel10k

COPY .p10k.zsh /home/vscode/.p10k.zsh

CMD ["zsh"]
