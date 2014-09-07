[ -z "$VUNDLE_URI" ] && VUNDLE_URI="https://github.com/gmarik/vundle.git"

sym_links() {
    ln -sf "$HOME/.hebi/vimrc" "$HOME/.vimrc"
}

clone_vundle() {
    if [ ! -e "$HOME/.vim/bundle/vundle" ]; then
        git clone $VUNDLE_URI "$HOME/.vim/bundle/vundle"
    else
        echo "Opoose, vundle has already installed?"
	exit 1
    fi
}

setup_vundle() {
    system_shell="$SHELL"
    export SHELL='/bin/sh'
    vim +PluginInstall +qall
    export SHELL="$system_shell"
}

sym_links
clone_vundle
setup_vundle
