# ghaabor/dotfiles

## Requirements
* ansible
* make

## Usage
1. Install ansible
2. Run `make`
3. Exit & restart shell
4. `Ctrl-B` + `Shift-I` to install tmux plugins
5. Launch nvim
6. `:PlugInstall`
7. `:CocInstall coc-go`

## Todos
* Install oh-my-zsh via playbook
* Install goenv via playbook
* Install rbenv via playbook
* Install tfenv via playbook
* Make playbook compatible with both Ubuntu and Fedora (refactor into better Ansible code?)
* Test playbook with Ansible Molecule
