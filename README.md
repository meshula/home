# home

### git_config.sh
Run once. Adds git alias lol and lola which will print a concise change history

### git config --global core.autocrlf false

### start_ssh.sh
Launches an ssh agent, and adds a key named github

### windows terminal
init.vim goes in ~/AppData/Local/nvim
ssh keys go in ~/.ssh

### windows install SSH server
Settings > Optional Features > Add a feature > OpenSSH Client
In an elevated powershell, 

Set-Service -StartupType Manual ssh-agent
Start-SshAgent

edit git config --globel -e

and add
[core]
    sshCommand = c:\WINDOWS\System32\OpenSSH\ssh.exe

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

### theme.sh

sudo curl -Lo ~/bin/theme.sh 'https://git.io/JM70M'
sudo chmod +x ~/bin/theme.sh
theme.sh --dark --list
theme.sh zenburn

### for clangd
in order that C++ completion works within nvim:

cmake . -DCMAKE_EXPORT_COMPILE_COMMANDS=1

