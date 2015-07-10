rm -rf $HOME/.zshrc
ln -sf $HOME/.hebi/zsh/zshrc $HOME/.zshrc
if [ -z $ZSH ]; then
  echo "\$ZSH not set. Setting to $HOME/.oh-my-zsh"
  export ZSH=$HOME/.oh-my-zsh
fi
ln -sf $HOME/.hebi/zsh/hebi.zsh-theme $ZSH/custom/
