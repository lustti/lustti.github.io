# 安装oh-my-zsh
查看当前shell
```sh
$ echo $SHELL
bin/bash
```
安装zsh
`$ sudo yum install -y zsh`

设置默认shell
`chsh -s /bin/zsh`

安装oh-my-zsh（自动）
`sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"`

使用curl来安装，wget命令执行后不起作用，暂时不知道怎么回事。

手动安装
下载源码

`git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh`

复制配置

`cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc`

修改主题
ZSH_THEME 字段就是主题，可以从资料里的主题找

完成后，重启生效默认shell
`reboot`

别名配置
首先我们看下git的别名

`vi ~/.oh-my-zsh/plugins/git/git.plugin.zsh`

install powerline font: 
https://github.com/powerline/fonts


vscode terminal font error: 
"terminal.integrated.fontFamily": "Source Code Pro for Powerline"