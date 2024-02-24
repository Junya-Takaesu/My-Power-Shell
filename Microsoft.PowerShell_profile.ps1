Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope CurrentUser
Set-Theme Paradox
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\paradox.omp.json" | Invoke-Expression
Import-Module -Name Terminal-Icons

# コマンド補完
# 参考: https://devblogs.microsoft.com/powershell/announcing-psreadline-2-1-with-predictive-intellisense/?WT.mc_id=-blog-scottha
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle InLineView

function Search-History-With-Peco {
    $command = (Get-Content (Get-PSReadlineOption).HistorySavePath | peco --layout bottom-up)
    [Microsoft.PowerShell.PSConsoleReadLine]::Insert($command) 
}
Set-PSReadLineKeyHandler -chord Ctrl+r -scriptBlock { Search-History-With-Peco }

# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}
