# Centos7 英伟达显卡驱动和CUDA的安装
- 显卡： GeForce GTX 1050
- kernel-release: 3.10.0-1127.el7.x86_64
- 驱动：Linux x64 (AMD64/EM64T) Display Driver [Version 440.100](https://cn.download.nvidia.com/XFree86/Linux-x86_64/440.100/NVIDIA-Linux-x86_64-440.100.run).
- CUDA: [Version 10.2](http://developer.download.nvidia.com/compute/cuda/10.2/Prod/local_installers/cuda_10.2.89_440.33.01_linux.run)

Results: 
```
+-----------------------------------------------------------------------------+
| NVIDIA-SMI 440.100      Driver Version: 440.100      CUDA Version: 10.2     |
|-------------------------------+----------------------+----------------------+
| GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
| Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
|===============================+======================+======================|
|   0  GeForce GTX 1050    Off  | 00000000:01:00.0 Off |                  N/A |
| N/A   44C    P8    N/A /  N/A |      0MiB /  2002MiB |      0%      Default |
+-------------------------------+----------------------+----------------------+
```

## 前期准备
### 安装依赖
要装的三个依赖分别是，gcc、kernel-devel、dkms，其中需要注意的是，kernel-devel的版本需要与当前内核的版本一致，不然后面会出现找不到文件的情况。

查看我的内核版本：
```sh
$ sudo uname -r
3.10.0-1127.el7.x86_64
```
查看一下可以安装的版本：

[root@host8 ~]# yum list | grep kernel-devel
kernel-devel.x86_64                     3.10.0-957.1.3.el7             updates

安装rpm包后，继续安装其他依赖：

yum -y install gcc dkms



###  查询驱动版本
1. 首先导入公共密钥<br>
    `$ sudo rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org`
2. 安装ELRepo

    [具体点击详情](http://elrepo.org/tiki/tiki-index.php)
    ```
    $ sudo rpm -Uvh http://www.elrepo.org/elrepo-release-7.0-2.el7.elrepo.noarch.rpm
    ```
3. 安装 nvidia-detect `$ sudo yum install nvidia-detect`

4. 运行 nvidia-detect
    ```
    $ sudo nvidia-detect -v
    Probing for supported NVIDIA devices...
    [10de:1c8d] NVIDIA Corporation GP107M [GeForce GTX 1050 Mobile]
    This device requires the current 440.64 NVIDIA driver kmod-nvidia
    [8086:591b] Intel Corporation HD Graphics 630
    An Intel display controller was also detected
    ```

根据 nvidia-detect 的输出信息，可以知道显卡的型号，以及要使用的驱动版本 440.64。到官网下载最接近的驱动版本，这里下载  [Version 440.100](https://cn.download.nvidia.com/XFree86/Linux-x86_64/440.100/NVIDIA-Linux-x86_64-440.100.run).

> PS：通过命令 `$ sudo yum search kmod-nvidia` 可以查找源中有的驱动，但是还是官网下载好一点，至少安装包都有。

## 安装驱动
> refer to [INSTALLING NVIDIA DRIVERS ON RHEL OR CENTOS 7](https://www.advancedclustering.com/act_kb/installing-nvidia-drivers-rhel-centos-7/)

Most users of NVIDIA graphics cards prefer to use the drivers provided by NVIDIA. These more fully support the capabilities of the card when compared to the nouveau driver that is included with the distribution. These are the steps to install the NVIDIA driver and disable the nouveau driver.

**Prepare your machine**

```sh
yum -y update
yum -y groupinstall "GNOME Desktop" "Development Tools"
yum -y install kernel-devel
```

Download the latest NVIDIA driver for unix.
==> http://www.nvidia.com/object/unix.html ==> Latest Long Lived Branch version
Note: If using a recently released, top end GTX or Tesla you may get more support with the Latest Short Lived Branch instead.

In order to have the NVIDIA drivers rebuilt automatically with future kernel updates you can also install the EPEL repository and the DKMS package. This is optional.

```
yum -y install epel-release
yum -y install dkms
```
**Reboot your machine to make sure you are running the newest kernel**

Edit `/etc/default/grub`. Append the following  to `“GRUB_CMDLINE_LINUX”`
`rd.driver.blacklist=nouveau nouveau.modeset=0`

Generate a new grub configuration to include the above changes.
`grub2-mkconfig -o /boot/grub2/grub.cfg`

Edit/create `/etc/modprobe.d/blacklist.conf` and append:
`blacklist nouveau`

Backup your old initramfs and then build a new one
```
mv /boot/initramfs-$(uname -r).img /boot/initramfs-$(uname -r)-nouveau.img
dracut /boot/initramfs-$(uname -r).img $(uname -r)
```
**Reboot your machine**

If your machine doesn’t boot to a login prompt disconnect your monitor from the graphics card and plug directly into the onboard VGA port. Alternatively SSH directly into the machine.

The NVIDIA installer will not run while X is running so switch to text mode:
`systemctl isolate multi-user.target`

Run the NVIDIA driver installer and enter yes to all options.
`sh NVIDIA-Linux-x86_64-*.run`

**Reboot your machine**

## Solve can't launch `nvidia-setting' for X server.

```sh
$ nvidia-setting
ERROR: Unable to load info from any available system
```
**Solution**:
1. Create /etc/X11/xorg.conf.d/11-nvidia.conf with contents
    ```sh
    Section "OutputClass"
    Identifier "nvidia"
    MatchDriver "nvidia-drm"
    Driver "nvidia"
    Option "AllowEmptyInitialConfiguration" "true"
    Option "PrimaryGPU" "true"
    EndSection
    ```
2. and for GDM/Gnome, create two files `optimus.desktop` in `/etc/xdg/autostart/` and `/usr/share/gdm/greeter/autostart/` containing
    ```sh
    [Desktop Entry]
    Type=Application
    Name=Optimus
    Exec=sh -c "xrandr --setprovideroutputsource modesetting NVIDIA-0; xrandr --auto"
    NoDisplay=true
    X-GNOME-Autostart-Phase=DisplayServer
    ```

## CUDA 安装
Download the latest CUDA Toolkit (runfile installer option, not the rpm download)
==> https://developer.nvidia.com/cuda-downloads ==> Linux ==> x86_64 ==> RHEL/CentOS ==> 7 ==> runfile (local)

Run the CUDA installer.
`sh cuda_*.run`

> **Say no to installing the NVIDIA driver**. The standalone driver you already installed is typically newer than what is packaged with CUDA. Use the default option for all other choices.

To add CUDA to your environment add the following files.

Create `/etc/profile.d/cuda.sh`
```
PATH=$PATH:/usr/local/cuda/bin
export PATH
```

Create `/etc/profile.d/cuda.csh`
```
set path = ( $path /usr/local/cuda/bin )
```

Create `/etc/ld.so.conf.d/cuda.conf`
```
/usr/local/cuda/lib64
```

## cudnn 安装
到官网下载对应安装包，然后按以下顺序安装：
- **runtime library**: `$ sudo rpm -i libcudnn7-7.6.5.33-1.cuda10.2.x86_64.rpm `
- **develop library**: `$ sudo rpm -i libcudnn7-devel-7.6.5.33-1.cuda10.2.x86_64.rpm`
- **doc and code samples**: `$ sudo rpm -i libcudnn7-doc-7.6.5.33-1.cuda10.2.x86_64.rpm`