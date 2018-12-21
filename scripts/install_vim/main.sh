#! /usr/bin/env bash
# https://github.com/Karmenzind/

sudo apt-get -y install vim-gtk git cmake libncurses5-dev libgnome2-dev libgnomeui-dev libgtk2.0-dev \
    libatk1.0-dev libbonoboui2-dev libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev python3-dev \
    llvm-3.9 clang-3.9 libclang-3.9-dev libboost-all-dev ruby-dev lua5.1 liblua5.1-dev libperl-dev \
    ruby-dev lua5.1 liblua5.1-dev libperl-dev ctags

no_root

(which pacman > /dev/null) && is_arch=true || is_arch=false
if ($is_arch); then
    sudo pacman -S gvim --needed 

# --------------------------------------------
# colors
# --------------------------------------------

color_dir=~/.vim/colors

colors_url=('https://raw.githubusercontent.com/tomasr/molokai/master/colors/molokai.vim'
            'https://raw.githubusercontent.com/altercation/vim-colors-solarized/master/colors/solarized.vim')

mkdir -p $color_dir
for u in ${colors_url[*]}
do
    fname="$color_dir/`basename $u`"
    [[ ! -e $fname ]] && wget -P $color_dir $u
done

# --------------------------------------------
# plugins
# --------------------------------------------

restore_my_vim () {
    cp $repo_dir/home_k/.vimrc ~/.vimrc
    cat << EOF
PlugInstall will start right now.
If it fails on YouCompleteMe,
you may need to execute install.sh
and try 'install Vim Plugin: YouCompleteMe' 
EOF
    read -p "Type any key to continue" whatever
    vim +PlugInstall +qall
}

echo "Do you want to use my .vimrc? (Y/n)"
check_input yn
if [[ $ans = 'y' ]]; then
    restore_my_vim
fi
