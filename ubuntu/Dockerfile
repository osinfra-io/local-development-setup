FROM mcr.microsoft.com/vscode/devcontainers/base:1.0.19-ubuntu22.04

RUN chsh vscode -s /usr/bin/zsh

USER vscode

COPY setup.sh /tmp/setup.sh
RUN /bin/bash /tmp/setup.sh

# Reasonable defaults for Powerlevel10k

COPY .p10k.zsh /home/vscode/.p10k.zsh

RUN /home/vscode/bin/update.sh

CMD ["zsh"]
