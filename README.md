# README

## About

- 本仓库用来进行一个OS实验项目，chive团队成员均可以参加进来（创建个人分支即可，该项目不进行分支合并）。
- 项目将从零开始一点点构建，直至实现一个x86架构的内核，并为其增添、完善，参与者将从开发过程中深入理解操作系统的知识。
- 项目代码将参考《自己动手写操作系统》。
- 环境：windows + Bochs + NASM，或 Ubuntu 18 + qemu + NASM

## Updates

- 20200309:上传了测试环境用的/chapter1目录。
- 20200313:上传了启动保护模式实验的/chapter2目录，增加了/lab目录和/references目录。
  - /chapter2目录较原书代码修改了一些内容：
    - 在pm.inc中添加了一个PAD宏，用于计算出NASM下的section在自动对齐后增加的字节，以便生成512字节的引导区文件。
    - 参考ucore添加了对A20 Gate状态的判断，防止A20在忙状态时执行写入命令。
    - 修改了一些结构的命名，如Descriptor修改为DESC，辨识度高，使用更方便。
    - 在boot.asm末尾添加了使镜像符合引导区文件格式的代码。
    - 修改了/chapter2下的makefile，增加了`make debug`指令，运行起来后在gdb下使用`target remote ip:1234`进行远程调试。（此修改未测试）
  - 添加了目录/lab，用于在Windows下使用bochs对镜像进行调试。
    - 使用方法为，安装Bochs，配置环境变量，使用编译出的镜像替换/lab下的`a.img`，运行`run.bat`（或手动删除硬盘镜像的lock文件`hd10meg.img.lock`，直接运行`bochsrc.bxrc`）。
  - /references目录用于存放查询参考等学习性质的文件，目前有NASM官方文档、中文手册、《自己动手写操作系统》。
