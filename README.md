# VSConfigManager

#### Other Language [中文(简体)](README_ZH.md) [中文(繁體)](README_TW.md)

## Introduction
##### A workspace folder manager for Visual Studio Code based on [Powershell](https://github.com/PowerShell/PowerShell) 脚本的 [Visual Studio Code](https://github.com/microsoft/vscode) scripts
##### This project lets you use simple commands in the [VSCode integrated terminal](https://code.visualstudio.com/docs/terminal/basics) to quickly manipulate workspace files (for example: [launch.json](https://code.visualstudio.com/docs/debugtest/debugging)).

## Installation
##### Fully [clone](https://docs.github.com/en/repositories/creating-and-managing-repositories/cloning-a-repository) this project repository,
##### then run this file:
```bash
.\install.ps1
```

## Commands

### ```vscode.pull``` (7 overloads)

- #### Basic Usage  
```cpp
vscode.pull
```  
##### Copy the contents of `configuration directory\Default` into `.vscode` in the current directory.

- #### Specify `backup folder name`  
```cpp
vscode.pull <string>  // vscode.pull my_workspace_1
```  
##### Copy the contents of `configuration directory\string` into `.vscode` in the current directory.

- #### Specify `backup folder path`  
```cpp
vscode.pull <path>  // vscode.pull "C:\Users\Adminstrator\.vscode\config\my_workspace_1\"
```  
##### Copy the contents of `path` into `.vscode` in the current directory.

- #### Specify `backup folder name`, `target folder name`  
```cpp
vscode.pull <string> <string2>  // vscode.pull my_workspace_1 my_workspace_backup
```  
##### Copy the contents of `configuration directory\string` into `configuration directory\string2`.

- #### Specify `backup folder path`, `target folder name`  
```cpp
vscode.pull <path> <string>  // vscode.pull C:\Users\Adminstrator\.vscode\config\my_workspace_1\ my_workspace_backup
```  
##### Copy the contents of `path` into `configuration directory\string`.

- #### Specify `backup folder path`, `target folder path`  
```cpp
vscode.pull <path> <path2>  // vscode.pull "C:\Users\Adminstrator\.vscode\config\my_workspace_1\" "C:\Users\Adminstrator\.vscode\config\my_workspace_backup\"
```  
##### Copy the contents of `path` into `path2`.

- #### Specify `backup folder name`, `target folder path`  
```cpp
vscode.pull <string> <path>  // vscode.pull "C:\Users\Adminstrator\.vscode\config\my_workspace_1\" "C:\Users\Adminstrator\.vscode\config\my_workspace_backup\"
```  
##### Copy the contents of `configuration directory\string` into `path`.

---

### ```vscode.push``` (7 overloads)

- #### Basic Usage  
```cpp
vscode.push
```  
##### Copy the contents of `.vscode` in the current directory into `configuration directory\Default`.

- #### Specify `backup folder name`  
```cpp
vscode.push <string>  // vscode.push my_workspace_1
```  
##### Copy the contents of `.vscode` in the current directory into `configuration directory\string`.

- #### Specify `backup folder path`  
```cpp
vscode.push <path>  // vscode.push "C:\Users\Adminstrator\.vscode\config\my_workspace_1\"
```  
##### Copy the contents of `.vscode` in the current directory into `path`.

- #### Specify `backup folder name`, `target folder name`  
```cpp
vscode.push <string> <string2>  // vscode.push my_workspace_1 my_workspace_backup
```  
##### Copy the contents of `configuration directory\string` into `configuration directory\string2`.

- #### Specify `backup folder path`, `target folder name`  
```cpp
vscode.push <path> <string>  // vscode.push C:\Users\Adminstrator\.vscode\config\my_workspace_1\ my_workspace_backup
```  
##### Copy the contents of `path` into `configuration directory\string`.

- #### Specify `backup folder path`, `target folder path`  
```cpp
vscode.push <path> <path2>  // vscode.push "C:\Users\Adminstrator\.vscode\config\my_workspace_1\" "C:\Users\Adminstrator\.vscode\config\my_workspace_backup\"
```  
##### Copy the contents of `path` into `path2`.

- #### Specify `backup folder name`, `target folder path`  
```cpp
vscode.push <string> <path>  // vscode.push "C:\Users\Adminstrator\.vscode\config\my_workspace_1\" "C:\Users\Adminstrator\.vscode\config\my_workspace_backup\"
```  
##### Copy the contents of `configuration directory\string` into `path`.

---

### ```vscode.clone```  
#### Works like [```vscode.pull```](#vscodepull-7-overloads) but deletes all contents at the target path before copying.

---

### ```vscode.replace```  
#### Works like [```vscode.push```](#vscodepush-7-overloads) but deletes all contents at the target path before copying.

---

### ```vscode.delete``` (2 overloads)

- #### Basic Usage  
```cpp
vscode.delete <string>  // vscode.delete my_workspace_backup
```  
##### Deletes `configuration directory\string`.

- #### Specify `backup folder path`  
```cpp
vscode.delete <path>  // vscode.delete "C:\Users\Adminstrator\.vscode\config\my_workspace_backup\"
```  
##### Deletes `path`.

---

### ```vscode.new``` (2 overloads)

- #### Basic Usage  
```cpp
vscode.new <string>  // vscode.new my_workspace_1
```  
##### Creates a new backup folder `configuration directory\string`.

- #### Specify `backup folder path`  
```cpp
vscode.new <path>  // vscode.new "C:\Users\Adminstrator\.vscode\config\my_workspace_1\"
```  
##### Creates a new backup folder `path`.

---

## Special Commands

### ```vscode``` (4 overloads)

- #### Basic Usage  
```cpp
vscode
```  
##### Opens Visual Studio Code.

- #### One Argument  
```cpp
vscode <string>  // vscode pull = vscode.pull
```  
##### Invokes vscode.\<string\> command.

- #### Two Arguments  
```cpp
vscode <string> <string2>  // vscode pull my_workspace_1 = vscode.pull my_workspace_1
```  
##### Invokes vscode.\<string\> \<string2\> command.

- #### Three Arguments  
```cpp
vscode <string> <string2> <string3>  // vscode pull my_workspace_1 my_workspace_backup = vscode.pull my_workspace_1 my_workspace_backup
```  
##### Invokes vscode.\<string\> \<string2\> \<string3\> command.
