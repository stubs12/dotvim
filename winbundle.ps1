# Get the absolute path for the export folder
$RelativeExportPath = "..\GitBundles_Transfer"
$ExportPath = [System.IO.Path]::GetFullPath((Join-Path (Get-Location) $RelativeExportPath))

if (!(Test-Path $ExportPath)) { 
    New-Item -ItemType Directory -Path $ExportPath 
    Write-Host "Created directory: $ExportPath" -ForegroundColor Green
}

Write-Host "--- Bundling Main Repository ---" -ForegroundColor Cyan
$MainRepoName = (Get-Item .).Name
git bundle create "$ExportPath\$MainRepoName.bundle" --all

Write-Host "--- Bundling Submodules ---" -ForegroundColor Cyan
# Get list of submodule paths
$submodules = git submodule status | ForEach-Object { 
    $_.Trim().Split(' ')[1] 
}

foreach ($sm in $submodules) {
    if ($sm) {
        Write-Host "Processing submodule: $sm" -ForegroundColor Yellow
        # Create a unique filename by replacing slashes
        $bundleName = $sm.Replace("/", "_").Replace("\", "_") + ".bundle"
        $targetFile = Join-Path $ExportPath $bundleName
        
        Push-Location $sm
        # Now using the absolute path $targetFile
        git bundle create "$targetFile" --all
        Pop-Location
    }
}

Write-Host "`nDone! All bundles are in: $ExportPath" -ForegroundColor Green

