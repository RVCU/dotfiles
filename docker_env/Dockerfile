FROM ubuntu:latest
ARG LOCAL_USER
ARG EMAIL

ENV LANG C.UTF-8
RUN apt -y update
RUN apt install -y ranger ShellCheck sudo zsh tmux make automake ruby rubygem-rake gcc \
                   man gcc-c++ kernel-devel python-devel python3-devel vim git ctags ruby-devel \
                   java-1.8.0-openjdk-devel maven wget nmap lynx cmake java \
                   htop golang bind-utils ncurses-compat-libs httpie jq elinks procps groovy
### CREATING USER
RUN useradd -ms /bin/bash $LOCAL_USER
RUN usermod $LOCAL_USER -a -G wheel
RUN echo "$LOCAL_USER:password" | chpasswd
USER $LOCAL_USER
WORKDIR /home/$LOCAL_USER
### COPYING OVER .conf FILES
ADD files/tmux.conf /home/$LOCAL_USER/.tmux.conf
ADD files/bashrc /home/$LOCAL_USER/.bashrc
ADD files/vimrc  /home/$LOCAL_USER/.vimrc
RUN mkdir -p /home/$LOCAL_USER/.vim/vimrc.d /home/$LOCAL_USER/.vim/templates
ADD files/vimrc.d/ /home/$LOCAL_USER/.vim/vimrc.d/
COPY files/templates/* /home/$LOCAL_USER/.vim/templates/
RUN git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim 
RUN echo | echo | vim +PluginInstall +qall &> /dev/null
RUN git config --global core.editor vim 
RUN git config --global user.name "$LOCAL_USER"
RUN git config --global user.email "$EMAIL"
ENTRYPOINT ["/bin/bash"]
