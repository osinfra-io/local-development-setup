# Development environment setup scripts for Infrastructure as Code (IaC) [![Docker Build and Test](https://github.com/osinfra-io/local-development-setup/actions/workflows/build-and-test.yml/badge.svg)](https://github.com/osinfra-io/local-development-setup/actions/workflows/build-and-test.yml)

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

When you start your terminal you will be prompted to set up Powerlevel10k. Choose the options you like and go!

Once complete you can stay up to date by running the generated update script.

```none
~/bin/update.sh
```

### Cloud providers tools

#### AWS CLI

The [AWS command-line interface](https://aws.amazon.com/cli) is a unified tool to manage your AWS services. With just one tool to download and configure, you can control multiple AWS services from the command line and automate them through scripts.

#### Azure CLI

The [Azure command-line interface](https://docs.microsoft.com/en-us/cli/azure) is a set of commands used to create and manage Azure resources. The Azure CLI is available across Azure services and is designed to get you working quickly with Azure, with an emphasis on automation.

#### Google Cloud SDK

The [Google Cloud SDK](https://cloud.google.com/sdk) provides tools and libraries for interacting with Google Cloud products and services. It manages authentication, local configuration, developer workflow, interactions with Google Cloud APIs.

### Open-source tools

- [checkov](https://github.com/bridgecrewio/checkov)
- [chef-inspec](https://github.com/inspec/inspec)
- [github-cli](https://github.com/cli/cli)
- [infracost](https://github.com/infracost/infracost)
- [inspec-gcp](https://github.com/inspec/inspec-gcp)
- [inspec-aws](https://github.com/inspec/inspec-aws)
- [inspec-azure](https://github.com/inspec/inspec-azure)
- [kitchen-terraform](https://github.com/newcontext-oss/kitchen-terraform)
- [pre-commit](https://github.com/pre-commit/pre-commit)
- [pre-commit-terraform](https://github.com/antonbabenko/pre-commit-terraform)
- [terraform](https://github.com/hashicorp/terraform)
- [terraform-docs](https://github.com/terraform-docs/terraform-docs)
- [yor](https://github.com/bridgecrewio/yor)

### Zsh stuff

- [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh)
- [powerlevel10k](https://github.com/romkatv/powerlevel10k)
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
