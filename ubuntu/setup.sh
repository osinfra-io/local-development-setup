#!/usr/bin/env zsh

# Ubuntu

sudo apt update
sudo apt -y upgrade
sudo apt -y install build-essential apt-transport-https vim

# Homebrew

yes | /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Tools

tools=(
    gh
    go
    hashicorp/tap/terraform
    helm
    infracost
    kubectl
    node
    pre-commit
    romkatv/powerlevel10k/powerlevel10k
    ruby
    terraform-docs
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
gem 'rubocop'
EOF

export BUNDLE_GEMFILE="~/Gemfile"

cat << EOF > ~/.rubocop.yml
Style/FrozenStringLiteralComment:
          Enabled: false
EOF

gem install bundler

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

# Google Cloud SDK

echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" \
| sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
sudo apt update && sudo apt -y install google-cloud-sdk

# Oh My Zsh

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# zsh-autosuggestions

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# GitHub Copilot CLI

npm install @githubnext/github-copilot-cli

# Shell Setup

cp ~/.zshrc ~/.zshrc-`date +"%Y%m%d_%H%M%S"`.bak

cat << 'EOF' >> ~/.zshrc
alias gpg-passphrase="echo "test" | gpg --clearsign > /dev/null 2>&1"

export GOOGLE_AUTH_SUPPRESS_CREDENTIALS_WARNINGS=true
export GPG_TTY=$TTY
export EDITOR=vim
export RUBYOPT="-W:no-deprecated -W:no-experimental"
export BUNDLE_GEMFILE=$HOME/Gemfile

zstyle ':completion::complete:*' use-cache 1

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
[[ ! -f ~/.exports ]] || source ~/.exports

source /home/linuxbrew/.linuxbrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /home/linuxbrew/.linuxbrew/opt/powerlevel10k/powerlevel10k.zsh-theme
eval "$(github-copilot-cli alias -- "$0")"
EOF

echo -e "eval \"\$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)\"\n$(cat ~/.zshrc)" > ~/.zshrc
echo -e "export PATH=\$HOME/bin:/home/linuxbrew/.linuxbrew/lib/ruby/gems/3.1.0/bin:\$PATH\n$(cat ~/.zshrc)" > ~/.zshrc

# Create Update Script

mkdir -p ~/bin
cat << 'EOF' > ~/bin/update.sh
#!/usr/bin/env zsh

source ~/.zshrc

# Oh-my-zsh
${ZSH}/tools/upgrade.sh

# Ubuntu
sudo apt update
sudo apt -y upgrade
sudo apt -y autoremove

# Ruby
bundle update

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

# NPM
npm update
EOF

chmod 755 ~/bin/update.sh
