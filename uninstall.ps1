function uninstall_function([string]$uninstall_file_name="main") {
    # Nothing
}
function clear-command(){
    param(
        [string]$command,
        [string]$path
    )
    $read = Get-Content $path
    $command = [Regex]::Escape($command)
    $write = $read | Where-Object { $_ -notmatch $command }
    Set-Content -Path $path -Value $write -Force
}
function main([string]$uninstall_file_name="main") {
    $install_file_name = $uninstall_file_name
    $obj=[UI]::new()
    [string]$profilePath = $PROFILE
    [string]$Path = "$env:USERPROFILE\Documents\WindowsPowerShell\Modules"
    [string]$targetFolder = Join-Path $Path "$install_file_name"
    [string]$targetScriptPath = Join-Path $targetFolder "$install_file_name.ps1"
    
    if (!(Test-Path $targetFolder)) {
        $obj.data_failed($install_file_name)
        $obj.output()
        return
    }
    Clear-Host
    $obj.asking_uninstall($install_file_name)
    if ($obj.asking() -eq 2) {
        return
    }
    uninstall_function -uninstall_file_name $uninstall_file_name
    [string]$dotCall = ". '$targetScriptPath'"
    [string[]]$lines = Get-Content $profilePath
    $lines = $lines | Where-Object { $_.Trim() -ne $dotCall.Trim() }
    Remove-Item -Path (Join-Path $targetFolder *) -Recurse -Force > $null
    $lines | Set-Content $profilePath -Force > $null
    Remove-Item -Path $targetFolder -Recurse -Force > $null
    $obj.data_success($install_file_name)
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
    [void] asking_uninstall([string]$name="main") {
        $this.message_en = "$name will be uninstalled! Are you sure?"
        $this.message_zh = "确定要卸载 $name 吗？"
        $this.message_zh_tw = "確定要解除安裝 $name 嗎？"
        $this.title_en = "Uninstall"
        $this.title_zh = "卸载"
        $this.title_zh_tw = "解除安裝"
    }
    [void] data_success([string]$name="main") {
        $this.message_en = "$name installed successfully! It will auto-load on PowerShell startup."
        $this.title_en = "Uninstall Complete"
        $this.title_zh = "卸载成功"
        $this.message_zh = "成功卸载 $name！PowerShell 每次开启时会不会再加载此文件。"
        $this.message_zh_tw = "成功解除安裝 $name！PowerShell 每次開啟時不會再載入此腳本。"
        $this.title_zh_tw = "解除安裝成功"
    }
    [void] data_failed([string]$name="main") {
        $this.message_en = "$name installed failed! It already installed!"
        $this.title_en = "Installation Failed"
        $this.title_zh = "卸载失败"
        $this.message_zh = "卸载 $name 失败！该文件不存在。"
        $this.message_zh_tw = "解除安裝 $name 失敗！該檔案不存在。"
        $this.title_zh_tw = "解除安裝失敗"
    }
}
main -uninstall_file_name "VSConfigManager"