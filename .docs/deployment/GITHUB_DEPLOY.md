# 🚀 GitHub'a Yayınlama - Hızlı Adımlar

## ✅ Hazırlık Tamamlandı!

- ✅ Web build yapıldı (`build/web/`)
- ✅ GitHub Actions workflow oluşturuldu (`.github/workflows/deploy-web.yml`)
- ✅ README.md hazırlandı
- ✅ Git repository başlatıldı

## 📋 Şimdi Yapılacaklar

### 1. GitHub'da Repository Oluşturun

1. **GitHub.com'a gidin** ve giriş yapın
2. **Sağ üstten "+" → "New repository"** tıklayın
3. **Repository ayarları:**
   - Repository name: `studyvictory` (veya istediğiniz ad)
   - Description: "TYT/AYT/YDS/KPSS adayları için motivasyon ve çalışma takip uygulaması"
   - **Public** seçin (GitHub Pages ücretsiz sadece public repo'larda)
   - **README, .gitignore, license eklemeyin** (zaten var)
4. **"Create repository"** tıklayın

### 2. GitHub'a Push Edin

```powershell
# GitHub'dan aldığınız URL'yi kullanın (örnek):
git remote add origin https://github.com/KULLANICI_ADINIZ/studyvictory.git

# Branch adını main yapın
git branch -M main

# GitHub'a push edin
git push -u origin main
```

**Not:** `KULLANICI_ADINIZ` kısmını kendi GitHub kullanıcı adınızla değiştirin!

### 3. GitHub Pages'i Aktif Edin

1. **Repository'ye gidin** → **Settings** (sağ üst menü)
2. Sol menüden **Pages** seçin
3. **Source** bölümünden **"GitHub Actions"** seçin
4. Sayfayı yenileyin

### 4. İlk Deploy'u Bekleyin

1. **Actions** sekmesine gidin
2. **"Deploy to GitHub Pages"** workflow'unun çalıştığını göreceksiniz
3. İlk deploy **2-3 dakika** sürecek
4. Yeşil tik göründüğünde deploy tamamlanmıştır!

### 5. Uygulamanızı Açın! 🎉

1. **Settings → Pages** bölümüne geri dönün
2. **"Your site is live at"** altında URL görünecek
3. Genellikle: `https://KULLANICI_ADINIZ.github.io/studyvictory/`

---

## 🔄 Sonraki Güncellemeler

Kod değişikliği yaptığınızda:

```powershell
git add .
git commit -m "Update: açıklama"
git push
```

GitHub Actions **otomatik** olarak:
1. Build edecek
2. Deploy edecek
3. Web'de yayınlayacak

**2-3 dakika içinde** güncellemeler canlıya geçecek!

---

## 📝 README.md'yi Güncelleyin

`README.md` dosyasındaki:
- `KULLANICI_ADINIZ` kısmını kendi GitHub kullanıcı adınızla değiştirin
- URL'leri güncelleyin

Sonra tekrar commit edin:
```powershell
git add README.md
git commit -m "Update README with actual GitHub URLs"
git push
```

---

## ✅ Kontrol Listesi

- [x] Web build tamamlandı
- [x] GitHub Actions workflow oluşturuldu
- [x] Git repository başlatıldı
- [x] İlk commit yapıldı
- [ ] GitHub'da repository oluşturuldu
- [ ] GitHub'a push edildi
- [ ] GitHub Pages aktif edildi
- [ ] İlk deploy tamamlandı
- [ ] Web'de uygulama çalışıyor!

---

## 🆘 Sorun mu Yaşıyorsunuz?

### Push hatası alıyorsanız:
```powershell
# Remote kontrolü
git remote -v

# Remote'u güncelleyin
git remote set-url origin https://github.com/KULLANICI_ADINIZ/studyvictory.git
```

### GitHub Actions çalışmıyorsa:
1. **Settings → Actions → General**
2. **"Workflow permissions"** → **"Read and write permissions"** seçin
3. **"Allow GitHub Actions to create and approve pull requests"** işaretleyin
4. Kaydedin ve Actions'ı tekrar çalıştırın

---

## 🎯 Hızlı Komutlar

```powershell
# Repository durumu
git status

# Remote kontrolü
git remote -v

# Değişiklikleri görmek
git log --oneline

# GitHub'a push
git push

# Son commit'i değiştirmek
git commit --amend -m "Yeni mesaj"
git push --force
```

---

**🎉 Başarılar! Uygulamanız yakında web'de olacak!**

