$dir = "e:\RoBoost\RoBoost"
$files = Get-ChildItem -Path $dir -Recurse -Include "*.cs" -File

foreach ($file in $files) {
    $content = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)
    $modified = $false
    
    # Replace namespace declarations
    if ($content -match 'namespace Bloxstrap') {
        $content = $content -replace 'namespace Bloxstrap(\.[a-zA-Z0-9_]+)?', 'namespace RoBoost$1'
        $modified = $true
    }
    
    # Replace using statements
    if ($content -match 'using Bloxstrap') {
        $content = $content -replace 'using Bloxstrap(\.[a-zA-Z0-9_]+)?', 'using RoBoost$1'
        $modified = $true
    }
    
    if ($modified) {
        [System.IO.File]::WriteAllText($file.FullName, $content, [System.Text.Encoding]::UTF8)
        Write-Host "Updated: $($file.Name)"
    }
}

Write-Host "Rebranding complete!"
