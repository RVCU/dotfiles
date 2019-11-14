FROM ubuntu:latest
ARG USER
ARG EMAIL

### INSTALLING PACKAGES
RUN apt-get -y update
RUN apt-get install -y ranger sudo zsh tmux make automake ruby gcc \
                   man vim git ctags locales nodejs npm \
                   maven wget nmap lynx cmake curl \
                   htop golang httpie jq elinks procps groovy
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
RUN apt-get install -y yarn

### SET THE LOCALE
RUN locale-gen en_US.UTF-8  
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8  
ENV LANG C.UTF-8

### CREATING USER
RUN useradd -ms /bin/bash $USER
RUN usermod $USER -a -G sudo
RUN echo "$USER:password" | chpasswd
USER $USER
WORKDIR /home/$USER

### COPYING OVER .conf FILES
ADD files/tmux.conf /home/$USER/.tmux.conf
ADD files/bashrc /home/$USER/.bashrc
ADD files/vimrc  /home/$USER/.vimrc
RUN mkdir -p /home/$USER/.vim/vimrc.d /home/$USER/.vim/templates

### VIM :D
ADD files/vimrc.d/ /home/$USER/.vim/vimrc.d/
COPY files/templates/* /home/$USER/.vim/templates/
RUN git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim 
RUN echo | echo | vim +PluginInstall +qall &> /dev/null

### GIT CONFIG
RUN git config --global core.editor vim 
RUN git config --global user.name "$USER"
RUN git config --global user.email "$EMAIL"
