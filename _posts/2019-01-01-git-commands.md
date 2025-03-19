# Git 基础命令

- [基本操作](#基本操作)
  - [初始配置](#初始配置)
  - [创建版本库](#创建版本库)
  - [远程仓库管理](#远程仓库管理)
  - [文件操作](#文件操作)
  - [创建和提交](#创建和提交)
  - [查看提交历史](#查看提交历史)
  - [远程操作](#远程操作)
- [进阶操作](#进阶操作)
  - [撤销](#撤销)
  - [分支和标签](#分支和标签)
  - [合并与衍合](#合并与衍合)
  - [tag 标签](#tag-标签)
  - [版本回退](#版本回退)
- [常见问题](#常见问题)
  - [换行符问题解决](#换行符问题解决)

## 基本操作

> `git` 的命令以及其二级命令都可以用 `-h` 来查看对应的使用说明。

### 初始配置

配置用户名和邮箱：

```shell
git config --global user.name "<user_name>"
git config --global user.email "<user_email>"
```

`--global` 改为 `--local` 则该配置只对本地库起作用。
`-h` 可以查看 `git config` 的使用方法，即：

```shell
git config -h
```

### 创建版本库

```shell
git clone <url> #克隆远程版本库创建
```

```shell
git init #初始化本地版本库
```

### 远程仓库管理

```shell
git remote -v #查看远程仓库地址
git remote #查看远程仓库
git remote remove <remote_name> #删除远程库
git remote add origin <url> #添加远程库
git remote rename <old_name> <new_name> #修改远程库名称
git remote set-url <remote_url> <url> #修改远程库地址
```

### 文件操作

```shell
git rm <file> #删除文件
git mv <file> <target_file> #对文件移动或改名
```

### 创建和提交

```shell
#创建并切换到分支从已有的分支创建新的分支(如从 main 分支),创建一个 dev 分支
git checkout -b dev
git push origin dev #提交该分支到远程仓库
git branch -d <branch_name> #删除本地分支
git branch -a | -r # 查看项目的分支们(包括本地和远程) `-r` 查看远程的分支
git status #查看状态
git diff #查看变更内容
git add .  # 暂存当前文件下的所有改动过的文件的修改, 不要忽略 `.` 指代前文件夹
git add <file> # 暂存指定的文件的修改
git mv <old_file_name> <new_file_name>  #文件改名
git rm --cached <file>  #删除文件
git commit -m "commit message"  # 提交已暂存文件的修改
git commit --amend # 修改最后一次提交
```

### 查看提交历史

```shell
git reflog #查看版本变化
git log #查看提交历史
git log --oneline #查看提交历史-单行显示，等同 `git reflog`
git log --pretty=oneline #查看提交历史-单行显示(长哈希值)
git log -p <file> #查看指定文件的提交历史
git blame <file> #以列表方式查看指定文件的提交历史
```

### 远程操作

```shell
git remote -v #查看远程版本信息
git remote show <remote_name> #查看指定远程版本信息
git remote add <remote_name> <url> #添加远程版本库
git fetch <remote_name> #从远程库获取代码
git pull <remote_name> <branch> #下载代码及快速合并
git push <remote_name> <branch> #上传代码及快速合并
git pull <remote_name>:<branch/tag-name> # 删除远程分支或标签
git push --all #上传所有分支
git push --tags #上传所有标签
```

## 进阶操作

> `HEAD` 对应提交的哈希值

### 撤销

```shell
git reset --hard HEAD #撤销工作目录中所有未提交文件的修改内容
git checkout HEAD <file> #撤销指定的未提交文件的修改内容
git revert <commit> #撤销指定的提交
```

### 分支和标签

```shell
git branch #显示所有本地分支
git checkout <branch/tag> #切换到指定分支或标签
git branch <new-branch> #创建新分支
git branch -d <branch> #删除本地分支
git tag #列出所有本地标签
git tag <tagname>  #基于最新提交创建标签
git tag -d <tagname>  #删除标签(本地)
git push origin :refs/tags/v1.0.0 # 删除远程库的指定 tag
git push origin --tags #提交所有标签到 origin 远程库
```

### 合并与衍合

```shell
git merge <branch_name> # 合并指定分支到当前分支
git rebase <branch_name>  # 衍合指定分支到当前分支
```

> 解决合并的冲突:
> 先 `git status` 查看一下冲突的文件,然后修改内容 `git add+commit` 提交,最好 `git push` 并删除分支.

### tag 标签

```shell
git tag -a <tag_name> -m "<tag_comments>" # 添加一个 <tag_name> 的标签
git show <tag_name>  # 显示 <tag_name> 的信息
git push origin <tag_name> # 将标签推送到远程
```

### 版本回退

```shell
git reset --hard HEAD # 回退到指定的版本号-可以用 git log 查看
git push -f -u origin master # 强制提交到 master 分支（具体哪个分支请酌情修改）
```

> 远程库可能会禁止某保护分钟强制提交，需要先关闭保护，例如在 gitlab 中需要在设置中去除分支的保护才可强制提交

## 常见问题

### 换行符问题解决

以下命令在 Git Bash 中执行即可

- 场景一、代码在 window 提交，在 windows 使用（即默认场景）
  ```shell
  git config --global core.autocrlf true
  ```
- 场景二、代码在 windows 提交，在 Linux 或者 Mac 系统或者 Jenkins 上专门打包为服务器使用，无需 Git 在 pull 时进行自动转换；（即 Git 在 push 时把 CRLF 转换成 LF，pull 时不转换）
  ```shell
  git config --global core.autocrlf input
  ```
- 场景三、不想要 Git 自动转换：
  ```shell
  git config --global core.autocrlf false
  ```
