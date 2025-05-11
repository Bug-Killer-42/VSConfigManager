# VSConfigManager

#### 其他语言 [English](README.md) [中文(繁体)](README_TW.md)


## 简介
##### 基于 [Powershell](https://github.com/PowerShell/PowerShell) 脚本的 [Visual Studio Code](https://github.com/microsoft/vscode) 工作区文件夹 ([.vscode](https://code.visualstudio.com/docs/configure/settings)) 管理器
##### 此项目可以在 [VSCode内置命令行](https://code.visualstudio.com/docs/terminal/basics) 中使用**简单的命令**快速操作工作区文件 (例如: [launch.json](https://code.visualstudio.com/docs/debugtest/debugging)) 。


## 安装
##### 完整 [克隆](https://docs.github.com/en/repositories/creating-and-managing-repositories/cloning-a-repository) 本项目文件夹，
##### 运行此文件: 
```bash
.\install.ps1
```


## 命令


### ```vscode.pull``` (7 个重载)


- #### 基础用法
```cpp
vscode.pull
```
##### 把 ```配置文件目录\Default``` 的内容复制到 ```当前目录\.vscode``` 。


- #### 指定 ```备份文件夹名称```
```cpp
vscode.pull <string> // vscode.pull my_workspace_1
```
##### 把 ```配置文件目录\string``` 的内容复制到 ```当前目录\.vscode``` 。


- #### 指定```备份文件夹路径```
```cpp
vscode.pull <path> // vscode.pull "C:\Users\Adminstrator\.vscode\config\my_workspace_1\" 
```
##### 把 ```path``` 的内容复制到 ```当前目录\.vscode``` 。


- #### 指定 ```备份文件夹名称``` , ```目标文件夹名称```
```cpp
vscode.pull <string> <string2> // vscode.pull my_workspace_1 my_workspace_backup
```
##### 把 ```配置文件目录\string``` 的内容复制到 ```配置文件目录\string2``` 。


- #### 指定 ```备份文件夹路径``` , ```目标文件夹名称```
```cpp
vscode.pull <path> <string> // vscode.pull C:\Users\Adminstrator\.vscode\config\my_workspace_1\ my_workspace_backup
```
##### 把 ```path``` 的内容复制到 ```配置文件目录\string``` 。


- #### 指定 ```备份文件夹路径``` , ```目标文件夹路径```
```cpp
vscode.pull <path> <path2> // vscode.pull "C:\Users\Adminstrator\.vscode\config\my_workspace_1\" "C:\Users\Adminstrator\.vscode\config\my_workspace_backup\"
```
##### 把 ```path``` 的内容复制到 ```path2``` 。


- #### 指定 ```备份文件夹名称``` , ```目标文件夹路径```
```cpp
vscode.pull <string> <path> // vscode.pull "C:\Users\Adminstrator\.vscode\config\my_workspace_1\" "C:\Users\Adminstrator\.vscode\config\my_workspace_backup\"
```
##### 把 ```配置文件目录\string``` 的内容复制到 ```path``` 。

---


### ```vscode.push``` (7 个重载)


- #### 基础用法
```cpp
vscode.push 
```
##### 把 ```当前目录\.vscode``` 的内容复制到 ```配置文件目录\Default``` 。


- #### 指定 ```备份文件夹名称```
```cpp
vscode.push <string> // vscode.push my_workspace_1
```
##### 把 ```当前目录\.vscode``` 的内容复制到 ```配置文件目录\string``` 。


- #### 指定 ```备份文件夹路径```
```cpp
vscode.push <path> // vscode.push "C:\Users\Adminstrator\.vscode\config\my_workspace_1\" 
```
##### 把 ```当前目录\.vscode``` 的内容复制到 ```path``` 。


- #### 指定 ```备份文件夹名称``` , ```目标文件夹名称```
```cpp
vscode.push <string> <string2> // vscode.push my_workspace_1 my_workspace_backup
```
##### 把 ```配置文件目录\string``` 的内容复制到 ```配置文件目录\string2``` 。


- #### 指定 ```备份文件夹路径``` , ```目标文件夹名称```
```cpp
vscode.push <path> <string> // vscode.push C:\Users\Adminstrator\.vscode\config\my_workspace_1\ my_workspace_backup
```
##### 把 ```path``` 的内容复制到 ```配置文件目录\string``` 。


- #### 指定 ```备份文件夹路径``` , ```目标文件夹路径```
```cpp
vscode.push <path> <path2> // vscode.push "C:\Users\Adminstrator\.vscode\config\my_workspace_1\" "C:\Users\Adminstrator\.vscode\config\my_workspace_backup\"
```
##### 把 ```path``` 的内容复制到 ```path2``` 。


- #### 指定 ```备份文件夹名称``` , ```目标文件夹路径```
```cpp
vscode.push <string> <path> // vscode.push "C:\Users\Adminstrator\.vscode\config\my_workspace_1\" "C:\Users\Adminstrator\.vscode\config\my_workspace_backup\"
```
##### 把 ```配置文件目录\string``` 的内容复制到 ```path``` 。

---


### ```vscode.clone``` 
#### 与 [```vscode.pull```](#vscodepull-7-个重载) 逻辑相同，但复制前会先删除目标路径所有内容。

---
### ```vscode.replace```
#### 与 [```vscode.push```](#vscodepush-7-个重载) 逻辑相同，但复制前会先删除目标路径所有内容。
---
### ```vscode.delete``` (2 个重载)
- #### 基础用法
```cpp
vscode.delete <string> // vscode.delete my_workspace_backup
```
##### 把 ```配置文件目录\string``` 删除。
- #### 指定 ```备份文件夹路径```
```cpp
vscode.delete <path> // vscode.delete "C:\Users\Adminstrator\.vscode\config\my_workspace_backup\"
```
##### 把 ```path``` 删除。
---
### ```vscode.new``` (2 个重载)
- #### 基础用法
```cpp
vscode.new <string> // vscode.new my_workspace_1
```
##### 创建一个新备份文件夹 ```配置文件目录\string``` 。
- #### 指定 ```备份文件夹路径```
```cpp
vscode.new <path> // vscode.new "C:\Users\Adminstrator\.vscode\config\my_workspace_1\"
```
##### 创建一个新备份文件夹 ```path``` 。
---
## 特殊命令
### ```vscode``` (4 个重载)
- #### 基础用法
```cpp
vscode
```
##### 打开Visual Studio Code软件。
- #### 指定 ```1个参数```
```cpp
vscode <string> // vscode pull = vscode.pull
```
##### 调用vscode.\<string\> 命令。

- #### 指定 ```2个参数```
```cpp
vscode <string> <string2> // vscode pull my_workspace_1 = vscode.pull my_workspace_1
```
##### 调用vscode.\<string\> \<string2\> 命令。

- #### 指定 ```3个参数```
```cpp
vscode <string> <string2> <string3> // vscode pull my_workspace_1 my_workspace_backup = vscode.pull my_workspace_1 my_workspace_backup
```
##### 调用vscode.\<string\> \<string2\> \<string3\> 命令。

