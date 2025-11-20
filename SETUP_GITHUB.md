# 🚀 GitHub'a Yayınlama - Adım Adım

## ⚠️ ÖNCE: Git Kullanıcı Bilgilerini Ayarlayın

GitHub'a push etmek için önce Git kullanıcı bilgilerinizi ayarlamanız gerekiyor:

```powershell
# Kendi bilgilerinizle değiştirin
git config --global user.name "Adınız Soyadınız"
git config --global user.email "github-email@example.com"
```

**Not:** Email adresi GitHub hesabınızla aynı olmalı!

---

## 📋 Adım Adım Yayınlama

### Adım 1: Git Kullanıcı Bilgileri (Yukarıda yaptınız ✅)

### Adım 2: GitHub'da Repository Oluşturun

1. **https://github.com** adresine gidin
2. **Giriş yapın** (sağ üst köşe)
3. **Sağ üstten "+" → "New repository"** tıklayın
4. **Ayarları doldurun:**
   - **Repository name:** `studyvictory` (veya istediğiniz ad)
   - **Description:** "TYT/AYT/YDS/KPSS adayları için motivasyon ve çalışma takip uygulaması"
   - **Public** seçin (ücretsiz GitHub Pages için)
   - ✅ README, .gitignore, license **EKLEMEYIN** (zaten var)
5. **"Create repository"** tıklayın

### Adım 3: Commit Yapın

```powershell
# Proje klasöründe
git add .
git commit -m "Initial commit: StudyVictory web app with GitHub Pages"
```

### Adım 4: GitHub'a Bağlayın ve Push Edin

```powershell
# GitHub'dan aldığınız URL'yi buraya yazın (KULLANICI_ADINIZ'i değiştirin)
git remote add origin https://github.com/KULLANICI_ADINIZ/studyvictory.git

# Branch'i main yapın
git branch -M main

# GitHub'a gönderin
git push -u origin main
```

**Örnek URL:**
- `https://github.com/ahmet123/studyvictory.git`
- `https://github.com/johndoe/studyvictory.git`

### Adım 5: GitHub Pages'i Aktif Edin

1. Repository sayfasında **"Settings"** (sağ üst menü)
2. Sol menüden **"Pages"** seçin
3. **"Source"** bölümünde **"GitHub Actions"** seçin
4. Sayfayı kaydedin (otomatik kaydedilir)

### Adım 6: İlk Deploy'u Bekleyin

1. Üst menüden **"Actions"** sekmesine gidin
2. **"Deploy to GitHub Pages"** workflow'unu göreceksiniz
3. Tıklayıp ilerlemeyi izleyebilirsiniz
4. **2-3 dakika** sürecek
5. ✅ Yeşil tik = Başarılı!

### Adım 7: Uygulamanızı Açın! 🎉

1. **Settings → Pages** bölümüne geri dönün
2. **"Your site is live at"** altında URL görünecek
3. Genellikle: `https://KULLANICI_ADINIZ.github.io/studyvictory/`
4. Linke tıklayıp uygulamanızı görün!

---

## 🔄 Güncelleme

Kod değişikliği yaptığınızda:

```powershell
git add .
git commit -m "Update: ne değişti"
git push
```

**Otomatik olarak:**
- GitHub Actions build edecek
- Deploy edecek
- Web'de yayınlanacak

**2-3 dakika içinde** güncellemeler canlıya geçecek!

---

## 📝 README.md Güncelleme

`README.md` dosyasında `KULLANICI_ADINIZ` kısmını bulup kendi kullanıcı adınızla değiştirin:

```powershell
# README.md'yi düzenleyin (kendi editörünüzle)
# Sonra:
git add README.md
git commit -m "Update README with GitHub URLs"
git push
```

---

## ✅ Kontrol Listesi

- [ ] Git kullanıcı bilgileri ayarlandı
- [ ] GitHub'da repository oluşturuldu
- [ ] Commit yapıldı
- [ ] GitHub'a push edildi
- [ ] GitHub Pages aktif edildi (GitHub Actions)
- [ ] İlk deploy tamamlandı (Actions sekmesinde ✅)
- [ ] Uygulama web'de çalışıyor!

---

## 🆘 Hata Çözümleri

### "remote origin already exists" hatası:
```powershell
git remote remove origin
git remote add origin https://github.com/KULLANICI_ADINIZ/studyvictory.git
```

### "Authentication failed" hatası:
- GitHub'da **Settings → Developer settings → Personal access tokens** bölümünden token oluşturun
- Git için token kullanın veya GitHub Desktop kullanın

### Actions çalışmıyor:
1. **Settings → Actions → General**
2. **"Workflow permissions"** → **"Read and write permissions"**
3. Kaydedin

---

**🎉 Hazırsınız! Adımları takip edin ve uygulamanız web'de olacak!**

