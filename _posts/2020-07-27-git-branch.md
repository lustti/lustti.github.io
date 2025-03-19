# 分支模型规范
> 本分支模型主要参考了[ Vincent Driessen 博文 ](https://nvie.com/posts/a-successful-git-branching-model/).

- [主分支](#主分支)
- [辅助分支](#辅助分支)
  - [feature 分支](#feature-分支)
  - [Release 分支](#release-分支)
- [Hotfix 分支](#hotfix-分支)
- [额外分支](#额外分支)

![分支模型](/assets/imgs/posts/2020-07-27-git-branch/git-model@2x.png)

## 主分支
中心仓库保有两条拥有永久生命周期的主分支:
- master
- develop

![主分支](/assets/imgs/posts/2020-07-27-git-branch/main-branches@2x.png)

两条主分支并行存在于整个项目周期, 
- master 分支反映了项目产品稳定版本的变化状态. 
- develop 分支则是反映了各个 release 版本的开发变化. 所以 develop 分支也称为"整合分支", 与辅助分支交互合并, 记录开发过程. 其中当 develop 分支到达了一个稳定的版本时, 就会合并回 master 分支, 同时打上 release 编码, 也就是对应的内部版本号.

## 辅助分支
### feature 分支

- 功能分支一般创建来自于 develop 分支, 
- 完成开发后必须合并回 develop 分支. 
- 分支命名除了 master, develop, release-*, 或 hotfix-* 以外都是可以的, 尽量采用与所开发功能对应的英文单词, 尽量不用缩写.

![功能分支](/assets/imgs/posts/2020-07-27-git-branch/feature-branches@2x.png)

从 develop 分支创建功能分支:
```
$ git checkout -b myfeature develop
Switched to a new branch "myfeature"
```

完成开发, 以及必要的测试后, 合并回 develop 分支, 并删除功能分支:
```
$ git checkout develop
Switched to branch 'develop'
$ git merge --no-ff myfeature
Updating ea1b82a..05e9557
(Summary of changes)
$ git branch -d myfeature
Deleted branch myfeature (was 05e9557).
$ git push origin develop
```
> PS: 功能分支内的历史一般不合并到develop分支中, 所以基本都要带上 `--no-ff` flag 来省去, 具体功能见下图.<br>
![no-ff-merge](/assets/imgs/posts/2020-07-27-git-branch/merge-without-ff@2x.png)

### Release 分支

- 功能分支一般创建来自于 develop 分支, 
- 合并回 develop 和 master 分支. 
- 分支命名采用 release-*, * 为对应的 release 编码, 也就是内部版本号.

![release 分支](/assets/imgs/posts/2020-07-27-git-branch/release-branches@2x.jpg)

从 develop 分支创建 release 分支:
```
$ git checkout -b release-1.2 develop
Switched to a new branch "release-1.2"
$ ./bump-version.sh 1.2
Files modified successfully, version bumped to 1.2.
$ git commit -a -m "Bumped version number to 1.2"
[release-1.2 74d9424] Bumped version number to 1.2
1 files changed, 1 insertions(+), 1 deletions(-)
```
> PS: 这里的 bump-version.sh 是修改对应版本信息文件的脚本.


合并到 master 分支, 并打上版本信息 tag :
```
$ git checkout master
Switched to branch 'master'
$ git merge --no-ff release-1.2
Merge made by recursive.
(Summary of changes)
$ git tag -a 1.2
```

合并到 develop 分支:
```
$ git checkout develop
Switched to branch 'develop'
$ git merge --no-ff release-1.2
Merge made by recursive.
(Summary of changes)
```

如果该 release 没必要存在, 则进行删除:
```
$ git branch -d release-1.2
Deleted branch release-1.2 (was ff452fe).
```

## Hotfix 分支

hotfix 分支用于修复上线产品比较严重的bug.
- hotfix 分支一般创建来自于 master 分支, 
- 合并回 develop 和 master 分支. 
- 分支命名采用 hotfix-*, * 为对应的内部版本号.

![hotfix 分支](/assets/imgs/posts/2020-07-27-git-branch/hotfix-branches@2x.png)

从 master 分支创建 hotfix 分支:
```
$ git checkout -b hotfix-1.2.1 master
Switched to a new branch "hotfix-1.2.1"
$ ./bump-version.sh 1.2.1
Files modified successfully, version bumped to 1.2.1.
$ git commit -a -m "Bumped version number to 1.2.1"
[hotfix-1.2.1 41e61bb] Bumped version number to 1.2.1
1 files changed, 1 insertions(+), 1 deletions(-)
```

问题修复后进行提交:
```
$ git commit -m "Fixed severe production problem"
[hotfix-1.2.1 abbe5d6] Fixed severe production problem
5 files changed, 32 insertions(+), 17 deletions(-)
```

合并到 master 分支, 并打上版本信息 tag :
```
$ git checkout master
Switched to branch 'master'
$ git merge --no-ff hotfix-1.2.1
Merge made by recursive.
(Summary of changes)
$ git tag -a 1.2.1
```

合并到 develop 分支:
```
$ git checkout develop
Switched to branch 'develop'
$ git merge --no-ff hotfix-1.2.1
Merge made by recursive.
(Summary of changes)
```

删除 hotfix 分支:
```
$ git branch -d hotfix-1.2.1
Deleted branch hotfix-1.2.1 (was abbe5d6).
```

## 额外分支
本项目的仓库会有两个长期的额外分支：
- **demo**: 用于维护项目相关模块开发预研的程序demo
- **doc**: 用于维护项目相关的文档

**demo** 分支规范：
- 一次提交只能提交某一个demo的相关内容
- demo之间尽量保持独立性互不依赖
- 如有必要demo下的添加README文档对demo进行简单介绍
- 所有demo必须要放在demos文件夹内

**doc** 分支规范：
- 一次提交只能提交某一个文档的相关内容
- 添加系列文档可以新建文件夹，并在该文件夹下添加README文件介绍该**系列文档的内容**，以及其下各个文档**简短说明及文件链接**
- 所有文档必须要放在doc文件夹内