# Android Studio ve Android SDK Kurulum Scripti
# Bu script Android Studio'yu kurar ve Flutter ile entegre eder

Write-Host "Android Studio kurulum kontrolü yapılıyor..." -ForegroundColor Cyan

# 1. Android Studio kurulu mu kontrol et
$androidStudioInstalled = $false
$androidStudioPath = $null

$possiblePaths = @(
    "$env:LOCALAPPDATA\Programs\Android\Android Studio"
    "$env:ProgramFiles\Android\Android Studio"
    "${env:ProgramFiles(x86)}\Android\Android Studio"
    "$env:USERPROFILE\AppData\Local\Programs\Android Studio"
)

foreach ($path in $possiblePaths) {
    if (Test-Path "$path\bin\studio64.exe") {
        $androidStudioInstalled = $true
        $androidStudioPath = $path
        Write-Host "Android Studio bulundu: $path" -ForegroundColor Green
        break
    }
}

# 2. Android Studio kurulu değilse, kurulum yap
if (-not $androidStudioInstalled) {
    Write-Host "Android Studio bulunamadı. Kurulum başlatılıyor..." -ForegroundColor Yellow
    
    # Winget ile Android Studio kurulumu
    Write-Host "Android Studio indiriliyor ve kuruluyor (bu uzun sürebilir)..." -ForegroundColor Yellow
    winget install --id Google.AndroidStudio -e --accept-package-agreements --accept-source-agreements
    
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Winget kurulumu başarısız, alternatif yöntem deneniyor..." -ForegroundColor Yellow
        
        # Alternatif: Chocolatey kontrolü
        $chocoInstalled = Get-Command choco -ErrorAction SilentlyContinue
        if ($chocoInstalled) {
            Write-Host "Chocolatey ile kurulum deneniyor..." -ForegroundColor Yellow
            choco install androidstudio -y
        } else {
            Write-Host "Otomatik kurulum başarısız!" -ForegroundColor Red
            Write-Host "Lütfen Android Studio'yu manuel olarak kurun:" -ForegroundColor Yellow
            Write-Host "1. https://developer.android.com/studio adresini ziyaret edin" -ForegroundColor Yellow
            Write-Host "2. Android Studio'yu indirip kurun" -ForegroundColor Yellow
            Write-Host "3. Kurulum sırasında 'Android SDK' seçeneğini işaretleyin" -ForegroundColor Yellow
            Write-Host "4. Scripti tekrar çalıştırın" -ForegroundColor Yellow
            exit 1
        }
    }
    
    # Kurulum sonrası yolu bul
    Start-Sleep -Seconds 5
    foreach ($path in $possiblePaths) {
        if (Test-Path "$path\bin\studio64.exe") {
            $androidStudioPath = $path
            break
        }
    }
}

# 3. Android SDK yolunu bul
$androidSdkPath = $null
$sdkPaths = @(
    "$env:LOCALAPPDATA\Android\Sdk"
    "$env:USERPROFILE\AppData\Local\Android\Sdk"
    "$env:ANDROID_HOME"
    "$env:ANDROID_SDK_ROOT"
    "$env:ProgramFiles\Android\Sdk"
)

foreach ($path in $sdkPaths) {
    if ($path -and (Test-Path $path)) {
        $androidSdkPath = $path
        Write-Host "Android SDK bulundu: $path" -ForegroundColor Green
        break
    }
}

# 4. Flutter'ı Android SDK ile yapılandır
if ($androidSdkPath) {
    Write-Host "Flutter Android SDK yolu ayarlanıyor..." -ForegroundColor Yellow
    $env:Path += ";C:\Users\PC1\flutter\bin"
    & flutter config --android-sdk $androidSdkPath
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "Flutter Android SDK yolu başarıyla ayarlandı!" -ForegroundColor Green
    }
} else {
    Write-Host "UYARI: Android SDK bulunamadı!" -ForegroundColor Yellow
    Write-Host "Android Studio'yu açıp SDK'yı kurmanız gerekebilir:" -ForegroundColor Yellow
    Write-Host "1. Android Studio'yu açın" -ForegroundColor Yellow
    Write-Host "2. Tools > SDK Manager'a gidin" -ForegroundColor Yellow
    Write-Host "3. Android SDK'yı kurun" -ForegroundColor Yellow
}

# 5. Flutter doctor kontrolü
Write-Host ""
Write-Host "Flutter durumu kontrol ediliyor..." -ForegroundColor Cyan
$env:Path += ";C:\Users\PC1\flutter\bin"
flutter doctor

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Kurulum tamamlandı!" -ForegroundColor Green
Write-Host ""
Write-Host "Sonraki adımlar:" -ForegroundColor Yellow
Write-Host "1. Android Studio'yu açın" -ForegroundColor White
Write-Host "2. Tools > SDK Manager > SDK Platforms'den Android SDK kurun" -ForegroundColor White
Write-Host "3. Tools > Device Manager'dan bir emülatör oluşturun" -ForegroundColor White
Write-Host "4. Emülatörü başlatın" -ForegroundColor White
Write-Host "5. 'flutter run' komutu ile uygulamayı çalıştırın" -ForegroundColor White
Write-Host "========================================" -ForegroundColor Cyan

