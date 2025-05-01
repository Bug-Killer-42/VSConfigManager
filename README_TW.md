# VSConfigManager

#### 其他語言 [English](README.md) [中文(简体)](README_ZH.md)

## 簡介
##### 基於 [Powershell](https://github.com/PowerShell/PowerShell) 腳本的 [Visual Studio Code](https://github.com/microsoft/vscode) 工作區資料夾 ([.vscode](https://code.visualstudio.com/docs/configure/settings)) 管理器
##### 此專案可在 [VSCode 內建命令列](https://code.visualstudio.com/docs/terminal/basics) 中使用``簡單的命令``快速操作工作區檔案 (例如: [launch.json](https://code.visualstudio.com/docs/debugtest/debugging)) 。

## 安裝
##### 完整 [克隆](https://docs.github.com/en/repositories/creating-and-managing-repositories/cloning-a-repository) 本專案資料夾，
##### 執行此檔案: 
```bash
.\setup.ps1
```

## 命令

### ```vscode.pull``` (7 個重載)

- #### 基本用法
```cpp
vscode.pull
```
##### 把 `備份資料夾\Default` 的內容複製到 `當前目錄\.vscode` 。

- #### 指定 `備份資料夾名稱`
```cpp
vscode.pull <string>  // vscode.pull my_workspace_1
```
##### 把 `備份資料夾\string` 的內容複製到 `當前目錄\.vscode` 。

- #### 指定 `備份資料夾路徑`
```cpp
vscode.pull <path>  // vscode.pull "C:\Users\Adminstrator\.vscode\config\my_workspace_1\"
```
##### 把 `path` 的內容複製到 `當前目錄\.vscode` 。

- #### 指定 `備份資料夾名稱`、`目標資料夾名稱`
```cpp
vscode.pull <string> <string2>  // vscode.pull my_workspace_1 my_workspace_backup
```
##### 把 `備份資料夾\string` 的內容複製到 `備份資料夾\string2` 。

- #### 指定 `備份資料夾路徑`、`目標資料夾名稱`
```cpp
vscode.pull <path> <string>  // vscode.pull C:\Users\Adminstrator\.vscode\config\my_workspace_1\ my_workspace_backup
```
##### 把 `path` 的內容複製到 `備份資料夾\string` 。

- #### 指定 `備份資料夾路徑`、`目標資料夾路徑`
```cpp
vscode.pull <path> <path2>  // vscode.pull "C:\Users\Adminstrator\.vscode\config\my_workspace_1\" "C:\Users\Adminstrator\.vscode\config\my_workspace_backup\"
```
##### 把 `path` 的內容複製到 `path2` 。

- #### 指定 `備份資料夾名稱`、`目標資料夾路徑`
```cpp
vscode.pull <string> <path>  // vscode.pull "C:\Users\Adminstrator\.vscode\config\my_workspace_1\" "C:\Users\Adminstrator\.vscode\config\my_workspace_backup\"
```
##### 把 `備份資料夾\string` 的內容複製到 `path` 。

---

### ```vscode.push``` (7 個重載)

- #### 基本用法
```cpp
vscode.push
```
##### 把 `當前目錄\.vscode` 的內容複製到 `備份資料夾\Default` 。

- #### 指定 `備份資料夾名稱`
```cpp
vscode.push <string>  // vscode.push my_workspace_1
```
##### 把 `當前目錄\.vscode` 的內容複製到 `備份資料夾\string` 。

- #### 指定 `備份資料夾路徑`
```cpp
vscode.push <path>  // vscode.push "C:\Users\Adminstrator\.vscode\config\my_workspace_1\"
```
##### 把 `當前目錄\.vscode` 的內容複製到 `path` 。

- #### 指定 `備份資料夾名稱`、`目標資料夾名稱`
```cpp
vscode.push <string> <string2>  // vscode.push my_workspace_1 my_workspace_backup
```
##### 把 `備份資料夾\string` 的內容複製到 `備份資料夾\string2` 。

- #### 指定 `備份資料夾路徑`、`目標資料夾名稱`
```cpp
vscode.push <path> <string>  // vscode.push C:\Users\Adminstrator\.vscode\config\my_workspace_1\ my_workspace_backup
```
##### 把 `path` 的內容複製到 `備份資料夾\string` 。

- #### 指定 `備份資料夾路徑`、`目標資料夾路徑`
```cpp
vscode.push <path> <path2>  // vscode.push "C:\Users\Adminstrator\.vscode\config\my_workspace_1\" "C:\Users\Adminstrator\.vscode\config\my_workspace_backup\"
```
##### 把 `path` 的內容複製到 `path2` 。

- #### 指定 `備份資料夾名稱`、`目標資料夾路徑`
```cpp
vscode.push <string> <path>  // vscode.push "C:\Users\Adminstrator\.vscode\config\my_workspace_1\" "C:\Users\Adminstrator\.vscode\config\my_workspace_backup\"
```
##### 把 `備份資料夾\string` 的內容複製到 `path` 。

---

### ```vscode.clone```  
#### 與 ```vscode.pull``` (7 個重載) 邏輯相同，但複製前會先刪除目標路徑所有內容。

---

### ```vscode.replace```  
#### 與 ```vscode.push``` (7 個重載) 邏輯相同，但複製前會先刪除目標路徑所有內容。

---

### ```vscode.delete``` (2 個重載)

- #### 基本用法
```cpp
vscode.delete <string>  // vscode.delete my_workspace_backup
```
##### 刪除 `備份資料夾\string` 。

- #### 指定 `備份資料夾路徑`
```cpp
vscode.delete <path>  // vscode.delete "C:\Users\Adminstrator\.vscode\config\my_workspace_backup\"
```
##### 刪除 `path` 。

---

### ```vscode.new``` (2 個重載)

- #### 基本用法
```cpp
vscode.new <string>  // vscode.new my_workspace_1
```
##### 建立一個新的備份資料夾 `備份資料夾\string` 。

- #### 指定 `備份資料夾路徑`
```cpp
vscode.new <path>  // vscode.new "C:\Users\Adminstrator\.vscode\config\my_workspace_1\"
```
##### 建立一個新的備份資料夾 `path` 。

---

## 特殊命令

### ```vscode``` (4 個重載)

- #### 基本用法
```cpp
vscode
```
##### 開啟 Visual Studio Code 軟體。

- #### 指定 ```1 個參數```
```cpp
vscode <string>  // vscode pull = vscode.pull
```
##### 使用 vscode.\<string\> 命令。

- #### 指定 ```2 個參數```
```cpp
vscode <string> <string2>  // vscode pull my_workspace_1 = vscode.pull my_workspace_1
```
##### 使用 vscode.\<string\> \<string2\> 命令。

- #### 指定 ```3 個參數```
```cpp
vscode <string> <string2> <string3>  // vscode pull my_workspace_1 my_workspace_backup = vscode.pull my_workspace_1 my_workspace_backup
```
##### 使用 vscode.\<string\> \<string2\> \<string3\> 命令。
