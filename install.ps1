function main {
    $obj=[UI]::new()
    [string]$scriptSource = Join-Path $PWD "VSConfigManager.ps1"
    [string]$Path = "$env:USERPROFILE\Documents\WindowsPowerShell\Modules"
    [string]$targetFolder = Join-Path $Path "VSConfigManager"
    [string]$targetScriptPath = Join-Path $targetFolder "VSConfigManager.ps1"
    [string]$dotCall = ". '$targetScriptPath'"

    if (Test-Path $targetFolder) {
        $obj.data_asking_update()
        if($obj.asking() -eq 2){
            return
        }else{
            Remove-Item -Path (Join-Path $targetFolder *) -Recurse -Force > $null
            Remove-Item -Path $targetFolder -Recurse -Force > $null
        }
    }
    Clear-Host
    New-Item -Path $targetFolder -ItemType Directory -Force > $null
    Copy-Item -Path "$scriptSource" -Destination "$targetScriptPath" -Force

    if (!(Test-Path $PROFILE)) {
        New-Item -ItemType File -Path $PROFILE -Force > $null
    }

    [string]$profileContent = Get-Content $PROFILE -Raw
    
    
    if ($profileContent -notmatch [regex]::Escape($dotCall)) {
        Add-Content -Path $PROFILE -Value "`n $dotCall" -Force
        $obj.data_success()
    }else{
        $obj.data_update_success()
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

    [void] output() {
        if ($this.language -like "zh-*") {
            [string]$output_message = $this.message_zh
            [string]$output_title = $this.title_zh
        } else {
            [string]$output_message = $this.message_en
            [string]$output_title = $this.title_en
        }
        $shell = New-Object -ComObject WScript.Shell
        $shell.Popup($output_message, 0, $output_title, 0x0) > $null
        Clear-Host
    }
    [int] asking(){
        if ($this.language -like "zh-*") {
            if($this.language -like "zh-TW" || $this.language -like "zh-HK"){
                [string]$output_message = $this.message_zh_tw
                [string]$output_title = $this.title_zh_tw
            }else{
            [string]$output_message = $this.message_zh
            [string]$output_title = $this.title_zh
            }
        }else {
            [string]$output_message = $this.message_en
            [string]$output_title = $this.title_en
        }
        $shell = New-Object -ComObject WScript.Shell
        return $shell.Popup($output_message, 0, $output_title, 0x1)
    }
    [void] data_success() {
        $this.message_en = "VSConfigManager installed successfully! It will auto-load on PowerShell startup."
        $this.title_en = "Installation Complete"
        $this.title_zh = "安装成功"
        $this.message_zh = "成功安装 VSConfigManager！PowerShell 每次开启时会自动加载此文件。"
        $this.message_zh_tw = "成功安裝 VSConfigManager！PowerShell 每次開啟時會自動加載此腳本。"
        $this.title_zh_tw = "安裝成功"
    }
    [void] data_asking_update() {
        $this.message_en = "VSConfigManager already installed! Do you want to update it?"
        $this.title_en = "Info"
        $this.title_zh = "提示"
        $this.message_zh = "VSConfigManager 已经安装！是否更新？"
        $this.message_zh_tw = "VSConfigManager 已經安裝！是否更新？"
        $this.title_zh_tw = "提醒"
    }
    [void] data_update_success() {
        $this.message_en = "VSConfigManager updated successfully! It will auto-load on PowerShell startup."
        $this.title_en = "Update Complete"
        $this.title_zh = "更新成功"
        $this.message_zh = "成功更新 VSConfigManager！PowerShell 每次开启时会自动加载此文件。"
        $this.message_zh_tw = "成功更新 VSConfigManager！PowerShell 每次開啟時會自動加載此腳本。"
        $this.title_zh_tw = "更新成功"
    }
    [void] data_failed() {
        $this.message_en = "VSConfigManager installed failed! It already installed!"
        $this.title_en = "Installation Failed"
        $this.title_zh = "安装失败"
        $this.message_zh = "安装 VSConfigManager 失败！该文件已存在。"
        $this.message_zh_tw = "安裝 VSConfigManager 失敗！該檔案已存在。"
        $this.title_zh_tw = "安裝錯誤"
    }
}

main
