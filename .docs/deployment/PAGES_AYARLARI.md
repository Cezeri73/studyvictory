# 📋 GitHub Pages Ayarları - Adım Adım

## 🔍 Mevcut Durum
- ✅ Repository oluşturuldu
- ✅ Kodlar push edildi
- ⚠️ Pages aktif değil

## 🚀 GitHub Pages'i Aktif Etme

### Adım 1: Settings'e Gidin

1. **Repository'ye gidin:**
   - https://github.com/Cezeri73/studyvictory

2. **Settings'e tıklayın:**
   - Sağ üst menüden **"Settings"** butonuna tıklayın

### Adım 2: Pages Ayarlarını Yapın

1. **Sol menüden "Pages" seçin**
   - Settings sayfasının sol menüsünde **"Pages"** tıklayın

2. **Source ayarlayın:**
   - **"Source"** bölümünde **"Deploy from a branch"** yerine
   - **"GitHub Actions"** seçeneğini seçin
   - Eğer "GitHub Actions" seçeneği görünmüyorsa:
     - Önce **"Actions"** sekmesine gidin
     - Bir workflow çalıştırın (varsa)
     - Sonra tekrar Pages'e dönün

### Adım 3: Alternatif Yöntem (GitHub Actions yoksa)

Eğer "GitHub Actions" seçeneği görünmüyorsa:

1. **"Deploy from a branch"** seçin
2. **Branch:** `main` seçin
3. **Folder:** `/ (root)` seçin
4. **Save** tıklayın

**NOT:** Bu yöntem için `build/web` klasörünü `docs` veya `gh-pages` branch'ine push etmek gerekir.

---

## 🔧 Otomatik Deploy için GitHub Actions

Eğer Actions çalışmıyorsa:

### Adım 1: Actions'ı Aktif Edin

1. Repository → **Settings → Actions → General**
2. **"Workflow permissions"** bölümünde:
   - ✅ **"Read and write permissions"** seçin
   - ✅ **"Allow GitHub Actions to create and approve pull requests"** işaretleyin
3. **Save** tıklayın

### Adım 2: Workflow'u Tetikleyin

1. **Actions** sekmesine gidin
2. **"Deploy to GitHub Pages"** workflow'unu bulun
3. **"Run workflow"** butonuna tıklayın (varsa)
4. Veya bir commit yaparak tetikleyin

---

## 🛠️ Manuel Deploy (Hızlı Çözüm)

GitHub Actions çalışmıyorsa, manuel olarak build/web klasörünü deploy edebiliriz:

### Seçenek 1: docs Klasörüne Kopyalama

```powershell
# Build/web klasörünü docs klasörüne kopyala
xcopy /E /I build\web docs

# Git'e ekle
git add docs
git commit -m "Add docs folder for GitHub Pages"
git push
```

Sonra **Settings → Pages → Source:** `/docs` seçin.

### Seçenek 2: gh-pages Branch

```powershell
# gh-pages branch oluştur
git checkout --orphan gh-pages
git rm -rf .
cp -r build/web/* .
git add .
git commit -m "Deploy to GitHub Pages"
git push origin gh-pages
git checkout main
```

Sonra **Settings → Pages → Source:** `gh-pages` branch seçin.

---

## ✅ En Kolay Yöntem: GitHub Actions Kullan

1. **Settings → Pages → Source: "GitHub Actions"** seçin
2. **Actions sekmesine gidin**
3. **Workflow çalışmasını bekleyin**
4. **2-3 dakika sonra** deploy tamamlanacak

---

## 🔍 Kontrol

Pages aktif olduktan sonra:
- **Settings → Pages** bölümünde URL görünecek
- Genellikle: `https://cezeri73.github.io/studyvictory/`
- İlk deploy 2-3 dakika sürebilir

---

**💡 İpucu:** En kolay yol GitHub Actions'ı kullanmak. Settings → Pages → "GitHub Actions" seçin ve bekleyin!

