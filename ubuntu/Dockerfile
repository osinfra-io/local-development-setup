FROM mcr.microsoft.com/vscode/devcontainers/base:1.0.19-ubuntu22.04

USER vscode

COPY setup.sh /tmp/setup.sh

RUN chsh vscode -s /usr/bin/zsh && \
	./tmp/setup.sh && \
	rm /tmp/setup.sh

# Reasonable defaults for Powerlevel10k

COPY .p10k.zsh /home/vscode/.p10k.zsh

CMD ["zsh"]
