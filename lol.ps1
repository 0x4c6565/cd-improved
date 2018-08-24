$Global:PreviousDirectory = $null
function Set-LocationImproved($params)
{
    if ($params -eq $null)
    {
        return
    }

    $CurrentDirectory = (Get-Location).Path

    if ($params -eq "-")
    {
        if ($Global:PreviousDirectory -ne $null)
        {
            Set-Location -Path $PreviousDirectory
        }
    }
    else
    {
        Set-Location $params
    }

    $Global:PreviousDirectory = $CurrentDirectory
}

if (Test-Path -Path Alias:\cd)
{
    Remove-Item -Path Alias:\cd
}
Set-Alias -Name "cd" -Value "Set-LocationImproved"
