#!/usr/bin/env zsh

# Gentoo
sudo emerge --sync
sudo emerge --update --deep --newuse @world
sudo emerge app-shells/zsh app-shells/zsh-syntax-highlighting gentoo-zsh-completions dev-vcs/git dev-lang/python \
dev-python/pip dev-lang/ruby dev-lang/go app-admin/helm app-admin/terraform sys-cluster/kubectl dev-vcs/pre-commit \
app-admin/vault app-admin/kubectx dev-util/github-cli

# Pip
pip3 install checkov --user

# Go
go install github.com/terraform-docs/terraform-docs@v0.16.0

# Powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Automatically enable pre-commit on repositories
git config --global init.templateDir ~/.git-template
pre-commit init-templatedir ~/.git-template

# Ruby Tools
export RUBYOPT="-W:no-deprecated -W:no-experimental"

echo 'gem: --no-document' > ~/.gemrc
cat << EOF > ~/Gemfile
source 'https://rubygems.org'
gem 'kitchen-terraform'
gem 'inspec'
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

# Oh My Zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Shell Setup
cp ~/.zshrc ~/.zshrc-`date +"%Y%m%d_%H%M%S"`.bak
echo 'alias gpg-passphrase="echo "test" | gpg --clearsign > /dev/null 2>&1"' >> ~/.zshrc
echo 'export GOOGLE_AUTH_SUPPRESS_CREDENTIALS_WARNINGS=true' >> ~/.zshrc
echo 'export GPG_TTY=$TTY' >> ~/.zshrc
echo 'export EDITOR=vim' >> ~/.zshrc
echo 'export RUBYOPT="-W:no-deprecated -W:no-experimental"' >> ~/.zshrc
echo 'export BUNDLE_GEMFILE=$HOME/Gemfile' >> ~/.zshrc
cat << 'EOF' >> ~/.zshrc
autoload -U compinit promptinit
      compinit
      promptinit; prompt gentoo
EOF

# Create Update Script
mkdir -p ~/bin
cat << 'EOF' > ~/bin/update.sh
#!/usr/bin/env zsh

source ~/.zshrc

# Oh-my-zsh
${ZSH}/tools/upgrade.sh

# Gentoo
sudo emerge --sync
sudo emerge --update --deep --newuse @world
sudo emerge --depclean --quiet

# Ruby
yes | sudo gem update --system
yes | sudo gem update
yes | sudo gem cleanup
sudo bundle update

# Pathogen Plugins
cd ~/.vim/bundle/vim-terraform
git pull

# zsh-autocomplete
cd ${ZSH_CUSTOM}/plugins/zsh-autosuggestions
git pull

# Pip
pip3 install -U checkov --user

EOF

chmod 755 ~/bin/update.sh
