clear
printf   "\033[0;32m  |  |  ___ \    \  |         |\n  |  |     ) |  |\/ |   _  |  |  /   _ \\n ___ __|  __/   |   |  (   |    <    __/ \n    _|  _____| _|  _| \__,_| _|\_\ \___|\033[m\n                  made with \033[0;31m♥\033[m by \033[0;32mjcluzet\033[m\n\n"
mkdir ~/.42Make
printf "Installation of \033[0;32m42Make\033[m in \033[0;32m~/.42Make/\033[m\n\n"
mv * ~/.42Make
sleep 2
chmod 777 ~/.42Make
printf "Give all rights to \033[0;32m42Make\033[m in \033[0;32m~/.42Make/\033[m using chmod.\n\n"
sleep 2
echo 'alias 42make="sh ~/.42Make/launch_42_make.sh"' >> ~/.zshrc
printf "Set an alias in \033[0;32m~/.zshrc\033[m for launch \033[0;32m42Make\033[m using alias.\n\n"
sleep 2
echo "\033[0;32m42Make\033[m setup finish, please close and open your terminal\n" 
printf "All the files in this folder have been moved to \033[0;32m~/.42Make\033[m, so now you can delete this git folder\n"
echo "Use \033[0;32m42Make\033[m with the command > /42make\n\n"
