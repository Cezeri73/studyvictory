# Flutter Kurulum Scripti
# Bu script Flutter'ı kontrol eder, kurar ve PATH'e ekler

Write-Host "Flutter kurulum kontrolü yapılıyor..." -ForegroundColor Cyan

# 1. Flutter kurulu mu kontrol et
$flutterInstalled = $false
$flutterPath = $null

try {
    flutter --version 2>&1 | Out-Null
    if ($LASTEXITCODE -eq 0) {
        $flutterInstalled = $true
        Write-Host "Flutter zaten kurulu!" -ForegroundColor Green
        
        # Flutter yolunu bul
        $flutterCmd = (Get-Command flutter -ErrorAction SilentlyContinue)
        if ($flutterCmd) {
            $flutterPath = Split-Path -Parent $flutterCmd.Source
        } else {
            # where.exe ile bul
            $whereResult = where.exe flutter 2>&1
            if ($LASTEXITCODE -eq 0 -and $whereResult) {
                $flutterPath = Split-Path -Parent $whereResult[0]
            }
        }
    }
} catch {
    $flutterInstalled = $false
}

# 2. Flutter kurulu değilse, kurulum yap
if (-not $flutterInstalled) {
    Write-Host "Flutter bulunamadı. Kurulum başlatılıyor..." -ForegroundColor Yellow
    
    # Git kurulu mu kontrol et
    $gitInstalled = $false
    try {
        git --version 2>&1 | Out-Null
        if ($LASTEXITCODE -eq 0) {
            $gitInstalled = $true
            Write-Host "Git zaten kurulu!" -ForegroundColor Green
        }
    } catch {
        $gitInstalled = $false
    }
    
    # Git kurulu değilse kur
    if (-not $gitInstalled) {
        Write-Host "Git kuruluyor..." -ForegroundColor Yellow
        winget install --id Git.Git -e --accept-package-agreements --accept-source-agreements
        if ($LASTEXITCODE -ne 0) {
            Write-Host "Git kurulumu başarısız! Lütfen manuel olarak kurun." -ForegroundColor Red
            exit 1
        }
        Write-Host "Git kurulumu tamamlandı!" -ForegroundColor Green
        
        # Git'i PATH'e yükle (yeni terminal için)
        $gitPath = "$env:ProgramFiles\Git\cmd"
        if (Test-Path $gitPath) {
            $env:Path = "$env:Path;$gitPath"
        }
        
        # Git kurulumunu doğrula
        Start-Sleep -Seconds 2
        git --version 2>&1 | Out-Null
        if ($LASTEXITCODE -ne 0) {
            Write-Host "Git kurulumu doğrulanamadı. Lütfen manuel olarak kontrol edin." -ForegroundColor Yellow
        }
    }
    
    # Flutter kurulum yolu
    $flutterInstallDir = "$env:USERPROFILE\flutter"
    $flutterBinPath = "$flutterInstallDir\bin"
    
    # Flutter zaten burada kurulu mu kontrol et
    if (-not (Test-Path "$flutterBinPath\flutter.bat")) {
        Write-Host "Flutter kuruluyor (bu biraz zaman alabilir)..." -ForegroundColor Yellow
        
        # Eğer eski kurulum varsa temizle
        if (Test-Path $flutterInstallDir) {
            Write-Host "Eski Flutter klasörü temizleniyor..." -ForegroundColor Yellow
            Remove-Item -Path $flutterInstallDir -Recurse -Force -ErrorAction SilentlyContinue
        }
        
        # Flutter'ı Git ile clone et (resmi yöntem)
        Write-Host "Flutter SDK indiriliyor (bu birkaç dakika sürebilir)..." -ForegroundColor Yellow
        
        # Git komutunu bul
        $gitCmd = "git"
        $gitPathCheck = Get-Command git -ErrorAction SilentlyContinue
        if (-not $gitPathCheck) {
            $gitCmd = "$env:ProgramFiles\Git\cmd\git.exe"
            if (-not (Test-Path $gitCmd)) {
                $gitCmd = "$env:ProgramFiles\Git\bin\git.exe"
            }
        }
        
        # Clone işlemi
        & $gitCmd clone https://github.com/flutter/flutter.git -b stable $flutterInstallDir
        
        if ($LASTEXITCODE -ne 0 -or -not (Test-Path "$flutterBinPath\flutter.bat")) {
            Write-Host "Git clone başarısız, alternatif yöntem deneniyor..." -ForegroundColor Yellow
            
            # Alternatif: Winget farklı paket adıyla dene
            $wingetResult = winget search flutter 2>&1
            if ($wingetResult -match "Flutter") {
                winget install Flutter -e --accept-package-agreements --accept-source-agreements 2>&1 | Out-Null
            } else {
                Write-Host "Flutter otomatik kurulumu başarısız!" -ForegroundColor Red
                Write-Host "Lütfen Flutter'ı manuel olarak kurun:" -ForegroundColor Yellow
                Write-Host "1. https://docs.flutter.dev/get-started/install/windows adresini ziyaret edin" -ForegroundColor Yellow
                Write-Host "2. Flutter SDK'yı indirip çıkarın" -ForegroundColor Yellow
                Write-Host "3. Scripti tekrar çalıştırın" -ForegroundColor Yellow
                exit 1
            }
        } else {
            Write-Host "Flutter kurulumu tamamlandı!" -ForegroundColor Green
        }
    } else {
        Write-Host "Flutter zaten $flutterInstallDir konumunda kurulu!" -ForegroundColor Green
    }
    
    # Flutter yolunu bul
    $flutterPath = $null
    $possiblePaths = @(
        "$flutterInstallDir\bin",
        "$env:USERPROFILE\AppData\Local\Pub\Cache\bin",
        "C:\src\flutter\bin",
        "$env:LOCALAPPDATA\Microsoft\WinGet\Packages\*Flutter*\flutter\bin",
        "$env:ProgramFiles\Flutter\bin",
        "$env:LOCALAPPDATA\Microsoft\WinGet\Links\flutter\bin"
    )
    
    # Flutter yolunu bul
    foreach ($path in $possiblePaths) {
        if ($path -like "*`**") {
            # Wildcard için - base path'i al
            $basePath = Split-Path $path -Parent
            if ($basePath -and (Test-Path $basePath)) {
                $wildcardPath = Get-ChildItem -Path $basePath -Directory -ErrorAction SilentlyContinue | 
                    Where-Object { 
                        $_.Name -like "*Flutter*" -and (Test-Path (Join-Path (Join-Path $_.FullName "flutter") "bin\flutter.bat"))
                    } | 
                    Select-Object -First 1
                if ($wildcardPath) {
                    $flutterPath = Join-Path (Join-Path $wildcardPath.FullName "flutter") "bin"
                    if (Test-Path "$flutterPath\flutter.bat") {
                        break
                    }
                }
            }
        } else {
            # Normal path için
            if (Test-Path "$path\flutter.bat") {
                $flutterPath = $path
                break
            }
        }
    }
    
    # Hala bulunamadıysa, where.exe ile ara
    if (-not $flutterPath) {
        try {
            $whereResult = where.exe flutter 2>&1
            if ($LASTEXITCODE -eq 0 -and $whereResult -and $whereResult.Count -gt 0) {
                $flutterPath = Split-Path -Parent $whereResult[0]
            }
        } catch {}
    }
    
    # Hala bulunamadıysa manuel arama yap
    if (-not $flutterPath) {
        $searchPath = Get-ChildItem -Path "$env:USERPROFILE" -Recurse -Directory -Filter "flutter" -ErrorAction SilentlyContinue -Depth 3 | 
            Where-Object { (Test-Path (Join-Path $_.FullName "bin\flutter.bat")) } | 
            Select-Object -First 1
        if ($searchPath) {
            $flutterPath = Join-Path $searchPath.FullName "bin"
        }
    }
    
    # Son kontrol: Kurduğumuz yolu kontrol et
    if (-not $flutterPath -and (Test-Path "$flutterBinPath\flutter.bat")) {
        $flutterPath = $flutterBinPath
    }
}

# 3. Flutter yolu bulundu, PATH'e ekle
if ($flutterPath -and (Test-Path $flutterPath)) {
    Write-Host "Flutter yolu bulundu: $flutterPath" -ForegroundColor Green
    
    # Mevcut User PATH'i al
    $currentPath = [Environment]::GetEnvironmentVariable("Path", "User")
    
    # PATH'te zaten var mı kontrol et
    $pathArray = $currentPath -split ';'
    if ($pathArray -notcontains $flutterPath) {
        Write-Host "Flutter yolu PATH'e ekleniyor..." -ForegroundColor Yellow
        
        # PATH'e ekle
        $newPath = $currentPath
        if ($newPath -and -not $newPath.EndsWith(';')) {
            $newPath += ';'
        }
        $newPath += $flutterPath
        
        [Environment]::SetEnvironmentVariable("Path", $newPath, "User")
        
        Write-Host "Flutter yolu PATH'e başarıyla eklendi!" -ForegroundColor Green
    } else {
        Write-Host "Flutter yolu zaten PATH'te!" -ForegroundColor Green
    }
} else {
    Write-Host "UYARI: Flutter yolu otomatik olarak bulunamadı!" -ForegroundColor Yellow
    Write-Host "Lütfen Flutter'ın kurulu olduğu klasörün 'bin' dizinini manuel olarak PATH'e ekleyin." -ForegroundColor Yellow
    Write-Host "Genellikle şu konumlardan biri olabilir:" -ForegroundColor Yellow
    Write-Host "  - C:\src\flutter\bin" -ForegroundColor Yellow
    Write-Host "  - $env:USERPROFILE\flutter\bin" -ForegroundColor Yellow
    Write-Host "  - $env:USERPROFILE\AppData\Local\Pub\Cache\bin" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Kurulum tamamlandı!" -ForegroundColor Green
Write-Host "Lütfen terminali kapatıp açın" -ForegroundColor Yellow
Write-Host "========================================" -ForegroundColor Cyan

