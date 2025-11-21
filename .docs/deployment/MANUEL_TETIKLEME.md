# 🔧 GitHub Actions Manuel Tetikleme

## ✅ GitHub Actions Seçildi - Şimdi Ne Yapmalı?

### Adım 1: Actions Sekmesine Gidin

1. **GitHub Repository'ye gidin:**
   - https://github.com/Cezeri73/studyvictory

2. **Üst menüden "Actions" sekmesine tıklayın**

3. **Sol menüden "Deploy to GitHub Pages" workflow'unu seçin**

### Adım 2: Workflow'u Manuel Tetikleyin

1. **Sağ üstte "Run workflow" butonunu görüyorsanız:**
   - Tıklayın
   - Branch: `main` seçili olsun
   - **"Run workflow"** butonuna tıklayın

2. **Workflow çalışacak:**
   - Build aşaması (2-3 dakika)
   - Deploy aşaması (1 dakika)
   - Toplam: 3-4 dakika

### Adım 3: İlerlemeyi İzleyin

1. **Workflow listesinde en üstteki çalışmayı göreceksiniz**
2. **Tıklayıp detayları görebilirsiniz:**
   - ✅ Yeşil tik = Başarılı
   - ❌ Kırmızı X = Hata var
   - 🟡 Sarı nokta = Devam ediyor

### Adım 4: Bekleyin

- **3-4 dakika bekleyin**
- Workflow tamamlandığında deploy edilecek

---

## 🔍 Sorun Giderme

### Workflow Çalışmıyor/Çalıştırılmıyor:

1. **Settings → Actions → General** kontrol edin
2. **"Workflow permissions"** bölümünde:
   - ✅ **"Read and write permissions"** seçili olmalı
   - ✅ **"Allow GitHub Actions to create and approve pull requests"** işaretli olmalı
3. **Save** tıklayın

### Workflow Başarısız Oluyor:

1. **Actions** sekmesine gidin
2. **Başarısız workflow'u tıklayın**
3. **Hata mesajını okuyun**
4. **Genellikle base-href veya build hatası olabilir**

### Sayfa Hala Değişmedi:

1. **Tarayıcı cache'ini temizleyin:** Ctrl + Shift + R
2. **Gizli modda deneyin**
3. **5-10 dakika bekleyin** (GitHub Pages cache'i temizleniyor olabilir)
4. **Hard refresh:** Ctrl + F5

---

## ✅ Kontrol Listesi

- [x] GitHub Actions seçildi
- [x] Workflow dosyası güncellendi (base-href eklendi)
- [ ] Workflow manuel olarak çalıştırıldı
- [ ] Workflow başarılı oldu (✅ yeşil tik)
- [ ] 3-4 dakika beklendi
- [ ] Tarayıcı cache'i temizlendi
- [ ] Uygulama web'de çalışıyor!

---

**💡 İpucu:** En güvenilir yol workflow'u manuel olarak "Run workflow" ile tetiklemek!

