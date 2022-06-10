FROM mcr.microsoft.com/vscode/devcontainers/base:0.202.3-ubuntu

HEALTHCHECK NONE

RUN chsh vscode -s /usr/bin/zsh

USER vscode

COPY ubuntu/setup.sh .
RUN /bin/bash setup.sh

RUN ~/bin/update.sh

CMD ["zsh"]
