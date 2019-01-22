FROM alpine:3.8

RUN apk --no-cache add bash curl dos2unix git jq ncurses perl python py-pip tree vim zsh && \
    pip install --user --no-warn-script-location powerline-status pygments

ENV PATH /root/.local/bin:$PATH
ENV POWERLINE_HOME /root/.local/lib/python2.7/site-packages/powerline

RUN curl -fsSL https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim -o ~/.vim/autoload/plug.vim --create-dirs && \
    git clone https://github.com/tmux-plugins/tpm.git ~/.tmux/plugins/tpm && \
    git clone https://github.com/zplug/zplug ~/.zsh/.zplug

RUN git clone https://github.com/m5d215/dotfiles.git ~/.ghq/github.com/m5d215/dotfiles && \
    mkdir ~/.config && \
    ln -fsv ~/.ghq/github.com/m5d215/dotfiles/src/.config/powerline ~/.config/powerline && \
    ln -fsv ~/.ghq/github.com/m5d215/dotfiles/src/.zsh/functions    ~/.zsh/functions && \
    ln -fsv ~/.ghq/github.com/m5d215/dotfiles/src/.zsh/.zshrc       ~/.zsh/.zshrc && \
    ln -fsv ~/.ghq/github.com/m5d215/dotfiles/src/bin               ~/bin && \
    ln -fsv ~/.ghq/github.com/m5d215/dotfiles/src/.aliases          ~/.aliases && \
    ln -fsv ~/.ghq/github.com/m5d215/dotfiles/src/.bash_profile     ~/.bash_profile && \
    ln -fsv ~/.ghq/github.com/m5d215/dotfiles/src/.bashrc           ~/.bashrc && \
    ln -fsv ~/.ghq/github.com/m5d215/dotfiles/src/.editorconfig2    ~/.editorconfig && \
    ln -fsv ~/.ghq/github.com/m5d215/dotfiles/src/.environment      ~/.environment && \
    ln -fsv ~/.ghq/github.com/m5d215/dotfiles/src/.gitconfig        ~/.gitconfig && \
    ln -fsv ~/.ghq/github.com/m5d215/dotfiles/src/.tmux.conf        ~/.tmux.conf && \
    ln -fsv ~/.ghq/github.com/m5d215/dotfiles/src/.vimrc            ~/.vimrc && \
    ln -fsv ~/.ghq/github.com/m5d215/dotfiles/src/.zshenv           ~/.zshenv && \
    zsh -ic 'exit' && \
    bash -c "vim -u <(sed -e '/colorscheme/d' /root/.vimrc) +PlugInstall +qall </dev/null >/dev/null 2>/dev/null"

ENTRYPOINT ["/bin/zsh"]
