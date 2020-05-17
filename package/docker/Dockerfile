FROM golang:1.13
MAINTAINER Ray Kuan

# install pagkages
RUN apt-get update                                                      && \
    apt-get install -y ncurses-dev libtolua-dev exuberant-ctags sudo    && \
    ln -s /usr/include/lua5.2/ /usr/include/lua                         && \
    ln -s /usr/lib/x86_64-linux-gnu/liblua5.2.so /usr/lib/liblua.so     && \
# cleanup
    apt-get clean && rm -rf /var/lib/apt/lists/*

# build and install vim
RUN cd /tmp                                                             && \
    git clone --depth 1 https://github.com/vim/vim.git                  && \
    cd vim                                                              && \
    ./configure --with-features=huge --enable-luainterp                    \
        --enable-gui=no --without-x --prefix=/usr                       && \
    make VIMRUNTIMEDIR=/usr/share/vim/vim82                             && \
    make install

# build and install nvim
RUN apt-get update -qq                                                  && \
    apt-get install -yq cmake unzip wget gettext                        && \
# cleanup
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN cd /tmp                                                             && \
    git clone --depth 1 https://github.com/neovim/neovim.git            && \
    cd neovim                                                           && \
    make CMAKE_INSTALL_PREFIX=/usr CMAKE_BUILD_TYPE=RelWithDebInfo      && \
    make install

# protobuf
RUN cd /tmp                                                             && \
    git clone https://github.com/google/protobuf.git                    && \
    cd protobuf                                                         && \
    ./autogen.sh                                                        && \
    ./configure                                                         && \
    make                                                                && \
    make install                                                        && \
    ldconfig

# cleanup
RUN rm -rf /tmp/* /var/tmp/*

# get go tools
ENV GOBIN /usr/local/go/bin
RUN mkdir -p $GOBIN && chmod 777 -R $GOBIN
RUN go get golang.org/x/tools/cmd/godoc                                 && \
    go get github.com/nsf/gocode                                        && \
    go get golang.org/x/tools/cmd/goimports                             && \
    go get github.com/rogpeppe/godef                                    && \
    go get golang.org/x/tools/cmd/gorename                              && \
    go get golang.org/x/lint/golint                                     && \
    go get github.com/kisielk/errcheck                                  && \
    go get github.com/jstemmer/gotags                                   && \
    go get github.com/tools/godep                                       && \
    go get github.com/go-delve/delve/cmd/dlv                            && \
    go get google.golang.org/grpc                                       && \
    go get github.com/golang/protobuf/protoc-gen-go                     && \
    GO111MODULE=on go get golang.org/x/tools/gopls@latest               && \
# cleanup
    rm -rf /go/src/* /go/pkg

ADD fs/ /

# add dev user
RUN adduser dev --disabled-password --gecos ""                          && \
    echo "ALL            ALL = (ALL) NOPASSWD: ALL" >> /etc/sudoers     && \
    chown -R dev:dev /home/dev /go

USER dev
ENV HOME /home/dev

# install vim plugins
RUN curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim && \
    sed -i 's/colorscheme/"olorscheme/g' ~/.vimrc                       && \
    vim +PlugInstall +qall                                              && \
    sed -i 's/"olorscheme/colorscheme/g' ~/.vimrc

# install nvim plugins
RUN curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim && \
    sed -i 's/colorscheme/"olorscheme/g' ~/.config/nvim/init.vim        && \
    nvim +PlugInstall +qall                                             && \
    nvim +UpdateRemotePlugins +qall                                     && \
    sed -i 's/"olorscheme/colorscheme/g' ~/.config/nvim/init.vim        && \
    cp -f ~/.config/nvim/bundle/oceanic-next/colors/OceanicNext.vim \
          ~/.config/nvim/bundle/oceanic-next/colors/OceanicNext.vim.org && \
    sed -i 's/1b2b34/000000/g' \
          ~/.config/nvim/bundle/oceanic-next/colors/OceanicNext.vim

