FROM gentoo/stage3:amd64-nomultilib-openrc-20230109

HEALTHCHECK NONE

COPY make.conf /etc/portage/make.conf
RUN rm -rf /etc/portage/package.use
COPY package.use /etc/portage/package.use

RUN useradd -m -G wheel vscode \
	&& emerge-webrsync \
	&& emerge --update --deep --newuse @world \
	&& emerge --depclean \
	&& emerge app-admin/sudo  app-shells/zsh \
	&& echo "vscode ALL=(ALL) NOPASSWD:ALL" | EDITOR='tee -a' visudo

RUN chsh vscode -s /bin/zsh

USER vscode

COPY setup.sh /tmp/setup.sh
RUN /bin/bash /tmp/setup.sh

# Reasonable defaults for Powerlevel10k

COPY .p10k.zsh /home/vscode/.p10k.zsh
RUN sed -i 's/^ZSH_THEME=".\+"$/ZSH_THEME=\"powerlevel10k\/powerlevel10k"/g' /home/vscode/.zshrc

# checkov:skip=BC_DKR_4: We want this to run on every build

RUN /home/vscode/bin/update.sh

CMD ["zsh"]
