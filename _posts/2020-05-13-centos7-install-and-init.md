# Centos 7 安装以及初步配置

## 系统安装
系统安装比较简单，主要以下几点需要注意：
- 安装磁盘选择需要勾选手动配置，删除一些就系统数据之后，再点击自动配置或者直接手动配置，不然会保留原有系统。
- 不要忘记配置时区和键盘等。
- 安装内容按需要选择。

## 常用路径
一般查找可以用以下几个命令, 详见[查找命令使用详解](search-cmd.md)： 
- find
- locate
- which 方便查询命令
- whereis 方便查询一些常用文件如：hosts
- type

常用的路径如下
- hosts 文件： `/etc/hosts`
- 硬盘自动挂载配置文件： `/etc/fstab`
- 

## 防止合盖后进入睡眠
systemd 能够处理某些电源相关的 ACPI事件，修改对应 配置文件： /etc/systemd/logind.conf，常用的有以下几个：
- HandlePowerKey按下电源键后的行为
- HandleSleepKey 按下挂起键后的行为
- HandleHibernateKey 按下休眠键后的行为
- HandleLidSwitch 合上笔记本盖后的行为

对应的行为可以是 ignore、poweroff、reboot、halt、suspend、hibernate、hybrid-sleep、lock 或 kexec。

系统默认设置为：
```sh
HandlePowerKey=poweroff
HandleSuspendKey=suspend
HandleHibernateKey=hibernate
HandleLidSwitch=suspend
```

只需要把HandleLidSwitch选项设置为如下即可：

```sh
HandleLidSwitch=ignore
```

注意：设置完成保存后运行 `$ sudo systemctl restart systemd-logind `命令才生效。


## chrome 安装

```sh
$ sudo rpm -i google-chrome-stable_current_x86_64.rpm
...
error: Failed dependencies:
	libappindicator3.so.1()(64bit) is needed by google-chrome-stable-84.0.4147.89-1.x86_64
	liberation-fonts is needed by google-chrome-stable-84.0.4147.89-1.x86_64
	libvulkan.so.1()(64bit) is needed by google-chrome-stable-84.0.4147.89-1.x86_64
```
安装依赖：
`$ sudo yum -y install libappindicator-gtk3 liberation-fonts vulkan`


## 挂载NTFS硬盘
采用阿里云的源来安装：
- 添加epel yum源: `$ sudo wget -O /etc/yum.repos.d/epel.repo http://mirrors.aliyun.com/repo/epel-7.repo`
- 安装ntfs-3g: `$ sudo yum -y install ntfs-3g`
- 挂载硬盘： `sudo ntfs-3g /dev/sda1 /home/ti/Data`
- 添加自动挂载： 
	- 查询硬盘信息： `$ sudo fdisk -l`
	- 获取磁盘UUID： `$ sudo blkid`
	- 添加到文件 `/etc/fstab` 末尾： `UUID=3CA2F348A2F30564 /home/ti/Data ntfs defaults 0 0`
	- 重新装载硬盘： `$ sudo mount -a`
	- 已经装载了需要先卸载： `sudo umount /dev/sda1`


## 其他工具
- screen: `sudo yum -y install screen` 
- tmux: `sudo yum -y install tmux` 