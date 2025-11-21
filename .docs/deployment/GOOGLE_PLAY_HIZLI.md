# 🚀 Google Play Store - Hızlı Başlangıç

## 📋 Adım Adım Yayınlama

### 1. Keystore Oluşturma

```powershell
# Keystore scriptini çalıştırın
powershell -ExecutionPolicy Bypass -File .\create-keystore.ps1
```

**VEYA manuel olarak:**

```powershell
keytool -genkey -v -keystore C:\Users\PC1\studyvictory-key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias studyvictory
```

**Sorular:**
- **Password:** Güçlü bir şifre (kaydedin!)
- **Ad Soyad:** Murat Kaynar
- **Organizasyon:** Kendi adınız
- **Şehir:** Ankara
- **Ülke:** TR

### 2. Key.properties Dosyasını Doldurun

`android/key.properties` dosyasını düzenleyin:

```properties
storePassword=SIZIN_KEYSTORE_SIFRENIZ
keyPassword=SIZIN_KEY_SIFRENIZ
keyAlias=studyvictory
storeFile=C:\\Users\\PC1\\studyvictory-key.jks
```

**ÖNEMLİ:** Şifreleri keystore oluştururken kullandığınız şifrelerle değiştirin!

### 3. Android App Bundle (AAB) Build

```powershell
$env:Path += ";C:\Users\PC1\flutter\bin"
flutter build appbundle --release
```

**AAB Konumu:** `build/app/outputs/bundle/release/app-release.aab`

### 4. Google Play Console

1. **https://play.google.com/console** adresine gidin
2. **Google hesabı ile giriş yapın**
3. **$25 ödeme yapın** (tek seferlik)
4. **"Uygulama oluştur"** tıklayın

### 5. Uygulama Bilgileri

- **Uygulama adı:** StudyVictory
- **Varsayılan dil:** Türkçe
- **Uygulama türü:** Uygulama
- **Ücretsiz mi:** Evet

### 6. İçerik Derecelendirmesi

Anketi doldurun (genellikle PEGI 3)

### 7. Store Listing

#### Kısa Açıklama (80 karakter):
```
TYT/AYT/YDS/KPSS adayları için motivasyon ve çalışma takip uygulaması
```

#### Uzun Açıklama:
```
StudyVictory, sınavlara hazırlanan öğrenciler için motivasyon ve çalışma takip uygulamasıdır.

Özellikler:
- Pomodoro Timer: 25 dakika çalışma + 5 dakika mola
- Serbest Timer: Sınırsız çalışma süresi
- Kategori Takibi: TYT, AYT, YDS, KPSS
- Gamification: XP sistemi, seviyeler, rozetler
- İstatistikler: Haftalık grafikler
- Görev Yönetimi: Hazır şablonlar
- Hedef Belirleme: Günlük ve haftalık hedefler

StudyVictory ile sınavlara hazırlanırken motivasyonunuzu artırın!
```

#### Ekran Görüntüleri:
- En az 2 adet (telefon ekran görüntüsü)
- Minimum: 320px genişlik
- Maksimum: 3840px genişlik

#### İkon:
- 512x512 px
- PNG formatı

### 8. AAB Dosyasını Yükleyin

1. **Üretim** → **Yeni sürüm oluştur**
2. **AAB dosyasını sürükleyip bırakın:**
   - `build/app/outputs/bundle/release/app-release.aab`
3. **Sürüm notları:**
   ```
   İlk sürüm
   - TYT/AYT/YDS/KPSS odaklı çalışma takibi
   - Pomodoro timer
   - Gamification sistemi
   - İstatistikler ve grafikler
   ```
4. **"İncelemeye gönder"** tıklayın

### 9. Gizlilik Politikası

Google gizlilik politikası URL'i ister. Basit bir politika oluşturabiliriz veya GitHub Pages'de yayınlayabiliriz.

### 10. Bekleyin

- **2-7 gün** içinde Google incelemesi yapacak
- Onaylandıktan sonra otomatik yayınlanacak

---

## ✅ Kontrol Listesi

- [ ] Keystore oluşturuldu ve yedeklendi
- [ ] key.properties dosyası dolduruldu
- [ ] AAB build alındı
- [ ] Google Play Console hesabı oluşturuldu ($25 ödendi)
- [ ] Uygulama bilgileri hazırlandı
- [ ] Ekran görüntüleri hazırlandı
- [ ] İkon hazırlandı
- [ ] AAB dosyası yüklendi
- [ ] İncelemeye gönderildi

---

**🎉 Hazır olduğunuzda AAB build alabiliriz!**

