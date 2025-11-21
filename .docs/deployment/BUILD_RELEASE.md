# StudyVictory - Yayınlama Rehberi

## 📱 Yayınlama Seçenekleri

### 1. Android APK (Hızlı Dağıtım)
Doğrudan APK dosyası oluşturup paylaşabilirsiniz.

### 2. Google Play Store (Resmi Mağaza)
Android App Bundle (AAB) oluşturup Play Store'a yükleyebilirsiniz.

### 3. Web Sürümü
Web tarayıcısında çalışan versiyonu yayınlayabilirsiniz.

---

## 🚀 Android APK Build (Hızlı)

### Release APK Oluşturma

```powershell
# Release APK build
$env:Path += ";C:\Users\PC1\flutter\bin"
flutter build apk --release
```

**APK konumu:** `build/app/outputs/flutter-apk/app-release.apk`

### App Bundle (AAB) Oluşturma (Play Store için)

```powershell
flutter build appbundle --release
```

**AAB konumu:** `build/app/outputs/bundle/release/app-release.aab`

---

## 🌐 Web Sürümü Build

```powershell
flutter build web --release
```

**Web dosyaları:** `build/web/` klasöründe

---

## 📋 Yayınlama Öncesi Kontrol Listesi

### ✅ Uygulama Bilgileri
- [ ] Uygulama adı: StudyVictory
- [ ] Paket adı: `com.example.studyvictory` (Play Store için değiştirilmeli)
- [ ] Versiyon: `1.0.0+1`

### ✅ İzinler ve Gizlilik
- [ ] AndroidManifest.xml izinleri kontrol edildi
- [ ] Gizlilik politikası hazırlandı (gerekirse)

### ✅ İkon ve Splash Screen
- [ ] Uygulama ikonu güncellendi (`android/app/src/main/res/mipmap-*/ic_launcher.png`)
- [ ] Splash screen görseli hazırlandı

### ✅ Signing (İmzalama)
**ÖNEMLİ:** Play Store için keystore oluşturulmalı!

```powershell
# Keystore oluşturma (sadece bir kere)
keytool -genkey -v -keystore C:\Users\PC1\studyvictory-key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias studyvictory
```

### ✅ Test
- [ ] Release APK test edildi
- [ ] Tüm özellikler çalışıyor
- [ ] Performans kontrol edildi

---

## 📦 Google Play Store'a Yükleme

1. **Google Play Console hesabı oluşturun**
   - https://play.google.com/console
   - $25 tek seferlik kayıt ücreti

2. **AAB dosyası oluşturun**
   ```powershell
   flutter build appbundle --release
   ```

3. **Play Console'da uygulama oluşturun**
   - Uygulama adı, açıklama, kategori
   - Ekran görüntüleri
   - Gizlilik politikası URL'i

4. **AAB dosyasını yükleyin**
   - Production → Create new release
   - AAB dosyasını seçin

5. **Store listing doldurun**
   - Açıklama, ekran görüntüleri, icon
   - İçerik derecelendirmesi

6. **Yayınlayın!**

---

## 🔒 Signing Yapılandırması

Play Store için keystore yapılandırması:

1. `android/key.properties` dosyası oluşturun:
```properties
storePassword=<keystore şifresi>
keyPassword=<key şifresi>
keyAlias=studyvictory
storeFile=C:\\Users\\PC1\\studyvictory-key.jks
```

2. `android/app/build.gradle.kts` dosyasını güncelleyin (signingConfig ekleyin)

---

## 📱 APK Doğrudan Paylaşım

APK dosyasını:
- WhatsApp, email ile paylaşın
- Google Drive'a yükleyip link paylaşın
- Kendi web sitenizde indirme linki verin

**Not:** Bilinmeyen kaynaklardan uygulama yüklemeyi etkinleştirmeleri gerekebilir.

---

## 🎯 Sonraki Adımlar

1. Release APK build edin
2. Test edin
3. Play Store için hazırlık yapın (keystore, store listing)
4. Yayınlayın!

