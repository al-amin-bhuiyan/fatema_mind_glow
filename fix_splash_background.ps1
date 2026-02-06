# Fix Native Splash Background Script
# Run this after regenerating native splash to replace background.png with splash_background.png

Write-Host "🔧 Fixing Native Splash Background..." -ForegroundColor Cyan

# 1. Delete all background.png files
Write-Host "`n1. Deleting generated background.png files..." -ForegroundColor Yellow
$resPath = "android\app\src\main\res"
$bgFiles = Get-ChildItem -Path $resPath -Recurse -Filter "background.png"
$bgCount = ($bgFiles | Measure-Object).Count
if ($bgCount -gt 0) {
    $bgFiles | Remove-Item -Force
    Write-Host "   ✅ Deleted $bgCount background.png file(s)" -ForegroundColor Green
} else {
    Write-Host "   ✅ No background.png files found" -ForegroundColor Green
}

# 2. Copy splash_background.png to all drawable folders
Write-Host "`n2. Copying splash_background.png to all drawable folders..." -ForegroundColor Yellow
$sourceBg = "assets\images\splash_background.png"
if (Test-Path $sourceBg) {
    $folders = Get-ChildItem $resPath -Directory | Where-Object { $_.Name -like 'drawable*' }
    $copied = 0
    foreach ($folder in $folders) {
        $dest = Join-Path $folder.FullName "splash_background.png"
        Copy-Item $sourceBg -Destination $dest -Force
        $copied++
    }
    Write-Host "   ✅ Copied to $copied folder(s)" -ForegroundColor Green
} else {
    Write-Host "   ❌ Source file not found: $sourceBg" -ForegroundColor Red
    exit 1
}

# 3. Update all launch_background.xml files
Write-Host "`n3. Updating launch_background.xml files..." -ForegroundColor Yellow
$xmlFiles = Get-ChildItem -Path $resPath -Recurse -Filter "launch_background.xml"
$updated = 0
foreach ($xmlFile in $xmlFiles) {
    $content = Get-Content $xmlFile.FullName -Raw
    if ($content -match '@drawable/background[^_]') {
        $newContent = $content -replace '@drawable/background(?=[^_]|")', '@drawable/splash_background'
        Set-Content -Path $xmlFile.FullName -Value $newContent -NoNewline
        $updated++
    }
}
Write-Host "   ✅ Updated $updated XML file(s)" -ForegroundColor Green

# 4. Verification
Write-Host "`n4. Verification..." -ForegroundColor Yellow
$remainingBg = (Get-ChildItem -Path $resPath -Recurse -Filter "background.png" | Measure-Object).Count
$splashBgCount = (Get-ChildItem -Path $resPath -Recurse -Filter "splash_background.png" | Measure-Object).Count

Write-Host "   background.png files remaining: $remainingBg" -ForegroundColor $(if ($remainingBg -eq 0) { "Green" } else { "Red" })
Write-Host "   splash_background.png files: $splashBgCount" -ForegroundColor Green

if ($remainingBg -eq 0 -and $splashBgCount -gt 0) {
    Write-Host "`n✅ SUCCESS! Native splash background fixed!" -ForegroundColor Green
    Write-Host "`nNext steps:" -ForegroundColor Cyan
    Write-Host "  1. Run: flutter clean" -ForegroundColor White
    Write-Host "  2. Run: flutter build apk" -ForegroundColor White
} else {
    Write-Host "`n❌ FAILED! Please check the issues above." -ForegroundColor Red
    exit 1
}
