# python 环境搭建和配置
## 安装 python
Centos 7.8 自带 python 2.7.5, 所以只需要安装 python3: `sudo yum -y install python3` 
```sh
$ python3 -V
Python 3.6.8
```
### 添加国内源

国内的镜像源分别如下：
- 清华大学：https://pypi.tuna.tsinghua.edu.cn/simple
- 阿里：https://mirrors.aliyun.com/pypi/simple
- 豆瓣：http://pypi.douban.com/simple/
- 中国科学技术大学： https://pypi.mirrors.ustc.edu.cn/simple
- 华中理工大学： http://pypi.hustunique.com/simple
- 山东理工大学： http://pypi.sdutlinux.org/simple

以阿里为例：
```sh
$ mkdir ～/.pip

$ vim pip.conf
[global]
index-url=http://mirrors.aliyun.com/pypi/simple/
[install]
trusted-host=mirrors.aliyun.com
```

## 安装 pip 以及其他工具
CentOS and RHEL don’t offer pip or wheel in their core repositories, although setuptools is installed by default.

To install pip and wheel for the system Python, there are two options:

1. Enable the [EPEL repository](https://fedoraproject.org/wiki/EPEL). On EPEL 6 and EPEL7, you can install pip like so:
    ```
    sudo yum install python-pip
    ```
    On EPEL 7 (but not EPEL 6), you can install wheel like so:
    ```
    sudo yum install python-wheel
    ```

2. Since EPEL only offers extra, non-conflicting packages, EPEL does not offer setuptools, since it’s in the core repository.

    Enable the [PyPA Copr Repo](https://copr.fedorainfracloud.org/coprs/pypa/pypa/) fllow by [How to enable repo](https://docs.pagure.org/copr.copr/how_to_enable_repo.html#how-to-enable-repo) to download a repo file and place it to `/etc/yum.repos.d/` > `+ copr.repo`. 
    You have two options to do that:
    
    You can install pip and wheel like so:
    ```
    sudo yum install python-pip python-wheel
    ```
    To additionally upgrade setuptools, run:
    ```
    sudo yum upgrade python-setuptools
    ```

## 安装 virtualenv 和 virtualenvwrapper

- **virtualenv**: `pip3 install --user virtualenv`
- **virtualenvwrapper**: `pip3 install --user virtualenvwrapper`
```
$ whereis virtualenvwrapper.sh
virtualenvwrapper: /home/ti/.local/bin/virtualenvwrapper.sh
```
add to `~/.bashrc`
```
WORKON_HOME=~/.pyenvs  
VIRTUALENVWRAPPER_VIRTUALENV_ARGS='--no-site-packages' 
VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
source virtualenvwrapper: /home/ti/.local/bin/virtualenvwrapper.sh
```

### `virtualenvwrapper` 命令简介，具体参加详细说明书: [virtualenvwrapper-readthedocs-io-en-latest.pdf](virtualenvwrapper-readthedocs-io-en-latest.pdf)
- **Managing Environments**
  * `mkvirtualenv`: Create a new virtualenv in $WORKON_HOME
  * `mktmpenv`: create a temporary virtualenv
  * `lsvirtualenv`: list virtualenvs
  * `showvirtualenv`: show details of a single virtualenv
  * `rmvirtualenv`: Remove a virtualenv
  * `cpvirtualenv`: duplicate the named virtualenv to make a new one
  * `allvirtualenv`: run a command in all virtualenvs
- **Controlling the Active Environment**
  * `workon`: list or change working virtualenvs
  * `deactivate` : exit working virtualenvs
- **Quickly Navigating to a virtualenv**
  - `cdvirtualenv`: change to the $VIRTUAL_ENV directory
  - `cdsitepackages`: change to the site-packages directory
  - `lssitepackages`: list contents of the site-packages directory
- **Path Management**
  - `add2virtualenv`: add directory to the import path
  - `toggleglobalsitepackages`: turn access to global site-packages on/off
- **Project Directory Management**
  - `mkproject`: create a new project directory and its associated virtualenv
  - `setvirtualenvproject`: associate a project directory with a virtualenv
  - `cdproject`: change directory to the active project
- **Managing Installed Packages**
  - `wipeenv`: remove all packages installed in the current virtualenv
- **Other Commands**
  - `virtualenvwrapper`: show this help message


## 常用模块安装
- **matplotlib**: `pip3 install --user matplotlib`
- **numpy**: `pip3 install --user numpy`
- **pandas**: `pip3 install --user pandas`wo