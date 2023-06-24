# Setup scripts for local Infrastructure as Code (IaC) development

[![Docker Build and Test](https://github.com/osinfra-io/local-development-setup/actions/workflows/build-and-test.yml/badge.svg)](https://github.com/osinfra-io/local-development-setup/actions/workflows/build-and-test.yml)

## Goals

When you invest in Infrastructure as Code (IaC), you will find that onboarding developers takes time and can be confusing for people new to development, limiting contributions.

- Standardized IaC developer environments
- Simplify onboarding so new IaC developers can contribute easier

## <img align="left" width="25" height="25" src="https://user-images.githubusercontent.com/1610100/194944104-53a1b3f0-81c5-4759-835d-9b3a8608f38e.png">Gentoo Setup

To install all the local tools we will need you can run the following commands.

This is optional but will allow for `sudo` access without entering a password.

```none
 echo "$USER ALL=(ALL) NOPASSWD:ALL" | sudo EDITOR='tee -a' visudo
```

```none
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/osinfra-io/local-development-setup/main/gentoo/setup.sh)"
```

Change your default shell to Zsh and exit.

```none
chsh -s /bin/zsh; exit
```

When you start the terminal you will be prompted to set up [Powerlevel10k](https://github.com/romkatv/powerlevel10k). Choose the options you like and go!

Once complete you can stay up to date by running the generated update script.

```none
~/bin/update.sh
```

## <img align="left" width="25" height="25" src="https://user-images.githubusercontent.com/1610100/196566203-0acc19c8-f1d9-4481-9424-24da28c53d99.png">Ubuntu Setup

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

When you start your terminal you will be prompted to set up Powerlevel10k. Choose the options you like and go!

Once complete you can stay up to date by running the generated update script.

```none
~/bin/update.sh
```

### Cloud providers tools

#### Google Cloud SDK

The [Google Cloud SDK](https://cloud.google.com/sdk) provides tools and libraries for interacting with Google Cloud products and services. It manages authentication, local configuration, developer workflow, interactions with Google Cloud APIs.

### Open-source tools

- [github-cli](https://github.com/cli/cli)
- [github-copilot-cli](https://www.npmjs.com/package/@githubnext/github-copilot-cli)
- [infracost](https://github.com/infracost/infracost)
- [inspec](https://github.com/inspec/inspec)
- [kitchen-terraform](https://github.com/newcontext-oss/kitchen-terraform)
- [pathogen.vim](https://github.com/tpope/vim-pathogen)
- [pre-commit](https://github.com/pre-commit/pre-commit)
- [pre-commit-terraform](https://github.com/antonbabenko/pre-commit-terraform)
- [terraform](https://github.com/hashicorp/terraform)
- [terraform-docs](https://github.com/terraform-docs/terraform-docs)
- [vim-terraform](https://github.com/hashivim/vim-terraform)

### Zsh stuff

- [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh)
- [powerlevel10k](https://github.com/romkatv/powerlevel10k)
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
