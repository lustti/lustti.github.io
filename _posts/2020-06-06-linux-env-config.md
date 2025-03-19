# 环境变量文件的比较

> linux不同环境变量文件的比较，如/etc/profile和/etc/environment
[> 原文](https://www.cnblogs.com/YC-L/p/12602616.html)

## **/etc/profile**
为系统的每个用户设置环境信息和启动程序，当用户第一次登录时，该文件被执行，其配置对所有登录的用户都有效。

当被修改时，必须重启才会生效。英文描述：”System wide environment and startup programs, for login setup.”

## **/etc/environment**
系统的环境变量，/etc/profile是所有用户的环境变量，前者与登录用户无关，后者与登录用户有关，当同一变量在两个文件里有冲突时，以用户环境为准。

## **/etc/bashrc**
为每个运行 bash shell 的用户执行该文件，当 bash shell 打开时，该文件被执行，其配置对所有使用bash的用户打开的每个bash都有效。

当被修改后，不用重启只需要打开一个新的 bash 即可生效。英文描述：”System wide functions and aliases.”

## **~/.bash_profile**
为当前用户设置专属的环境信息和启动程序，当用户登录时该文件执行一次。默认情况下，它用于设置环境变量，并执行当前用户的 .bashrc 文件。

理念类似于 /etc/profile，只不过只对当前用户有效，也需要重启才能生效。(注意：Centos7系统命名为.bash_profile，其他系统可能是.bash_login或.profile。)

## **~/.bashrc**
为当前用户设置专属的 bash 信息，当每次打开新的shell时，该文件被执行。理念类似于/etc/bashrc，只不过只对当前用户有效，不需要重启只需要打开新的shell即可生效。

## **~/.bash_logout**
为当前用户，每次退出bash shell时执行该文件，可以把一些清理工作的命令放进这个文件。

## **/etc/profile.d/**
此文件夹里是除/etc/profile之外其他的”application-specific startup files”。英文描述为”The /etc/profile file sets the environment variables at startup of the Bash shell. The /etc/profile.d directory contains other scripts that contain application-specific startup files, which are also executed at startup time by the shell.”

同时，这些文件”are loaded via /etc/profile which makes them a part of the bash “profile” in the same way anyway.”

因此可以简单的理解为是/etc/profile的一部分，只不过按类别或功能拆分成若干个文件进行配置了（方便维护和理解）。

## 注意事项
以上需要重启才能生效的文件，其实可以通过source xxx暂时生效。

文件的执行顺序为：当登录Linux时，首先启动/etc/environment和/etc/profile，然后启动当前用户目录下的/.bash_profile，执行此文件时一般会调用/.bashrc文件，而执行/.bashrc时一般会调用/etc/bashrc，最后退出shell时，执行/.bash_logout。简单来说顺序为：

（登录时）/etc/environment –> /etc/profile(以及/etc/profile.d/里的文件) –> ~/.bash_profile –> （打开shell时）~/.bashrc –> /etc/bashrc –> （退出shell时）~/.bash_logout
