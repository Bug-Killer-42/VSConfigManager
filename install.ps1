function install_function([string]$install_file_name="main") {
    # Nothing
}
function add-command{
    param(
        [string]$command,
        [string]$path
    )
    Add-Content -Path $path -Value "$command" -Force
}
function main([string]$install_file_name="main") {
    $obj=[UI]::new()
    [string]$scriptSource = Join-Path $PWD "$install_file_name.ps1"
    [string]$Path = "$env:USERPROFILE\Documents\WindowsPowerShell\Modules"
    [string]$targetFolder = Join-Path $Path "$install_file_name"
    [string]$targetScriptPath = Join-Path $targetFolder "$install_file_name.ps1"
    [string]$dotCall = ". '$targetScriptPath'"

    if (Test-Path $targetFolder) {
        $obj.data_asking_update($install_file_name)
        if($obj.asking() -eq 2){
            return
        }else{
            Remove-Item -Path (Join-Path $targetFolder *) -Recurse -Force > $null
            Remove-Item -Path $targetFolder -Recurse -Force > $null
        }
    }else{
        $obj.asking_install($install_file_name)
        if($obj.asking() -eq 2){
        return
        }
    }
    Clear-Host
    install_function -install_file_name $install_file_name
    New-Item -Path $targetFolder -ItemType Directory -Force > $null
    Copy-Item -Path "$scriptSource" -Destination "$targetScriptPath" -Force

    if (!(Test-Path $PROFILE)) {
        New-Item -ItemType File -Path $PROFILE -Force > $null
    }

    [string]$profileContent = Get-Content $PROFILE -Raw
    
    if ($profileContent -notmatch [regex]::Escape($dotCall)) {
        Add-Content -Path $PROFILE -Value "`n $dotCall" -Force
        $obj.data_success($install_file_name)
    }else{
        $obj.data_update_success($install_file_name)
    }
    $obj.output()
}

class UI {
    [string]$message_en = ""
    [string]$message_zh = ""
    [string]$message_zh_tw = ""
    [string]$title_en = ""
    [string]$title_zh = ""
    [string]$title_zh_tw = ""
    [string]$language = (Get-UICulture).Name
    [string]$output_message = ""
    [string]$output_title = ""
    [void] init() {
        $this.language = (Get-UICulture).Name
        if ($this.language -like "zh-*") {
            if($this.language -like "zh-TW" || $this.language -like "zh-HK"){
                [string]$this.output_message = $this.message_zh_tw
                [string]$this.output_title = $this.title_zh_tw
            }else{
            [string]$this.output_message = $this.message_zh
            [string]$this.output_title = $this.title_zh
            }
        }else {
            [string]$this.output_message = $this.message_en
            [string]$this.output_title = $this.title_en
        }
    }
    [void] output() {
        $this.init()
        $this.pop(0x0)
        Clear-Host
    }
    [int] pop([int]$mode){
        $shell = New-Object -ComObject WScript.Shell
        return $shell.Popup($this.output_message, 0, $this.output_title, $mode)
    }
    [int] asking(){
        $this.init()
        return $this.pop(0x1)
    }
    [void] asking_install([string]$name="main") {
        $this.message_en = "Do you want to install $name ?"
        $this.title_en = "Info"
        $this.title_zh = "提示"
        $this.message_zh = "确定要安装 $name 吗？"
        $this.message_zh_tw = "確定要安裝 $name 嗎？"
        $this.title_zh_tw = "提醒"
    }
    [void] data_success([string]$name="main") {
        $this.message_en = "$name installed successfully! It will auto-load on PowerShell startup."
        $this.title_en = "Installation Complete"
        $this.title_zh = "安装成功"
        $this.message_zh = "成功安装 $name！PowerShell 每次开启时会自动加载此文件。"
        $this.message_zh_tw = "成功安裝 $name！PowerShell 每次開啟時會自動載入此腳本。"
        $this.title_zh_tw = "安裝成功"
    }
    [void] data_asking_update([string]$name="main") {
        $this.message_en = "$name already installed! Do you want to update it?"
        $this.title_en = "Info"
        $this.title_zh = "提示"
        $this.message_zh = "$name 已经安装！是否更新？"
        $this.message_zh_tw = "$name 已經安裝！是否更新？"
        $this.title_zh_tw = "提醒"
    }
    [void] data_update_success([string]$name="main") {
        $this.message_en = "$name updated successfully! It will auto-load on PowerShell startup."
        $this.title_en = "Update Complete"
        $this.title_zh = "更新成功"
        $this.message_zh = "成功更新 $name！PowerShell 每次开启时会自动加载此文件。"
        $this.message_zh_tw = "成功更新 $name！PowerShell 每次開啟時會自動載入此腳本。"
        $this.title_zh_tw = "更新成功"
    }
}
main -install_file_name "VSConfigManager"