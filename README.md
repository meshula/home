# home

### git_config.sh
Run once. Adds git alias lol and lola which will print a concise change history

### start_ssh.sh
Launches an ssh agent, and adds a key named github

### macos
dot files

### wsl
dot files

### cargo
cargo install ripgrep
cargo install lsd
cargo install git-delta

### zig for vim

mkdir -p ~/.vim/pack/plugins/start/
cd ~/.vim/pack/plugins/start/
git clone https://github.com/ziglang/zig.vim

build or install zls at 

/Users/nporcino/bin/zls


### powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc
p10k configure


### Plug for windows

in powershell:

iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
    ni "$(@($env:XDG_DATA_HOME, $env:LOCALAPPDATA)[$null -eq $env:XDG_DATA_HOME])/nvim-data/site/autoload/plug.vim" -Force

### ccls windows

choco install ccls

