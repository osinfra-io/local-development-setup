# Setup scripts for local Infrastructure as Code (IaC) development

[![Docker Build and Test](https://github.com/osinfra-io/local-development-setup/actions/workflows/build-and-test.yml/badge.svg)](https://github.com/osinfra-io/local-development-setup/actions/workflows/build-and-test.yml)

## Goals

When you invest in Infrastructure as Code (IaC), you will find that onboarding developers takes time and can be confusing for people new to development, limiting contributions.

- Standardized IaC developer environments
- Simplify onboarding so new IaC developers can contribute easier

## <img align="left" width="25" height="25" src="https://user-images.githubusercontent.com/1610100/196566203-0acc19c8-f1d9-4481-9424-24da28c53d99.png">Ubuntu Setup

You can run the following commands to install all the local tools we will need.

*The following step is optional but allows sudo access without entering a password.*

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

You will be prompted to set up Powerlevel10k when you start your terminal. Choose the options you like and go!

Once complete, you can stay current by running the generated update script.

```none
~/bin/update.zsh
```
