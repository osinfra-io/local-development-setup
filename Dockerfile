FROM mcr.microsoft.com/vscode/devcontainers/base:0.202.3-ubuntu

HEALTHCHECK NONE

RUN chsh vscode -s /usr/bin/zsh

USER vscode

COPY ubuntu/setup.sh .
RUN /bin/bash setup.sh

# Reasonable defaults for Powerlevel10k
COPY ubuntu/.p10k.zsh ~/.p10k.zsh
RUN echo '[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh' >> ~/.zshrc

# checkov:skip=BC_DKR_4: We want this to run on every build
RUN ~/bin/update.sh

CMD ["zsh"]
