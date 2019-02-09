FROM fedora:latest
ARG USER
ARG LOCAL_USER
ARG EMAIL
ARG OSS_USER
ARG OSS_EMAIL 

ENV LANG C.UTF-8
RUN yum -y update && yum clean all
RUN yum install -y ranger ShellCheck sudo zsh tmux make automake ruby rubygem-rake gcc \
                   man gcc-c++ kernel-devel python-devel python3-devel vim git ctags ruby-devel \
                   java-1.8.0-openjdk-devel maven java-1.8.0-openjdk wget nmap lynx cmake java \
                   htop golang bind-utils ncurses-compat-libs httpie jq elinks procps groovy 
RUN useradd -ms /bin/bash $LOCAL_USER
RUN usermod $LOCAL_USER -a -G wheel
RUN echo "$LOCAL_USER:password" | chpasswd
USER $LOCAL_USER
WORKDIR /home/$LOCAL_USER
ADD bin /home/$LOCAL_USER/bin
ADD .temp-testng-customsuite.xml .tmux.conf .bashrc .vimrc .bash_work_functions* /home/$LOCAL_USER/
RUN mkdir -p /home/$LOCAL_USER/.vim/vimrc.d && mkdir -p /home/$LOCAL_USER/.vim/templates
ADD .vimrc.d/ /home/$LOCAL_USER/.vim/vimrc.d/
ADD vim_work_functions.vim /home/$LOCAL_USER/.vim 
COPY templates/* /home/$LOCAL_USER/.vim/templates/
RUN git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim 
RUN echo | echo | vim +PluginInstall +qall &> /dev/null
RUN cd ~/.vim/bundle/command-t; rake make 
RUN cd ~/.vim/bundle/vim-javacomplete2/libs/javavi/ && mvn compile
RUN cd ~/.vim/bundle/vimproc.vim; make 
RUN git config --global core.editor vim && git config --global difftool.vdwrap.cmd 'vdwrap $LOCAL $REMOTE' && git config --global diff.tool vdwrap
RUN /home/$LOCAL_USER/bin/git-identity --define default $LOCAL_USER $EMAIL
RUN /home/$LOCAL_USER/bin/git-identity --define-ssh default /home/$LOCAL_USER/.ssh/Work_Github
RUN /home/$LOCAL_USER/bin/git-identity --define oss $OSS_USER $OSS_EMAIL
RUN /home/$LOCAL_USER/bin/git-identity --define-ssh oss /home/$LOCAL_USER/.ssh/RCVU.key


CMD cp -r ~/code_clean ~/code; cd ~/code; ls | xargs -P11 -I{} git -C {} pull; bash
