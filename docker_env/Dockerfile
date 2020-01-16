FROM ubuntu:latest
ARG USER
ARG EMAIL

### INSTALLING PACKAGES
RUN apt-get -y update
RUN apt-get install -y ranger sudo zsh tmux make automake ruby gcc \
                   man git ctags locales nodejs npm \
                   maven wget nmap lynx cmake curl \
                   htop httpie jq elinks procps groovy \
                   libncurses5-dev libgnome2-dev libgnomeui-dev \
                   libgtk2.0-dev libatk1.0-dev libbonoboui2-dev \
                   libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev \
                   python3-dev ruby-dev lua5.1 liblua5.1-dev libperl-dev

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
RUN echo "$USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
USER $USER
WORKDIR /home/$USER

### COPYING OVER .conf FILES
ADD files/tmux.conf /home/$USER/.tmux.conf
ADD files/bashrc /home/$USER/.bashrc
ADD files/vimrc  /home/$USER/.vimrc
RUN mkdir -p /home/$USER/.vim/vimrc.d /home/$USER/.vim/templates

### VIM :D
RUN git clone https://github.com/vim/vim.git && cd vim/src &&\
    sudo make && sudo make install
ADD files/vimrc.d/ /home/$USER/.vim/vimrc.d/
COPY files/templates/* /home/$USER/.vim/templates/
RUN curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
RUN sudo rm -rf vim/

### SETTING PERMISSIONS
RUN sudo chown -R $USER:$USER /home/$USER

### INSTALLING GOLANG
RUN curl -O https://storage.googleapis.com/golang/go1.11.2.linux-amd64.tar.gz
RUN tar -xvf go1.11.2.linux-amd64.tar.gz && sudo mv go /usr/local
RUN mkdir /home/$USER/go

### INSTALLING RUBY
RUN sudo apt-get install -y libreadline-dev zlib1g-dev
RUN git clone https://github.com/rbenv/rbenv.git ~/.rbenv
RUN cd ~/.rbenv && src/configure && make -C src
RUN mkdir -p "$(~/.rbenv/bin/rbenv root)"/plugins
RUN git clone https://github.com/rbenv/ruby-build.git "$(~/.rbenv/bin/rbenv root)"/plugins/ruby-build
RUN  ~/.rbenv/bin/rbenv init; ~/.rbenv/bin/rbenv install 2.5.1
RUN  ~/.rbenv/bin/rbenv init; ~/.rbenv/bin/rbenv global 2.5.1
RUN  ~/.rbenv/bin/rbenv init; ~/.rbenv/bin/rbenv local 2.5.1

### INSTALLING PYTHON
RUN sudo apt-get install -y python3-pip build-essential libssl-dev libffi-dev python-dev python3-venv
RUN sudo pip3 install virtualenv 

### INSTALLING FZF
RUN git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
RUN ~/.fzf/install --all

### ADDING README
ADD README.txt /home/$USER/

### GIT CONFIG
RUN git config --global core.editor vim 
RUN git config --global user.name "$USER"
RUN git config --global user.email "$EMAIL"
