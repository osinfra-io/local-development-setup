#!/usr/bin/env zsh

# Ubuntu
sudo apt update
sudo apt -y upgrade
sudo apt -y install build-essential apt-transport-https

# Homebrew
yes | /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Tools
brew tap bridgecrewio/tap

tools=(
    awscli
    azure-cli
    bridgecrewio/tap/yor
    checkov
    gcc
    gcc@5
    gh
    go
    hashicorp/tap/terraform
    helm
    kubectl
    kubectx
    k9s
    terraform-docs
    pre-commit
    romkatv/powerlevel10k/powerlevel10k
    ruby
    vault
    zsh
    zsh-syntax-highlighting
)

for tool in "${tools[@]}"
do
    brew install ${tool}
done

# Automatically enable pre-commit on repositories
git config --global init.templateDir ~/.git-template
pre-commit init-templatedir ~/.git-template

# Zsh
command -v zsh | sudo tee -a /etc/shells

# Ruby Tools
export RUBYOPT="-W:no-deprecated -W:no-experimental"

echo 'gem: --no-document' > ~/.gemrc
cat << EOF > ~/Gemfile
source 'https://rubygems.org'

gem 'kitchen-terraform'
gem 'inspec'
gem 'rubocop'
gem 'cookstyle'
EOF

export BUNDLE_GEMFILE="~/Gemfile"

cat << EOF > ~/.rubocop.yml
Style/FrozenStringLiteralComment:
          Enabled: false
EOF

gem install bundle

# Pathogen.vim
mkdir -p ~/.vim/autoload ~/.vim/bundle
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# Pathogen Plugins
cd ~/.vim/bundle
git clone https://github.com/hashivim/vim-terraform.git

cat << EOF > ~/.vimrc
set visualbell
  
execute pathogen#infect()

filetype plugin indent on
syntax on

let g:terraform_fmt_on_save=1
let g:terraform_align=1
EOF

# Create Update Script
mkdir -p ~/bin
cat << EOF > ~/bin/update.sh
#!/usr/bin/env zsh

source ~/.zshrc

# Oh-my-zsh
omz update

# Ruby
yes | gem update --system
yes | gem update
yes | gem cleanup
bundle update

# Ubuntu
sudo apt update
sudo apt -y upgrade
sudo apt -y autoremove

# Brew
brew update
brew upgrade
brew autoremove
brew cleanup

# Pathogen Plugins
cd ~/.vim/bundle/vim-terraform
git pull

# zsh-autocomplete
cd ${ZSH_CUSTOM}/plugins/zsh-autosuggestions
git pull
EOF

chmod 755 ~/bin/update.sh

# Google Cloud SDK
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" \
| sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
sudo apt update && sudo apt -y install google-cloud-sdk

# Oh My Zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Shell Setup
cp ~/.zshrc ~/.zshrc-`date +"%Y%m%d_%H%M%S"`.bak
echo 'alias gpg-passphrase="echo "test" | gpg --clearsign > /dev/null 2>&1"' >> ~/.zshrc
echo 'source /home/linuxbrew/.linuxbrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh' >> ~/.zshrc
echo 'source /home/linuxbrew/.linuxbrew/opt/powerlevel10k/powerlevel10k.zsh-theme' >> ~/.zshrc
echo 'export GOOGLE_AUTH_SUPPRESS_CREDENTIALS_WARNINGS=true' >> ~/.zshrc
echo 'export GPG_TTY=$TTY' >> ~/.zshrc
echo 'export EDITOR=vim' >> ~/.zshrc
echo 'export RUBYOPT="-W:no-deprecated -W:no-experimental"' >> ~/.zshrc
echo 'export BUNDLE_GEMFILE=$HOME/Gemfile' >> ~/.zshrc

echo -e "eval \"\$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)\"\n$(cat ~/.zshrc)" > ~/.zshrc
echo -e "export PATH=\$HOME/bin:/home/linuxbrew/.linuxbrew/lib/ruby/gems/3.1.0/bin:\$PATH\n$(cat ~/.zshrc)" > ~/.zshrc

~/bin/update.sh
