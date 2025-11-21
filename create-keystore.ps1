# Keystore Oluşturma Scripti
# Bu script StudyVictory için keystore oluşturur

Write-Host "StudyVictory için keystore oluşturuluyor..." -ForegroundColor Cyan
Write-Host ""
Write-Host "ÖNEMLİ: Keystore dosyanızı kaybetmeyin!" -ForegroundColor Yellow
Write-Host "Kaybederseniz uygulama güncelleyemezsiniz!" -ForegroundColor Yellow
Write-Host ""

$keystorePath = "C:\Users\PC1\studyvictory-key.jks"

# Keystore zaten var mı kontrol et
if (Test-Path $keystorePath) {
    Write-Host "Keystore zaten var: $keystorePath" -ForegroundColor Yellow
    $continue = Read-Host "Üzerine yazmak ister misiniz? (E/H)"
    if ($continue -ne "E" -and $continue -ne "e") {
        Write-Host "İptal edildi." -ForegroundColor Yellow
        exit 0
    }
    Remove-Item $keystorePath -Force
}

Write-Host "Keystore oluşturuluyor..." -ForegroundColor Green
Write-Host "Aşağıdaki soruları yanıtlayın:" -ForegroundColor Yellow
Write-Host ""

# Keystore oluştur
keytool -genkey -v -keystore $keystorePath -keyalg RSA -keysize 2048 -validity 10000 -alias studyvictory

if (Test-Path $keystorePath) {
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Green
    Write-Host "Keystore başarıyla oluşturuldu!" -ForegroundColor Green
    Write-Host "Yol: $keystorePath" -ForegroundColor Green
    Write-Host ""
    Write-Host "ÖNEMLİ:" -ForegroundColor Yellow
    Write-Host "1. Bu dosyayı GÜVENLİ bir yere yedekleyin!" -ForegroundColor Yellow
    Write-Host "2. Şifreyi GÜVENLİ bir yerde saklayın!" -ForegroundColor Yellow
    Write-Host "3. Bu dosyayı kaybetmeyin - uygulama güncelleyemezsiniz!" -ForegroundColor Yellow
    Write-Host "========================================" -ForegroundColor Green
} else {
    Write-Host ""
    Write-Host "Hata: Keystore oluşturulamadı!" -ForegroundColor Red
    Write-Host "Lütfen manuel olarak oluşturun:" -ForegroundColor Yellow
    Write-Host "keytool -genkey -v -keystore C:\Users\PC1\studyvictory-key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias studyvictory" -ForegroundColor Yellow
    exit 1
}

