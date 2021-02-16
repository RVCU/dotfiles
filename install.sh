#!/bin/bash
USER="$1"
EMAIL="$2"
PATH_TO_GH_KEY="$3"

if [[ $# -lt 3 ]]; then
    echo "missing argument"
    echo "usage: ./install.sh git-user-name git-email path-to-gh-key"
    exit 1
fi

mkdir -p ~/bin ~/.config/nvim
# install nvim
pushd ~/bin
curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
mv nvim.appimage nvim
chmod u+x nvim
popd
# install cht.sh
curl https://cht.sh/:cht.sh > ~/bin/cht.sh
chmod +x ~/bin/cht.sh
# install vim plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
# install node for coc vim
curl -sL install-node.now.sh/lts | sudo bash
#mv files around
cp -f bashrc ~/.bashrc
cp -f tmux.conf ~/.tmux.conf
cp -f init.vim ~/.config/nvim/init.vim
# installing some usual tools
sudo apt-get install -y git build-essential clang htop
# git config
git config --global core.editor nvim 
git config --global user.name "$USER"
git config --global user.email "$EMAIL"
cp -f "$PATH_TO_GH_KEY" ~/.ssh/gh_key
ssh-keygen -y -f ~/.ssh/gh_key > ~/.ssh/gh_key.pub
echo "Host github.com" >> ~/.ssh/config
echo "  User $USER" >> ~/.ssh/config
echo "  IdentityFile ~/.ssh/gh_key" >> ~/.ssh/config 
