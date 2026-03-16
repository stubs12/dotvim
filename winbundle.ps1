# Define where to save the bundles
$ExportPath = "..\GitBundles_Transfer"
if (!(Test-Path $ExportPath)) { New-Item -ItemType Directory -Path $ExportPath }

Write-Host "--- Bundling Main Repository ---" -ForegroundColor Cyan
$MainRepoName = (Get-Item .).Name
git bundle create "$ExportPath\$MainRepoName.bundle" --all

Write-Host "--- Bundling Submodules ---" -ForegroundColor Cyan
# Get list of submodule paths
$submodules = git submodule status | ForEach-Object { 
    # Clean up the output to get just the relative path
    $_.Trim().Split(' ')[1] 
}

foreach ($sm in $submodules) {
    if ($sm) {
        Write-Host "Processing submodule: $sm" -ForegroundColor Yellow
        $bundleName = $sm.Replace("/", "_").Replace("\", "_") + ".bundle"
        
        # Move into submodule, bundle, and come back
        Push-Location $sm
        git bundle create "$ExportPath\$bundleName" --all
        Pop-Location
    }
}

Write-Host "`nDone! All bundles are in: $ExportPath" -ForegroundColor Green

