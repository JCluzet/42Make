#!/bin/sh

vertclair='\033[0;32m'
neutre='\033[m'
rouge='\033[0;31m'

arg1="hey"

loading () {
    sleep 0.2; header 1; sleep 0.2; header 2; sleep 0.2; header 3; sleep 0.2; header 4; sleep 0.2; header 5; sleep 0.2; header 6; sleep 0.2; header 7; sleep 0.2; header 8; sleep 0.2; header 9; sleep 0.2; header 10;
}

yes_or_no () {
    echo $1
    while true; do
    read temp
    case $temp in
        [Yy]* ) return 0;;
        [Nn]* ) return 1;;
        * ) echo "Please answer yes or no (y / n)\n";;
    esac
done
}

ask () {
    echo $1
    if [ $# -eq 2 ]
    then 
    printf $2 >> Makefile_temp
    printf "    = " >> Makefile_temp
    fi
    read temp
    echo $temp >> Makefile_temp
}

blank () {
    clear
}

loading_bar () {
    COUNTER=0
    printf "\033[0;32m"
    while ((COUNTER!=$1*2))
    do
    printf "▀▀"
    COUNTER=$((COUNTER+1))
    done
    printf "\033[m"
    while ((COUNTER!=20))
    do
    printf "▀▀"
    COUNTER=$((COUNTER+1))
    done
    printf "\n\n"
}

check_at_the_end () {
    header 9
    printf "\033[0;32m9. \033[m Please verify the informations you enter:\n\n"
    cat Makefile_temp | grep "NAME"
    cat Makefile_temp | grep "CFLAGS"
    cat Makefile_temp | grep -e "FILE_EXTENSION"
    cat Makefile_temp | grep -e "INCLUDE_PATH"
    cat Makefile_temp | grep -e "MAIN"
    cat Makefile_temp | sed '1,34d' | tr -d '\t\n' | tr -d '\'
    printf "\n"
    if yes_or_no "\nIs this \033[0;32mcorrect\033[m ? (y / n)"
    then
    header 0
    printf "\033[0;32mGreat !\033[m\nNow wait until your Makefile generating...\n\n"
    sleep 1.5;
    loading
    else
    header 10
    printf "Please correct your file \033[0;32mMakefile_temp\033[m and rename it \033[0;32mMakefile\033[m after.\nYou can also launch \033[0;32m42Make\033[m again.\n"
    exit;
    fi
}

header () {
    clear
    printf   "\033[0;32m  |  |  ___ \    \  |         |\n  |  |     ) |  |\/ |   _  |  |  /   _ \\n ___ __|  __/   |   |  (   |    <    __/ \n    _|  _____| _|  _| \__,_| _|\_\ \___|\033[m\n"
    loading_bar $1
}

clear

printf   "\033[0;32m  |  |  ___ \    \  |         |\n  |  |     ) |  |\/ |   _  |  |  /   _ \\n ___ __|  __/   |   |  (   |    <    __/ \n    _|  _____| _|  _| \__,_| _|\_\ \___|\n  Creation of Makefile for your project\033[m\n\n"
echo   "#  |  |  ___ \    \  |         |\n#  |  |     ) |  |\/ |   _  |  |  /   _ \\n# ___ __|  __/   |   |  (   |    <    __/ \n#    _|  _____| _|  _| \__,_| _|\_\ \___|\n#                              by jcluzet\n" > Makefile_temp
printf   "################################################################################\n#                                     CONFIG                                   #\n################################################################################\n\n" >> Makefile_temp
header 0
ask "\033[0;32m1. \033[mWhat is the name of your executable ? (ex : minishell or a.out)" "NAME     = "
header 1
if yes_or_no "\033[0;32m2. \033[mIs your project use Minilibx ? (y / n)"
then
    printf "BIMLX   = ON\n" >> Makefile_temp
    printf "MLX     = libmlx.a\n" >> Makefile_temp
    header 2
    printf "\033[0;31m⚠ Becarful about using minilibx with different environnement\n\033[mYou must have\033[0;32m mlx \033[mand \033[0;32mmlx_linux\033[m folder in your repo.\n\n"
    if yes_or_no "Want you \033[0;32m42Make\033[m to install\033[0;32m mlx\033[m & \033[0;32mmlx_linux \033[mfolder? (y / n)"
    then
    clear
    cp -r ~/.42Make/mlx .
    cp -r ~/.42Make/mlx_linux .
    echo "\033[0;32m✓ mlx and mlx_linux is now in your repo\n\033[m"
    sleep 1; 
    else
    blank;
    printf "Skipping installation of mlx & mlx_linux\n\n"
    fi
else
    printf "BIMLX   = OFF\n" >> Makefile_temp
fi
printf "CC      = clang\n" >> Makefile_temp

header 3

if yes_or_no "\033[0;32m3. \033[mDo you need a compilation with \033[0;32m-Wall -Werror -Wextra\033[m flags ? (y / n)"
then
    printf "CFLAGS  = -Wall -Wextra -Werror" >> Makefile_temp
else
    printf "CFLAGS  =" >> Makefile_temp
fi

header 4

if yes_or_no "\033[0;32m4. \033[mDo you need a compilation with \033[0;32maddress-sanitizer \033[mfor easy debug ? \033[0;31m(Forbidden in correction)\033[m (y / n)"
then
    printf " -g3 -fsanitize=address" >> Makefile_temp
fi

header 5

if yes_or_no "\033[0;32m5. \033[mDo you want to add more flags ? (y / n)\n     \033[0;32m      ➢ \033[mYou don't need to add flag for mlx"
then
header 5
printf " " >> Makefile_temp
ask "Type the flags you want to add : (ex : -readline)"
fi

printf "\nDFLAGS	= -MMD -MF \$(@:.o=.d)\nDATE	= 01/01/1970\nHASH	= \n\nNOVISU 	= 0 # 1 = no progress bar usefull when tty is not available\n\n" >> Makefile_temp

printf "################################################################################\n#                                 PROGRAM'S SRCS                               #\n################################################################################\n" >> Makefile_temp

header 6

fill_srcs () {
    while [ "$temp" != "exit" ]
    do
        read temp
        if [ "$temp" != "exit" ]
        then
        if [ "$temp" != "\n" ]
        then
        if [ "$temp" != " " ]
        then
        printf "$temp \\					" >> Makefile_temp
        printf "\n					" >> Makefile_temp
        fi
        fi
        fi
    done
}

if yes_or_no "\033[0;32m6. \033[mYour project was write in \033[0;32mC\033[m ? (y / n)"
then
    printf "\nFILE_EXTENSION  = .c" >> Makefile_temp
else
    header 6
    ask "What is your extension file ? (If your project is made in C you may use .c)" "\nFILE_EXTENSION  = "
fi
printf "\n\nSRCS_PATH       = ./\n\n" >> Makefile_temp
header 6
ask "\033[0;32m6. \033[mWhat is the PATH of your .h file ? \nex :\n             \033[0;32m➢ \033[m Your .h is in \033[0;32minclude folder\033[m,   you must write : \033[0;32m./include \033[m \n\033[0;32m              ➢ \033[m Your .h is in \033[0;32mrepo folder\033[m,      you must write : \033[0;32m./ \033[m \n\033[0;32m              ➢ \033[m Your .h is in \033[0;32msrcs/inc/folder\033[m, you must write : \033[0;32m./srcs/inc \033[m \n" "INCLUDE_PATH   = "
printf "\n" >> Makefile_temp
header 7
ask "\033[0;32m7. \033[mWhat is the file contain your \033[0;32mmain\033[m ?" "MAIN                  = "
header 8
printf "\n" >> Makefile_temp
printf "\033[0;32m7. \033[mNow it's time to setup all your \033[0;32mSRCS\033[m files.\n\033[0;32m   ➢ \033[m You can use wildcards '*', they will be automatically replace by files names(comming soon).\n\033[0;32m   ➢ \033[m When you have finish to write all your \033[0;32mSRCS\033[m you can finish the creation by writing \033[0;31mexit\033[m.\n"
printf "         example :\033[0;32m    srcs/ft_display.c\033[m   |   \033[0;32msrcs/ft_init_window.c\033[m   |   \033[0;32mparsing/ft_check.c\033[m"
printf "\n\033[0;31m         ⚠ DONT WRITE \033[myour file used by your MAIN like : main.c\n\n"

printf "SRCS            =   	" >> Makefile_temp

fill_srcs

header 9

check_at_the_end


clear
printf "\n\n" >> Makefile_temp
cat ~/.42Make/utils >> Makefile_temp


mv Makefile_temp Makefile
printf   "\033[0;32m  |  |  ___ \    \  |         |\n  |  |     ) |  |\/ |   _  |  |  /   _ \\n ___ __|  __/   |   |  (   |    <    __/ \n    _|  _____| _|  _| \__,_| _|\_\ \___|\033[m\n                  made with \033[0;31m♥\033[m by \033[0;32mjcluzet\033[m\n\n\nYou can now find your \033[0;32mMakefile\033[m in your repo.\n\n\n\n"