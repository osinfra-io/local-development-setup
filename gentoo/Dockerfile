FROM gentoo/stage3:amd64-nomultilib-openrc-20221010
HEALTHCHECK NONE

# Create the vscode user
RUN useradd -m -G wheel vscode \
	&& emerge --sync \
	&& emerge app-admin/sudo  app-shells/zsh \
	&& echo "vscode ALL=(ALL) NOPASSWD:ALL" | EDITOR='tee -a' visudo

RUN chsh vscode -s /bin/zsh

USER vscode

COPY setup.sh .
RUN /bin/bash setup.sh

# Reasonable defaults for Powerlevel10k
COPY .p10k.zsh ~/.p10k.zsh
RUN echo '[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh' >> ~/.zshrc

# checkov:skip=BC_DKR_4: We want this to run on every build
RUN ~/bin/update.sh

CMD ["zsh"]
