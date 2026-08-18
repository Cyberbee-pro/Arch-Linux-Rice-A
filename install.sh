#!bin/bash


if command -v git &> /dev/null; then
    echo "Git is installed: $(git --version)"
else
    echo "Git is not installed. . . . . installing Git. . . . ."
    pacman -Syu --needed git
fi
#git clone https://github.com/Darkkal44/qylock

