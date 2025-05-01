class VSCodeWorkSpaceToolsAPI{
    [string]$fromConfigDefault=$this.configToPath("Default")
    [string]$toConfigDefault=(Join-Path (Get-Location) ".vscode")
    [void]newFile([string]$inputPath){
        if($this.isLegalPath(($inputPath))){
            if(!(Test-Path($inputPath))){
                New-Item -Path "$inputPath" -ItemType Directory -Force > $null 2>&1
            }
        }else{
            $this.nameError()
        }
    }
    [void]repairDefault(){
        $defaultFilePath=$this.configToPath("Default")
        $this.repairPath($defaultFilePath)
    }
    [bool]isLegalPath([string]$inputData){
        if($this.isPath($inputData)){
            if($this.isStringIn($inputData,"*<>`"|?")){
                return $false
            }else{
                return $true
            }
        }else{
            return $false
        }
    }
    [bool]isStringIn([string]$metaData,[string]$matchesData){
        for($i=0;$i -lt $metaData.length;$i++){
            $now=$metaData[$i]
            for($j=0;$j -lt $matchesData.length;$j++){
                if($now -eq $matchesData[$j]){
                    return $true
                }
            }
        }
        return $false
    }
    [bool]isPath([string]$inputData){
        if($inputData -match "^([a-zA-Z]\:|\.+)[\\\/]((.*[\\\/])?.*)?$"){
            return $true
        }else{
            return $false
        }
    }
    [bool]haveData([string]$a){
        return !($a -eq "")
    }
    [void]repairPath([string]$Path){
        $this.newFile($Path)
    }
    [string]configToPath([string]$inputData){
        $path="$env:USERPROFILE\.vscode\config\$inputData"
        if(!(Test-Path($path))){
            $this.newFile($path)
        }
        return "$path"
    }
    [void]nameError(){
        Write-Error "Error: Windows operating system not allow name contain: '<>|\/*.?`":'"
    }
    [object]init([string]$fromConfig="",[string]$toConfig=""){ # main
        $this.repairDefault()
        if($this.haveData($fromConfig)){
            if(!($this.isLegalPath($fromConfig))){
                if($this.isPath($fromConfig)){
                    $this.nameError()
                }else{
                    $fromConfig=$this.configToPath($fromConfig)
                    if(!($this.isLegalPath($fromConfig))){
                        $this.nameError()
                    }
                }
            }
        }else{
            $fromConfig=$this.fromConfigDefault
        }

        if($this.haveData($toConfig)){
            if(!($this.isLegalPath($toConfig))){
                if($this.isPath($toConfig)){
                    $this.nameError()
                }else{
                    $toConfig=$this.configToPath($toConfig)
                    if(!($this.isLegalPath($toConfig))){
                        $this.nameError()
                    }
                }
            }
        }else{
            $toConfig=$this.toConfigDefault
        }
        
        $this.repairPath($fromConfig)
        $this.repairPath($toConfig)
        return [PSCustomObject]@{
            fromConfig = $fromConfig
            toConfig = $toConfig
        }
    }
    [void]copy([string]$path1,[string]$path2){
        $this.repairPath($path1)
        $this.repairPath($path2)
        if(Test-Folder($path1)){
            $path1=Join-Path $path1 *
        }
        Copy-Item -Path "$path1" -Destination "$path2" -Recurse -Force
    }
    [void]remove([string]$path1){
        $this.repairPath($path1)
        Remove-Item -Path "$path1" -Recurse -Force
    }
    [void]replace([string]$path1,[string]$path2){
        $this.remove($path2)
        $this.copy($path1,$path2)
    }
    [bool]isDefaultFrom([string]$tmp){
        return $tmp -eq $this.fromConfigDefault
    }
    [bool]isDefaultTo([string]$tmp){
        return $tmp -eq $this.toConfigDefault
    }
}
function Test-Folder([string]$path){
    return (Test-Path -Path $path -PathType Container)
}
class vscodeFunction{
    $api=[VSCodeWorkSpaceToolsAPI]::new()
    [string]$fromConfig=""
    [string]$toConfig=""
    [void]init(){
        $tmpObj=$this.api.init($this.fromConfig,$this.toConfig)
        $this.fromConfig=$tmpObj.fromConfig
        $this.toConfig=$tmpObj.toConfig
        $this.toConfig=$this.toConfig.Trim()
        $this.fromConfig=$this.fromConfig.Trim()
        $tmpObj = $null
    }
    [void]vscode_push(){
        if($this.api.isDefaultTo($this.toConfig)){
            $this.api.copy($this.fromConfig, $this.toConfig)
        }else{
            $this.api.copy($this.toConfig, $this.fromConfig)
        }
    }
    [void]vscode_pull(){
        $this.api.copy($this.fromConfig,$this.toConfig)
    }
    [void]vscode_clone(){
        if($this.api.isDefaultTo($this.toConfig)){
            $this.api.replace($this.fromConfig, $this.toConfig)
        }else{
            $this.api.replace($this.toConfig,$this.fromConfig)
        }
    }
    [void]vscode_replace(){
        $this.vscode_clone()
    }
    [void]vscode_delete(){
        $this.api.remove($this.fromConfig)
    }
    [void]vscode_new(){
        $this.api.newFile($this.fromConfig)
    }
}
function init([string]$a="",[string]$b=""){
    $vscodeFunction=[vscodeFunction]::new()
    $vscodeFunction.fromConfig=$a
    $vscodeFunction.toConfig=$b
    $vscodeFunction.init()
    return $vscodeFunction
}
function vscode.push([string]$a="",[string]$b=""){
    (init -a $a -b $b).vscode_push()
}
function vscode.pull([string]$a="",[string]$b=""){
    (init -a $a -b $b).vscode_pull()
}
function vscode.clone([string]$a="",[string]$b=""){
    (init -a $a -b $b).vscode_clone()
}
function vscode.replace([string]$a="",[string]$b=""){
    (init -a $a -b $b).vscode_replace()
}
function vscode.delete([string]$a="",[string]$b=""){
    (init -a $a -b $b).vscode_delete()
}
function vscode.new([string]$a="",[string]$b=""){
    (init -a $a -b $b).vscode_new()
}

function vscode(){
    param(
        [string]$name = "",[string]$config = "",
        [string]$extraParam = ""
    )
    if($name -eq ""){
        Write-Output "Error: Please input function name"
        return
    }
    if($name -eq "push"){
        vscode.push $config $extraParam
    }
    elseif($name -eq "pull"){
        vscode.pull $config $extraParam
    }
    elseif($name -eq "replace"){
        vscode.replace $config $extraParam
    }
    elseif($name -eq "clone"){
        vscode.clone $config $extraParam
    }
    elseif($name -eq "delete"){
        vscode.delete $config
    }
    elseif($name -eq "new"){
        vscode.new $config
    }elseif($name -eq "init"){
        init $config
    }else{
        Write-Output "Error: No function 'vscode.$name'"
        return
    }
}
Set-Alias vscode_push vscode.push
Set-Alias vscode_pull vscode.pull
Set-Alias vscode_new vscode.new
Set-Alias vscode_delete vscode.delete
Set-Alias vscode_replace vscode.replace
Set-Alias vscode_clone vscode.clone
Set-Alias vscode_init vscode.init
Set-Alias vscode code