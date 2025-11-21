# 🔢 Versiyonlama Sistemi

StudyVictory uygulaması **Semantic Versioning (SemVer)** kullanır.

## 📋 Versiyon Formatı

**`MAJOR.MINOR.PATCH+BUILD`**

Örnek: `1.0.0+1`
- **1** = MAJOR (büyük değişiklikler)
- **0** = MINOR (yeni özellikler)
- **0** = PATCH (hata düzeltmeleri)
- **+1** = BUILD (build numarası)

---

## 📊 Versiyon Artırma Kuralları

### 🔴 MAJOR (X.0.0) - Büyük Değişiklikler

**Ne zaman artırılır:**
- Geriye dönük uyumsuz API değişiklikleri
- Büyük özellik yenilikleri
- Mimari değişiklikler
- Veri yapısı değişiklikleri (migration gerektiriyorsa)

**Örnekler:**
- `1.0.0` → `2.0.0`: Tamamen yeni tasarım sistemi
- `2.0.0` → `3.0.0`: Bulut senkronizasyonu eklenmesi (veri formatı değişikliği)

**Git Tag:** `v2.0.0`

---

### 🟡 MINOR (x.X.0) - Yeni Özellikler

**Ne zaman artırılır:**
- Geriye dönük uyumlu yeni özellikler
- Yeni ekranlar veya fonksiyonlar
- Küçük özellik iyileştirmeleri
- Yeni rozetler, grafikler

**Örnekler:**
- `1.0.0` → `1.1.0`: Karanlık/Açık tema eklendi
- `1.1.0` → `1.2.0`: Kategori bazlı hedefler eklendi
- `1.2.0` → `1.3.0`: Widget desteği eklendi

**Git Tag:** `v1.1.0`

---

### 🟢 PATCH (x.x.X) - Hata Düzeltmeleri

**Ne zaman artırılır:**
- Bug fixler
- Güvenlik yamaları
- Performans iyileştirmeleri
- Küçük UI düzeltmeleri

**Örnekler:**
- `1.0.0` → `1.0.1`: Timer durdurma hatası düzeltildi
- `1.0.1` → `1.0.2`: Grafik gösterimi hatası düzeltildi
- `1.0.2` → `1.0.3`: Hafıza sızıntısı düzeltildi

**Git Tag:** `v1.0.1`

---

### 🔵 BUILD (+N) - Build Numarası

**Ne zaman artırılır:**
- Her build'de otomatik artırılır
- Aynı versiyonda birden fazla build varsa
- CI/CD tarafından otomatik artırılabilir

**Örnekler:**
- `1.0.0+1` → `1.0.0+2` (aynı versiyon, yeni build)
- `1.0.0+5` → `1.0.1+1` (yeni versiyon, build sıfırlanır)

---

## 🚀 Yeni Versiyon Yayınlama Adımları

### 1. Değişiklikleri Belirle

Yapılan değişikliklere göre versiyon tipini belirle:
- Sadece bug fix → **PATCH** (1.0.0 → 1.0.1)
- Yeni özellik eklendi → **MINOR** (1.0.0 → 1.1.0)
- Büyük değişiklik → **MAJOR** (1.0.0 → 2.0.0)

### 2. Versiyon Numaralarını Güncelle

**pubspec.yaml:**
```yaml
version: 1.1.0+2  # Version + Build Number
```

**NOT:** Versiyon değiştiğinde build numarasını **+1** yap (veya sıfırla)

### 3. CHANGELOG.md Güncelle

Yeni versiyon için bir bölüm ekle:
```markdown
## [1.1.0] - 2024-12-XX

### ✨ Yeni Özellikler
- Karanlık/Açık tema eklendi
- ...

### 🐛 Hata Düzeltmeleri
- ...
```

### 4. Git Commit ve Tag

```bash
# Dosyaları stage'e ekle
git add pubspec.yaml CHANGELOG.md

# Commit
git commit -m "chore: bump version to 1.1.0"

# Tag oluştur
git tag v1.1.0

# Push
git push origin main
git push origin v1.1.0
```

### 5. Build ve Release

```bash
# APK build
flutter build apk --release

# Web build
flutter build web --release --base-href="/studyvictory/"
```

### 6. GitHub Releases Oluştur

1. **https://github.com/Cezeri73/studyvictory/releases** → **"Create a new release"**
2. **Tag:** `v1.1.0` seç (veya yeni tag oluştur)
3. **Title:** `StudyVictory v1.1.0 - Yeni Özellikler`
4. **Description:** CHANGELOG.md'den kopyala
5. **APK Yükle:** `app-release.apk` dosyasını sürükle-bırak
6. **"Publish release"** tıkla

---

## 📅 Versiyon Geçmişi

| Versiyon | Tarih | Tip | Özellikler |
|----------|-------|-----|------------|
| 1.0.0 | 2024-12 | Initial | İlk sürüm |
| 1.1.0 | Planlanan | Minor | Tema seçeneği |
| 1.2.0 | Planlanan | Minor | Kategori hedefleri |
| 2.0.0 | Planlanan | Major | Sosyal özellikler |

---

## 🔍 Versiyon Kontrolü

**pubspec.yaml'dan kontrol et:**
```yaml
version: 1.0.0+1
```

**Git tag'lerinden kontrol et:**
```bash
git tag -l
```

**GitHub Releases'dan kontrol et:**
- https://github.com/Cezeri73/studyvictory/releases

---

## 💡 İpuçları

1. **Her değişiklik için CHANGELOG güncelle**
2. **Release yapmadan önce test et**
3. **Git tag'leri versiyonlarla senkronize tut**
4. **Build numarasını unutma** (CI/CD için önemli)
5. **Semantic Versioning'e sadık kal**

---

## 📚 Referanslar

- [Semantic Versioning](https://semver.org/)
- [Flutter Versioning](https://docs.flutter.dev/deployment/versioning)

---

**🎯 Özet:** Her yeni özellik/hata düzeltmesi için versiyon artır, CHANGELOG güncelle, tag oluştur, release yap!

