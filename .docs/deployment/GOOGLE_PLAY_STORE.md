# 📱 Google Play Store Yayınlama Rehberi

## 🎯 Google Play Store'a Yayınlama

### Önkoşullar

1. ✅ **Google Play Console hesabı** gerekli
   - https://play.google.com/console
   - Tek seferlik **$25 kayıt ücreti**

2. ✅ **Android App Bundle (AAB)** gerekli (APK değil!)

3. ✅ **Keystore** gerekli (uygulamayı imzalamak için)

---

## 📋 Adım Adım Yayınlama

### 1. Keystore Oluşturma

**ÖNEMLİ:** Keystore dosyanızı kaybetmeyin! Kaybederseniz uygulama güncelleyemezsiniz!

```powershell
# Keystore oluştur (sadece bir kere!)
keytool -genkey -v -keystore C:\Users\PC1\studyvictory-key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias studyvictory
```

**Sorular:**
- **Password:** Güçlü bir şifre girin (kaydedin!)
- **Ad Soyad:** Murat Kaynar
- **Organizasyon:** Kendi adınız veya şirket adı
- **Şehir:** Ankara
- **Ülke:** TR

**Not:** Şifreyi ve keystore yolunu kaydedin!

### 2. Signing Yapılandırması

Android uygulamasını keystore ile imzalamak için yapılandırma yapacağız.

### 3. Android App Bundle (AAB) Build

```powershell
flutter build appbundle --release
```

**AAB Konumu:** `build/app/outputs/bundle/release/app-release.aab`

### 4. Google Play Console'a Giriş

1. **Google Play Console** hesabı oluşturun:
   - https://play.google.com/console
   - Google hesabı ile giriş yapın
   - **$25 ödeme** yapın (tek seferlik)

### 5. Uygulama Oluşturma

1. **"Tüm uygulamalar"** → **"Uygulama oluştur"**
2. **Uygulama detaylarını** doldurun:
   - **Uygulama adı:** StudyVictory
   - **Varsayılan dil:** Türkçe
   - **Uygulama türü:** Uygulama
   - **Ücretsiz mi:** Evet
   - **CSP bildirimi:** Hayır

### 6. İçerik Derecelendirmesi

1. **İçerik derecelendirmesi** anketini doldurun
2. Genellikle **PEGI 3** veya **EVERYONE** olur

### 7. Store Listing (Mağaza Listesi)

#### Gerekli Bilgiler:

1. **Kısa Açıklama:** (80 karakter)
   ```
   TYT/AYT/YDS/KPSS adayları için motivasyon ve çalışma takip uygulaması
   ```

2. **Uzun Açıklama:** (4000 karakter)
   ```
   StudyVictory, sınavlara hazırlanan öğrenciler için tasarlanmış kapsamlı bir çalışma takip ve motivasyon uygulamasıdır.

   🎯 Özellikler:
   - Pomodoro Timer: 25 dakika odaklı çalışma + 5 dakika mola
   - Serbest Timer: Sınırsız çalışma süresi
   - Kategori Takibi: TYT, AYT, YDS, KPSS ve ders bazlı
   - Gamification: XP sistemi, seviyeler, rozetler
   - İstatistikler: Haftalık grafikler, kategori dağılımı
   - Görev Yönetimi: TYT/AYT/YDS/KPSS şablonları
   - Hedef Belirleme: Günlük ve haftalık hedefler

   🏆 Başarılar:
   - XP kazanarak seviye atla
   - Rozetler topla
   - Streak kayıtları kır
   - İstatistiklerini takip et

   StudyVictory ile sınavlara hazırlanırken motivasyonunuzu artırın ve çalışma başarınızı takip edin!
   ```

3. **Ekran Görüntüleri:**
   - En az 2 adet (telefon)
   - Tablet için isteğe bağlı
   - Minimum boyut: 320px
   - Maksimum boyut: 3840px

4. **Yüksek Çözünürlüklü İkon:**
   - 512x512 px
   - PNG formatı
   - Transparan arka plan olmalı

5. **Özellik Grafiği:**
   - 1024x500 px (isteğe bağlı ama önerilir)

6. **Video Tanıtım:** (isteğe bağlı)

### 8. AAB Dosyasını Yükleme

1. **Üretim** → **Yeni sürüm oluştur**
2. **AAB dosyasını yükleyin:**
   - `build/app/outputs/bundle/release/app-release.aab`
3. **Sürüm notlarını** ekleyin:
   ```
   İlk sürüm
   - TYT/AYT/YDS/KPSS odaklı çalışma takibi
   - Pomodoro timer
   - Gamification sistemi
   - İstatistikler ve grafikler
   - Görev yönetimi
   ```

### 9. Gizlilik Politikası

**Gerekli:** Google Play Store gizlilik politikası URL'i ister.

Basit bir gizlilik politikası oluşturabiliriz veya GitHub Pages'de yayınlayabiliriz.

### 10. Yayınlama

1. **"İncelemeye gönder"** butonuna tıklayın
2. **2-7 gün** içinde Google incelemesi yapacak
3. Onaylandıktan sonra **otomatik yayınlanacak**

---

## 🔒 Keystore Güvenliği

**ÇOK ÖNEMLİ:**

1. ✅ **Keystore dosyasını yedekleyin:**
   - Güvenli bir yere kopyalayın
   - Bulut depolamaya yükleyin (şifrelenmiş)

2. ✅ **Şifreyi kaydedin:**
   - Güvenli bir yerde saklayın
   - Şifre yöneticisi kullanın

3. ❌ **Keystore'u kaybetmeyin:**
   - Kaybederseniz uygulama güncelleyemezsiniz!
   - Yeni keystore ile yeni uygulama oluşturmanız gerekir

---

## ✅ Kontrol Listesi

- [ ] Google Play Console hesabı oluşturuldu ($25 ödendi)
- [ ] Keystore oluşturuldu ve yedeklendi
- [ ] Signing yapılandırıldı
- [ ] AAB build alındı
- [ ] Uygulama bilgileri hazırlandı
- [ ] Ekran görüntüleri hazırlandı
- [ ] İkon hazırlandı
- [ ] Gizlilik politikası hazırlandı
- [ ] AAB dosyası yüklendi
- [ ] İncelemeye gönderildi

---

**🎉 Hazır olduğunuzda AAB build alabiliriz!**

