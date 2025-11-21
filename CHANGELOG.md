# 📋 Değişiklik Geçmişi (Changelog)

Tüm önemli değişiklikler bu dosyada dokümante edilecektir.

Bu proje [Semantic Versioning](https://semver.org/lang/tr/) kullanır:
- **MAJOR** (X.0.0): Geriye dönük uyumsuz API değişiklikleri
- **MINOR** (x.X.0): Geriye dönük uyumlu yeni özellikler
- **PATCH** (x.x.X): Geriye dönük uyumlu hata düzeltmeleri

---

## [1.0.0] - 2024-12-XX 🎉

### 🎉 İlk Sürüm (Initial Release)

#### ✨ Özellikler

**🎯 Odaklan ve Çalış**
- Pomodoro Timer (25 dakika çalışma + 5 dakika mola)
- Serbest Timer (sınırsız çalışma süresi)
- TYT/AYT/YDS/KPSS kategorileri
- Canlı dairesel progress bar ile görsel takip
- Timer başlat/durdur/bitir kontrolleri

**🏆 Gamification**
- XP Sistemi (Her dakika = 10 XP)
- Seviye Sistemi (Çırak → Uzman → Usta → Efsane)
- Streak (Arka arkaya çalışma günleri) takibi
- 8 farklı başarı rozeti sistemi
- Rozet bildirimleri

**📊 İstatistikler**
- Haftalık çalışma grafikleri (Son 7 gün)
- Kategori bazlı dağılım grafikleri (Pie Chart)
- Toplam çalışma süresi
- Ortalama ve maksimum çalışma süreleri
- Kategori bazlı istatistikler

**✅ Görev Yönetimi**
- TYT/AYT/YDS/KPSS odaklı hazır görev şablonları
- Hızlı görev ekleme
- Detaylı görev ekleme (kategori, öncelik, not, son tarih)
- Görev arama ve filtreleme
- Öncelik sıralaması
- Tamamlanan görevleri gizleme/gösterme

**🎯 Hedefler**
- Günlük çalışma hedefi belirleme
- Haftalık toplam hedef belirleme
- Hedef tamamlama yüzdesi takibi
- Görsel ilerleme göstergeleri

**⚙️ Ayarlar**
- Pomodoro süresini özelleştirme
- Mola süresini özelleştirme
- Ses efektleri açma/kapama
- Bildirimleri açma/kapama
- Veri dışa aktarma (JSON formatında)

**💬 Motivasyon**
- TYT/AYT/YDS/KPSS odaklı günlük motivasyon sözleri
- Başarı animasyonları
- İlerleme rozetleri

#### 🎨 Tasarım

- **Cyber-Focus UI** tasarım dili
- Koyu arka plan (#121212, #1E1E1E)
- Neon yeşil vurgular (#00E676)
- Cyber mavi aksanlar (#2979FF, #00BCD4)
- Modern, minimal arayüz
- Responsive tasarım

#### 📱 Platform Desteği

- ✅ Web (Chrome, Edge, Firefox)
- ✅ Android (5.0+)
- 🔜 iOS (yakında)

#### 🛠️ Teknolojiler

- Flutter 3.38.2
- Dart 3.10.0
- shared_preferences - Veri saklama
- fl_chart - Grafik ve istatistikler
- intl - Tarih formatlama
- url_launcher - URL açma

#### 📦 Dağıtım

- Web: https://cezeri73.github.io/studyvictory/
- APK İndirme: https://cezeri73.github.io/studyvictory/download.html
- GitHub Releases: https://github.com/Cezeri73/studyvictory/releases

---

## [1.1.0] - 2024-12-XX 🎉

### ✨ Yeni Özellikler

**🔄 Günlük Rutinler ve Hatırlatıcılar**
- **Rutin Oluşturma**: Kişiselleştirilmiş günlük rutinler oluşturma
- **Zamanlama**: Belirli saat ve günlerde rutin hatırlatıcıları
- **Çoklu Gün Seçimi**: Haftanın farklı günlerinde tekrarlayan rutinler
- **Hatırlatıcı Sistemi**: Rutin zamanından belirli dakika önce hatırlatma
- **Kategori Desteği**: TYT/AYT/YDS/KPSS ve ders bazlı rutinler
- **Aktif/Pasif Durumu**: Rutinleri aktif/pasif olarak yönetme
- **Günlük Rutin Listesi**: Bugünkü rutinleri öncelikli gösterim
- **Otomatik Kontrol**: Her dakika rutinleri kontrol eden sistem
- **Hatırlatıcı Bildirimleri**: Rutin zamanı geldiğinde görsel bildirim

### 🎨 UI İyileştirmeleri

- Rutinler ekranı için modern, kullanıcı dostu arayüz
- Günlük ve diğer rutinler için ayrı bölümler
- Rutin kartlarında görsel zaman ve kategori göstergeleri
- Ana ekrana rutinler butonu eklendi

### 🐛 Hata Düzeltmeleri

- Rutin sistemi için veri saklama optimizasyonu

---

## [1.2.0] - 2024-12-XX 🎉

### ✨ Yeni Özellikler

**📚 Konu Bazlı Öğrenme Takip Sistemi**

#### Konu Yönetimi
- ✅ Kişiselleştirilmiş konu ekleme (örn: "TYT Kimya - Asitler ve Bazlar")
- ✅ Kategori bazlı konu organizasyonu (TYT/AYT/YDS/KPSS/dersler)
- ✅ Durum yönetimi (Başlanmadı/Devam Ediyor/Tamamlandı)
- ✅ Konu bazlı notlar ve hatırlatıcılar

#### Hedef ve İlerleme Takibi
- ✅ Konu bazlı hedef belirleme (saat/dakika)
- ✅ Gerçek zamanlı ilerleme çubukları (% tamamlama)
- ✅ Renkli ilerleme göstergesi:
  - 🔴 Kırmızı: %0-50 (zayıf)
  - 🟠 Turuncu: %50-70
  - 🔵 Mavi: %70-99
  - 🟢 Yeşil: %100 (tamamlandı)
- ✅ Çalışılan süre ve hedef süre karşılaştırması

#### Analiz ve Motivasyon
- ✅ Zayıf/Güçlü konular otomatik tespiti
- ✅ Zayıf/Güçlü konu sayısı özeti
- ✅ Hedef tamamlama bildirimi (+100 XP)
- ✅ Konu bazlı çalışma süresi otomatik kaydı

#### FocusScreen Entegrasyonu
- ✅ Kategori seçildiğinde konu seçimi dropdown'u
- ✅ Konu bazlı çalışma oturumu kaydı
- ✅ Seçili konu görsel göstergesi
- ✅ İlerleme bilgisi ile konu seçimi

### 🎨 UI İyileştirmeleri

- Konularım ekranı için modern, kullanıcı dostu arayüz
- İlerleme çubukları ile görsel takip
- Durum rozetleri (Başlanmadı/Devam Ediyor/Tamamlandı)
- Kategori ve durum filtreleme
- Arama özelliği

### 🐛 Hata Düzeltmeleri

- Konu bazlı veri saklama optimizasyonu
- Timer bitince konu bazlı süre kaydı düzeltmesi

---

## [1.3.0] - 2024-12-XX 🎉

### ✨ Yeni Özellikler

**🎨 Tema Değiştirme Sistemi**
- ✅ **Karanlık Tema**: Koyu arka plan ile göz yormayan çalışma ortamı
- ✅ **Açık Tema**: Açık arka plan ile parlak ve temiz görünüm
- ✅ **Sistem Teması**: Cihazın tema ayarını otomatik takip eder
- ✅ **Anlık Tema Değişimi**: Tema seçildiğinde anında uygulanır
- ✅ **Tema Tercihini Saklama**: Seçilen tema otomatik olarak kaydedilir

### 🎨 UI İyileştirmeleri

- Ayarlar ekranına "Görünüm" bölümü eklendi
- Tema seçim dialogu (Karanlık/Açık/Sistem)
- Tema ikonu ve açıklamalar
- Mevcut tema durumunu gösteren subtitle

### 🐛 Hata Düzeltmeleri

- Tema değişikliği için uygulama yeniden başlatma gerektirmiyor

---

## [1.3.1] - 2024-12-XX 🎉

### ✨ Yeni Özellikler

**ℹ️ Hakkında Ekranı**
- ✅ Uygulama bilgileri (ad, versiyon, logo)
- ✅ Geliştirici bilgisi (Cezeri73)
- ✅ Kullanıcı istatistikleri:
  - XP, Seviye, Streak
  - Toplam çalışma süresi
  - Rozet sayısı
  - Konu, görev, rutin sayıları
  - Toplam oturum sayısı
- ✅ Linkler (Web, GitHub, License)
- ✅ Pull-to-refresh desteği
- ✅ Tema uyumlu tasarım

### 🎨 UI İyileştirmeleri

- Ayarlar ekranına "Hakkında" bölümü eklendi
- İstatistik kartları ile görsel gösterim
- Gradient arka planlar
- Responsive grid layout

### 🐛 Hata Düzeltmeleri

- Ayarlar ekranında görsel iyileştirmeler

---

## [Gelecek Versiyonlar] 🔮

### v1.4.0 (Planlanan)
- [ ] Daha fazla rozet
- [ ] Konu bazlı istatistikler ve grafikler
- [ ] Rutin istatistikleri ve takibi
- [ ] Push notification desteği
- [ ] Özelleştirilebilir renk paletleri

### v1.2.0 (Planlanan)
- [ ] Çalışma oturumları geçmişi detayları
- [ ] Export/Import özelliği
- [ ] Daha fazla istatistik grafiği
- [ ] Özelleştirilebilir kategoriler

### v2.0.0 (Planlanan)
- [ ] Sosyal özellikler (arkadaşlarla yarışma)
- [ ] Bulut senkronizasyonu
- [ ] Çoklu dil desteği
- [ ] Widget desteği (Android)

---

## 📝 Versiyon Güncelleme Talimatları

Yeni bir versiyon yayınlarken:

1. **pubspec.yaml** güncelle:
   ```yaml
   version: 1.1.0+2  # Version + Build Number
   ```

2. **CHANGELOG.md** güncelle:
   - Yeni versiyon bölümü ekle
   - Değişiklikleri listele

3. **Git commit:**
   ```bash
   git add pubspec.yaml CHANGELOG.md
   git commit -m "chore: bump version to 1.1.0"
   ```

4. **Git tag:**
   ```bash
   git tag v1.1.0
   git push origin main --tags
   ```

5. **Build ve Release:**
   - APK oluştur
   - GitHub Releases'a yükle
   - Release notlarını CHANGELOG'dan kopyala

---

**📌 Not:** Bu dosya tüm gelecek versiyonlar için güncellenecektir.

