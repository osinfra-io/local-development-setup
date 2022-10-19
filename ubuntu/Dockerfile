FROM mcr.microsoft.com/vscode/devcontainers/base:0.203.7-ubuntu22.04

HEALTHCHECK NONE

RUN chsh vscode -s /usr/bin/zsh

USER vscode

COPY setup.sh /tmp/setup.sh
RUN /bin/bash /tmp/setup.sh

# Reasonable defaults for Powerlevel10k

COPY .p10k.zsh /home/vscode/.p10k.zsh
RUN echo '[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh' >> /home/vscode/.zshrc

# checkov:skip=BC_DKR_4: We want this to run on every build
RUN /home/vscode/bin/update.sh

CMD ["zsh"]
