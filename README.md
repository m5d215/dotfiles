# dotfiles

## Installation

## Linux

```sh
curl https://setup-shell.now.sh | sh -
```

## Windows

```sh
git clone https://github.com/m5d215/dotfiles.git ~/.ghq/github.com/m5d215/dotfiles
cd ~/.ghq/github.com/m5d215/dotfiles
powershell -Command Start-Process -Verb runas install.bat
```

## Play with Docker

You can try my environment on Docker.

![size and layers](https://images.microbadger.com/badges/image/m5d215/env.svg)

```sh
docker container run --rm -it m5d215/env:latest
```
