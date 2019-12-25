FROM alpine:3

RUN apk --no-cache add \
        bash \
        cargo \
        curl \
        dos2unix \
        file \
        git \
        go \
        jq \
        ncurses \
        perl \
        tree \
        vim \
        zsh

#RUN cargo install bat
#RUN cargo install exa
#RUN cargo install fd
#RUN cargo install hyperfine
RUN go get -u github.com/justjanne/powerline-go
RUN go get -u github.com/relastle/pmy
RUN go get -u github.com/relastle/taggo

ENV PATH /root/go/bin:$PATH

RUN curl -fsSL https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim -o ~/.vim/autoload/plug.vim --create-dirs && \
    git clone https://github.com/tmux-plugins/tpm.git ~/.tmux/plugins/tpm && \
    git clone https://github.com/zdharma/zplugin.git ~/.zsh/.zplugin/bin

ADD . /root/src/github.com/m5d215/dotfiles

RUN ~/src/github.com/m5d215/dotfiles/install.sh && \
    zsh -c '. /root/.zshenv && . /root/.zsh/.zshrc' && \
    bash -c "vim -u <(sed -e '/colorscheme/d' /root/.vimrc) +PlugInstall +qall </dev/null >/dev/null 2>/dev/null"

ENTRYPOINT ["/bin/zsh"]
