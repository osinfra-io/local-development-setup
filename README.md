# Development environment setup scripts for Infrastructure as Code (IaC)

## Ubuntu Setup

To install all the local tools we will need you can run the following commands.

*The following step is optional but will allow for sudo access without entering a password.*

```none
 echo "$USER ALL=(ALL) NOPASSWD:ALL" | sudo EDITOR='tee -a' visudo
 ```

```none
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/osinfra-io/local-development-setup/main/ubuntu/setup.sh)"
```

Change your default shell to Zsh and exit.

```none
chsh -s /home/linuxbrew/.linuxbrew/bin/zsh; exit
```

When you start Terminal you will be prompted to set up Powerlevel10k. Choose the options you like and go!

Once complete you can stay up to date by running the generated update script.

```none
~/bin/update.sh
```
