# 🌐 StudyVictory Web Yayınlama Rehberi

## ✅ Web Build Tamamlandı!

Web build dosyaları `build/web/` klasöründe hazır.

## 🚀 GitHub Pages'e Yayınlama

### 1. Git Repository Başlatma

```powershell
# Git repository başlat
git init

# Tüm dosyaları ekle
git add .

# İlk commit
git commit -m "Initial commit: StudyVictory web app"

# GitHub'da yeni repository oluşturun, sonra:
git remote add origin https://github.com/KULLANICI_ADINIZ/studyvictory.git
git branch -M main
git push -u origin main
```

### 2. GitHub Pages Ayarları

1. **GitHub Repository'ye gidin**
   - https://github.com/KULLANICI_ADINIZ/studyvictory

2. **Settings → Pages**
   - Source: **GitHub Actions** seçin
   - (Artık `.github/workflows/deploy-web.yml` otomatik çalışacak)

3. **Otomatik Deploy**
   - Her `main` branch'e push'ta otomatik deploy edilecek
   - İlk deploy 2-3 dakika sürebilir

### 3. Manuel Deploy (Alternatif)

Eğer GitHub Actions yerine manuel deploy isterseniz:

```powershell
# build/web klasörünü docs/ klasörüne kopyala
xcopy /E /I build\web docs

# Commit ve push
git add docs
git commit -m "Deploy web version"
git push
```

Sonra GitHub Settings → Pages → Source: **/docs** seçin.

---

## 📋 Adım Adım Yayınlama

### Adım 1: Git Repository Oluşturma

```powershell
# Proje klasöründe
git init
git add .
git commit -m "Initial commit: StudyVictory"
```

### Adım 2: GitHub'da Repository Oluşturma

1. GitHub.com'a gidin
2. "New repository" tıklayın
3. Repository adı: `studyvictory` (veya istediğiniz ad)
4. Public seçin (Pages için ücretsiz)
5. README eklemeyin (zaten var)
6. "Create repository" tıklayın

### Adım 3: GitHub'a Push

```powershell
# Remote ekle (URL'yi kendi GitHub kullanıcı adınızla değiştirin)
git remote add origin https://github.com/KULLANICI_ADINIZ/studyvictory.git
git branch -M main
git push -u origin main
```

### Adım 4: GitHub Pages Aktif Etme

1. Repository → **Settings**
2. Sol menüden **Pages**
3. **Source**: "GitHub Actions" seçin
4. Kaydedin

### Adım 5: İlk Deploy

- GitHub Actions otomatik çalışacak
- **Actions** sekmesinde ilerlemeyi izleyebilirsiniz
- 2-3 dakika sürecek

### Adım 6: Uygulamayı Açma

Deploy tamamlandıktan sonra:
- **Settings → Pages** bölümünde URL görünecek
- Genellikle: `https://KULLANICI_ADINIZ.github.io/studyvictory/`

---

## 🔄 Güncelleme

Her kod değişikliğinde:

```powershell
git add .
git commit -m "Update: açıklama"
git push
```

GitHub Actions otomatik olarak yeni build edip deploy edecek!

---

## 🌍 Özel Domain (Opsiyonel)

1. **Settings → Pages → Custom domain**
2. Domain adınızı girin (örn: `studyvictory.com`)
3. DNS ayarlarınızı yapın:
   - A record: `185.199.108.153`, `185.199.109.153`, `185.199.110.153`, `185.199.111.153`
   - Veya CNAME: `KULLANICI_ADINIZ.github.io`

---

## ✅ Kontrol Listesi

- [x] Web build tamamlandı (`build/web/`)
- [ ] Git repository başlatıldı
- [ ] GitHub'da repository oluşturuldu
- [ ] GitHub'a push edildi
- [ ] GitHub Pages aktif edildi
- [ ] İlk deploy tamamlandı
- [ ] Uygulama web'de çalışıyor!

---

## 🎯 Hızlı Başlangıç

```powershell
# 1. Git başlat
git init
git add .
git commit -m "Initial commit"

# 2. GitHub'da repo oluştur (web'den)
# 3. Remote ekle
git remote add origin https://github.com/KULLANICI_ADINIZ/studyvictory.git
git branch -M main
git push -u origin main

# 4. GitHub → Settings → Pages → GitHub Actions seç
# 5. Bekle ve kullan! 🎉
```

