#!/usr/bin/env zsh

# Gentoo
sudo emerge app-editors/vim app-misc/jq app-shells/zsh app-shells/zsh-syntax-highlighting gentoo-zsh-completions dev-vcs/git dev-lang/python \
dev-python/pip dev-lang/ruby dev-lang/go app-admin/helm app-admin/terraform sys-cluster/kubectl dev-vcs/pre-commit \
app-admin/vault app-admin/kubectx dev-util/github-cli

# Pip
pip3 install checkov --user

# Go
go install github.com/terraform-docs/terraform-docs@v0.16.0

# Infracost
curl -fsSL https://raw.githubusercontent.com/infracost/infracost/master/scripts/install.sh | sh

# Automatically enable pre-commit on repositories
git config --global init.templateDir ~/.git-template
pre-commit init-templatedir ~/.git-template

# Pull with Rebase
git config --global pull.rebase true

# Prune on Fetch
git config --global fetch.prune true

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
curl https://sdk.cloud.google.com > install.sh
bash install.sh --disable-prompts

# Oh My Zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Shell Setup
cp ~/.zshrc ~/.zshrc-`date +"%Y%m%d_%H%M%S"`.bak

cat << 'EOF' >> ~/.zshrc
alias gpg-passphrase="echo "test" | gpg --clearsign > /dev/null 2>&1"

export GOOGLE_AUTH_SUPPRESS_CREDENTIALS_WARNINGS=true
export GPG_TTY=$TTY
export EDITOR=vim
export RUBYOPT="-W:no-deprecated -W:no-experimental"
export BUNDLE_GEMFILE=$HOME/Gemfile
export GEM_HOME=$HOME/.gem


autoload -U compinit promptinit
      compinit
      promptinit; prompt gentoo

zstyle ':completion::complete:*' use-cache 1

[[ ! -f  /usr/share/zsh/site-functions/zsh-syntax-highlighting.zsh ]] || source /usr/share/zsh/site-functions/zsh-syntax-highlighting.zsh
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
[[ ! -f ~/.exports ]] || source ~/.exports

source ~/google-cloud-sdk/completion.zsh.inc
source ~/google-cloud-sdk/path.zsh.inc

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/bin/terraform terraform
EOF

echo -e "export PATH=\$HOME/bin:\$HOME/.go/bin:\$HOME/.gem/bin:\$HOME/.local/bin:\$PATH\n$(cat ~/.zshrc)" > ~/.zshrc

# Create Update Script
mkdir -p ~/bin
cat << 'EOF' > ~/bin/update.sh
#!/usr/bin/env zsh

source ~/.zshrc

# Oh-my-zsh
${ZSH}/tools/upgrade.sh

# Gentoo
sudo emerge --ask=n --sync
sudo emerge --ask=n --update --deep --newuse @world
sudo emerge --ask=n --depclean --quiet

# Ruby
bundle update

# Pathogen Plugins
cd ~/.vim/bundle/vim-terraform
git pull

# zsh-autocomplete
cd ${ZSH_CUSTOM}/plugins/zsh-autosuggestions
git pull

# Pip
pip3 install -U checkov --user

# Infracost
curl -fsSL https://raw.githubusercontent.com/infracost/infracost/master/scripts/install.sh | sh
EOF

chmod 755 ~/bin/update.sh
