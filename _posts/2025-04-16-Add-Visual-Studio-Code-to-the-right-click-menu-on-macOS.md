---
title: 添加VS Code 到 macOS 右键菜单
description: 添加VS Code 到 macOS 右键菜单，用于方便快捷打开项目文件夹或文件.
author: lustti
date: 2020-06-06 11:33:00 +0800
categories: [Linux, Common]
tags: [Linux]
pin: false
---


在 macOS 系统里，你可以借助 Automator 应用程序把 Visual Studio Code 添加到右键菜单。以下是具体步骤：

1. **打开 Automator**：你可以通过在启动盘（Launchpad）中输入 “Automator” 来打开它。
   ![step 0](/assets/imgs/posts/2025-04-16-Add-Visual-Studio-Code-to-the-right-click-menu-on-macOS/OpenVSCode-0.png)
2. **创建新的快速操作**：启动 Automator 后，选择 “快速操作” 模板，然后点击 “选取”。
   ![step 0](/assets/imgs/posts/2025-04-16-Add-Visual-Studio-Code-to-the-right-click-menu-on-macOS/OpenVSCode-00.png)
3. **设置快速操作参数**：在窗口的右上角，将 “工作流程收到当前” 设置为 “文件或文件夹”，“位于” 设置为 “Finder.app”。
4. **添加运行 Shell 脚本操作**：在左侧的操作列表中，找到 “实用工具” 类别，然后将 “运行 Shell 脚本” 操作拖到右侧的工作流程区域。
  ![step 1](/assets/imgs/posts/2025-04-16-Add-Visual-Studio-Code-to-the-right-click-menu-on-macOS/OpenVSCode-01.png)

1. **编写 Shell 脚本**：在 “运行 Shell 脚本” 操作中，确保 “shell” 设置为 “/bin/zsh”，“传递输入” 设置为 “作为自变量”。接着在脚本框中输入以下命令：

    ```shell
    open -a "Visual Studio Code" "$@"
    ```

2. **保存快速操作**：点击菜单栏中的 “文件” -> “保存”，为快速操作命名，例如 “Open VSCode”。
3. **使用快速操作**：现在，当你在 Finder 中右键点击文件或文件夹时，就能在 “Qucik Action” 菜单里看到 “Open VSCode” 选项了。
    ![step 2](/assets/imgs/posts/2025-04-16-Add-Visual-Studio-Code-to-the-right-click-menu-on-macOS/OpenVSCode-02.png)

通过以上步骤，你就可以把 Visual Studio Code 添加到 macOS 的右键菜单中，方便快速打开文件或文件夹。

## 添加快捷键

可以为Mac上右键菜单中的VS Code添加快捷键，以下是具体步骤：

1. **打开系统键盘设置**：通过“Command + 空格”调出聚焦搜索，输入“键盘”，进入系统设置里的键盘设置。
2. **选择服务快捷键**：在键盘设置窗口中，选择“键盘快捷键”选项卡，然后在左侧依次选择“服务”→“文件和文件夹”。
3. **添加快捷键**：找到之前添加的“Open VSCode”（如果之前保存的快速操作是其他命名，就选择对应的名称），双击右侧空白处（显示“无”），输入你想要设置的快捷键，比如“Ctrl + Alt + V”。注意不要与其他快捷键冲突，设置完成后点击“完成”即可。
   ![step 3](/assets/imgs/posts/2025-04-16-Add-Visual-Studio-Code-to-the-right-click-menu-on-macOS/OpenVSCode-03.png)

这样设置后，在访达中选中文件或文件夹，按下设置好的快捷键，就可以直接用VS Code打开了。
