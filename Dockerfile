FROM fedora:25
ENV container docker

RUN dnf remove vim-minimal -y && dnf -y --allowerasing install procps-ng \
        vim \
        passwd \
        git \
        python \
        python-devel \
        ruby \
        cmake \
        ctags \
        xz \
        clang \
        npm \
        golang && dnf clean all

RUN git clone https://github.com/enoodle/vimrc ~/vimrc -b for_devel_container && \
        mkdir -p ~/.vim/bundle && \
        git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim && \
        echo "source ~/vimrc/vimrc" > ~/.vimrc && \
        vim +PluginInstall +qall && \
        ~/.vim/bundle/YouCompleteMe/install.py --tern-completer --gocode-completer

RUN echo "123456" | passwd --stdin root

CMD [ "/sbin/init" ]
