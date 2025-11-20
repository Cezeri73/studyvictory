import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:math' as math;

void main() {
  runApp(const StudyVictoryApp());
}

class StudyVictoryApp extends StatelessWidget {
  const StudyVictoryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StudyVictory - TYT/AYT/YDS/KPSS',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF121212),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF00E676), // Neon Yeşil
          secondary: Color(0xFF2979FF), // Siber Mavi
          surface: Color(0xFF1E1E1E),
        ),
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  void _navigateToTasks(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const TasksScreen()),
    );
  }

  void _navigateToSettings(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SettingsScreen()),
    );
  }

  void _showMenu() {
    // Menu callback
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          FocusScreen(onMenuTap: _showMenu), // Odaklan Ekranı
          const StatsScreen(), // İstatistikler Ekranı
          const AchievementsScreen(), // Başarılarım Ekranı
          const GoalsScreen(), // Hedefler Ekranı
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (index) {
          if (index < 4) {
            setState(() {
              _selectedIndex = index;
            });
          }
        },
        backgroundColor: const Color(0xFF1E1E1E),
        selectedItemColor: const Color(0xFF00E676),
        unselectedItemColor: Colors.grey,
        selectedFontSize: 12,
        unselectedFontSize: 11,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.timer_outlined),
            activeIcon: Icon(Icons.timer),
            label: 'Odaklan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart_outlined),
            activeIcon: Icon(Icons.bar_chart),
            label: 'İstatistikler',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_events_outlined),
            activeIcon: Icon(Icons.emoji_events),
            label: 'Rozetler',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.flag_outlined),
            activeIcon: Icon(Icons.flag),
            label: 'Hedefler',
          ),
        ],
      ),
      appBar: AppBar(
        title: const Text('StudyVictory - TYT/AYT/YDS/KPSS', style: TextStyle(color: Colors.white, fontSize: 18)),
        backgroundColor: const Color(0xFF1E1E1E),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.checklist, color: Colors.white),
            onPressed: () => _navigateToTasks(context),
            tooltip: 'Görevler',
          ),
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () => _navigateToSettings(context),
            tooltip: 'Ayarlar',
          ),
        ],
      ),
    );
  }
}

// TYT-AYT-YDS-KPSS Motivasyon Sözleri
final List<String> motivationQuotes = [
  '🎯 Bugün çalışmadığın her konu, sınavda soru olarak karşına çıkar!',
  '📚 Her deneme, gerçek sınavda bir puan fazladır!',
  '💪 TYT/AYT seni bekliyor, bugün de çalışmalısın!',
  '🔥 Azim ve disiplin, tüm başarıların anahtarıdır!',
  '⚡ Bugün çalış, yarın rahat et!',
  '🎓 Her gün bir konu, her hafta bir test, her ay bir deneme!',
  '📖 Bugünün çalışması, yarının başarısıdır!',
  '🏆 Başarılı olanlar, pes etmeyenlerdir!',
  '💯 Her soru çözümü, hayalindeki üniversiteye bir adım daha!',
  '🚀 TYT/AYT/YDS/KPSS - Sen bunu başarabilirsin!',
  '✨ Bugün disiplinli ol, yarın gururlu ol!',
  '🎯 Hedefin belli, şimdi sıra çalışmada!',
];

String getRandomMotivationQuote() {
  final random = math.Random();
  return motivationQuotes[random.nextInt(motivationQuotes.length)];
}

// TYT-AYT-YDS-KPSS Kategorileri
final List<Map<String, dynamic>> categories = [
  {'id': 'tyt', 'name': 'TYT', 'icon': Icons.school, 'color': const Color(0xFF2979FF), 'description': 'Temel Yeterlilik Testi'},
  {'id': 'ayt', 'name': 'AYT', 'icon': Icons.psychology, 'color': const Color(0xFF00E676), 'description': 'Alan Yeterlilik Testi'},
  {'id': 'yds', 'name': 'YDS', 'icon': Icons.translate, 'color': const Color(0xFFFF6B6B), 'description': 'Yabancı Dil Sınavı'},
  {'id': 'kpss', 'name': 'KPSS', 'icon': Icons.work, 'color': const Color(0xFFFFA726), 'description': 'Kamu Personeli Seçme Sınavı'},
  {'id': 'math', 'name': 'Matematik', 'icon': Icons.calculate, 'color': const Color(0xFF2979FF), 'description': 'Matematik Çalışmaları'},
  {'id': 'turkish', 'name': 'Türkçe', 'icon': Icons.menu_book, 'color': const Color(0xFFAB47BC), 'description': 'Türkçe Çalışmaları'},
  {'id': 'history', 'name': 'Tarih', 'icon': Icons.history_edu, 'color': const Color(0xFF4ECDC4), 'description': 'Tarih Çalışmaları'},
  {'id': 'geography', 'name': 'Coğrafya', 'icon': Icons.public, 'color': const Color(0xFF66BB6A), 'description': 'Coğrafya Çalışmaları'},
  {'id': 'physics', 'name': 'Fizik', 'icon': Icons.science, 'color': const Color(0xFF00E676), 'description': 'Fizik Çalışmaları'},
  {'id': 'chemistry', 'name': 'Kimya', 'icon': Icons.biotech, 'color': const Color(0xFFFF6B6B), 'description': 'Kimya Çalışmaları'},
  {'id': 'biology', 'name': 'Biyoloji', 'icon': Icons.eco, 'color': const Color(0xFF4ECDC4), 'description': 'Biyoloji Çalışmaları'},
  {'id': 'other', 'name': 'Diğer', 'icon': Icons.category, 'color': Colors.grey, 'description': 'Diğer Çalışmalar'},
];

class FocusScreen extends StatefulWidget {
  final VoidCallback? onMenuTap;
  const FocusScreen({super.key, this.onMenuTap});

  @override
  State<FocusScreen> createState() => _FocusScreenState();
}

class _FocusScreenState extends State<FocusScreen> {
  Duration _elapsed = Duration.zero;
  bool _isRunning = false;
  DateTime? _startTime;
  Timer? _timer;
  double _totalHours = 0.0;
  int _xp = 0;
  int _streak = 0;
  
  // Pomodoro
  bool _isPomodoroMode = false;
  int _pomodoroMinutes = 25;
  int _pomodoroSeconds = 0;
  bool _isBreakTime = false;
  int _breakMinutes = 5;
  String? _selectedCategory;
  
  // Motivasyon
  String _motivationQuote = '';

  @override
  void initState() {
    super.initState();
    _loadData();
    _motivationQuote = getRandomMotivationQuote();
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    final totalSeconds = prefs.getInt('total_seconds') ?? 0;
    final xp = prefs.getInt('xp') ?? 0;
    final streak = prefs.getInt('streak') ?? 0;
    final isPomodoro = prefs.getBool('pomodoro_mode') ?? false;
    
    setState(() {
      _totalHours = totalSeconds / 3600.0;
      _xp = xp;
      _streak = streak;
      _isPomodoroMode = isPomodoro;
      if (_isPomodoroMode) {
        _pomodoroMinutes = prefs.getInt('pomodoro_minutes') ?? 25;
        _breakMinutes = prefs.getInt('break_minutes') ?? 5;
      }
    });
  }

  Future<void> _updateTotalHours(int seconds) async {
    final prefs = await SharedPreferences.getInstance();
    final currentTotal = prefs.getInt('total_seconds') ?? 0;
    await prefs.setInt('total_seconds', currentTotal + seconds);
    
    // XP kazan (her dakika = 10 XP)
    final xpGained = (seconds / 60).floor() * 10;
    final currentXP = prefs.getInt('xp') ?? 0;
    await prefs.setInt('xp', currentXP + xpGained);
    
    // Streak güncelle
    await _updateStreak();
    
    // Rozet kontrolü
    await _checkBadges();
    
    await _loadData();
  }

  Future<void> _updateStreak() async {
    final prefs = await SharedPreferences.getInstance();
    final lastStudyDate = prefs.getString('last_study_date');
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    
    if (lastStudyDate == today) {
      // Bugün zaten çalışıldı
      return;
    }
    
    final yesterday = DateFormat('yyyy-MM-dd').format(DateTime.now().subtract(const Duration(days: 1)));
    final currentStreak = prefs.getInt('streak') ?? 0;
    
    if (lastStudyDate == yesterday) {
      // Streak devam ediyor
      await prefs.setInt('streak', currentStreak + 1);
    } else if (lastStudyDate == null || lastStudyDate != today) {
      // Yeni streak başlıyor
      await prefs.setInt('streak', 1);
    }
    
    await prefs.setString('last_study_date', today);
  }

  Future<void> _checkBadges() async {
    final prefs = await SharedPreferences.getInstance();
    final badges = prefs.getStringList('badges') ?? [];
    final totalSeconds = prefs.getInt('total_seconds') ?? 0;
    final totalHours = totalSeconds / 3600.0;
    final streak = prefs.getInt('streak') ?? 0;
    final sessions = prefs.getStringList('sessions') ?? [];
    
    // Rozet kontrolü
    if (!badges.contains('first_10_hours') && totalHours >= 10) {
      badges.add('first_10_hours');
      _showBadgeNotification('İlk 10 Saat!', 'İlk 10 saatini tamamladın! 🎉');
    }
    if (!badges.contains('first_50_hours') && totalHours >= 50) {
      badges.add('first_50_hours');
      _showBadgeNotification('50 Saat Tamamlandı!', 'Harika iş çıkardın! 🌟');
    }
    if (!badges.contains('streak_7') && streak >= 7) {
      badges.add('streak_7');
      _showBadgeNotification('7 Gün Streak!', '7 gün üst üste çalıştın! 🔥');
    }
    if (!badges.contains('streak_30') && streak >= 30) {
      badges.add('streak_30');
      _showBadgeNotification('30 Gün Maratoncu!', 'İnanılmaz bir disiplin! 💪');
    }
    if (!badges.contains('early_bird') && _isEarlyMorning()) {
      badges.add('early_bird');
      _showBadgeNotification('Erkenci Kuş!', 'Sabah erkenden çalıştın! 🐦');
    }
    if (!badges.contains('night_owl') && _isNightTime()) {
      badges.add('night_owl');
      _showBadgeNotification('Gece Kuşu!', 'Gece geç saatlerde çalıştın! 🦉');
    }
    if (!badges.contains('first_session') && sessions.isNotEmpty) {
      badges.add('first_session');
    }
    if (!badges.contains('week_warrior') && _checkWeeklyGoal()) {
      badges.add('week_warrior');
      _showBadgeNotification('Haftalık Savaşçı!', 'Bu hafta hedefini aştın! ⚔️');
    }
    
    await prefs.setStringList('badges', badges);
  }

  bool _isEarlyMorning() {
    final hour = DateTime.now().hour;
    return hour >= 5 && hour < 8;
  }

  bool _isNightTime() {
    final hour = DateTime.now().hour;
    return hour >= 22 || hour < 2;
  }

  bool _checkWeeklyGoal() {
    // Haftalık hedef kontrolü (basit versiyon)
    return false; // Detaylı implementasyon GoalsScreen'de
  }

  void _showBadgeNotification(String title, String message) {
    if (mounted) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: const Color(0xFF1E1E1E),
          title: Row(
            children: [
              const Icon(Icons.emoji_events, color: Color(0xFF00E676), size: 32),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ],
          ),
          content: Text(
            message,
            style: TextStyle(color: Colors.grey[300], fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Harika!', style: TextStyle(color: Color(0xFF00E676))),
            ),
          ],
        ),
      );
    }
  }

  String _getLevel() {
    if (_totalHours < 10) return 'Çırak';
    if (_totalHours < 50) return 'Uzman';
    if (_totalHours < 100) return 'Usta';
    return 'Efsane';
  }

  IconData _getLevelIcon() {
    if (_totalHours < 10) return Icons.star_outline;
    if (_totalHours < 50) return Icons.star;
    if (_totalHours < 100) return Icons.stars;
    return Icons.auto_awesome;
  }

  Color _getLevelColor() {
    if (_totalHours < 10) return Colors.grey;
    if (_totalHours < 50) return const Color(0xFF2979FF);
    if (_totalHours < 100) return const Color(0xFF00E676);
    return const Color(0xFFFFD700);
  }

  void _togglePomodoroMode() {
    setState(() {
      _isPomodoroMode = !_isPomodoroMode;
      if (!_isPomodoroMode) {
        _isBreakTime = false;
        _pomodoroMinutes = 25;
        _pomodoroSeconds = 0;
      }
    });
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool('pomodoro_mode', _isPomodoroMode);
    });
  }

  Future<void> _startTimer() async {
    try {
      // Eğer zaten çalışıyorsa, bir şey yapma
      if (_isRunning) return;
      
      // Eğer durdurulmuş timer varsa (_elapsed > 0 veya Pomodoro değerleri sıfır değilse), kaldığı yerden devam et
      final hasResumeValue = !_isPomodoroMode && _elapsed.inSeconds > 0;
      final hasPomodoroResumeValue = _isPomodoroMode && (_pomodoroMinutes > 0 || _pomodoroSeconds > 0);
      
      if (!hasResumeValue && !hasPomodoroResumeValue) {
        // Yeni timer başlat (sıfırdan)
        if (_isPomodoroMode) {
          final prefs = await SharedPreferences.getInstance();
          setState(() {
            if (_isBreakTime) {
              _pomodoroMinutes = _breakMinutes;
            } else {
              _pomodoroMinutes = prefs.getInt('pomodoro_minutes') ?? 25;
            }
            _pomodoroSeconds = 0;
            _elapsed = Duration.zero;
          });
        } else {
          setState(() {
            _elapsed = Duration.zero;
          });
        }
      }
      
      // Timer'ı başlat (kaldığı yerden veya sıfırdan)
      setState(() {
        _isRunning = true;
        if (_elapsed.inSeconds == 0) {
          _startTime = DateTime.now();
        }
      });
      
      _timer?.cancel();
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (!mounted) {
          timer.cancel();
          return;
        }
        
        if (_isPomodoroMode) {
          setState(() {
            if (_pomodoroSeconds > 0) {
              _pomodoroSeconds--;
            } else {
              if (_pomodoroMinutes > 0) {
                _pomodoroMinutes--;
                _pomodoroSeconds = 59;
              } else {
                // Pomodoro bitti
                timer.cancel();
                _onPomodoroComplete();
                return;
              }
            }
            _elapsed = Duration(seconds: _elapsed.inSeconds + 1);
          });
        } else {
          setState(() {
            _elapsed = Duration(seconds: _elapsed.inSeconds + 1);
          });
        }
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Hata: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _onPomodoroComplete() async {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
    });
    
    if (!_isBreakTime) {
      // Çalışma süresi bitti, mola zamanı
      if (mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: const Color(0xFF1E1E1E),
            title: const Text('🎉 Pomodoro Tamamlandı!', style: TextStyle(color: Colors.white)),
            content: Text(
              '25 dakika odaklı çalışma tamamlandı. Mola zamanı!',
              style: TextStyle(color: Colors.grey[300]),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  setState(() {
                    _isBreakTime = true;
                    _pomodoroMinutes = _breakMinutes;
                    _pomodoroSeconds = 0;
                  });
                },
                child: const Text('Mola Al', style: TextStyle(color: Color(0xFF00E676))),
              ),
            ],
          ),
        );
      }
    } else {
      // Mola bitti, tekrar çalışma zamanı
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Mola tamamlandı, tekrar çalışma zamanı! 💪'),
            backgroundColor: Color(0xFF2979FF),
            duration: Duration(seconds: 2),
          ),
        );
      }
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        _isBreakTime = false;
        _pomodoroMinutes = prefs.getInt('pomodoro_minutes') ?? 25;
        _pomodoroSeconds = 0;
      });
    }
  }

  void _pauseTimer() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
    });
  }

  Future<void> _stopTimer() async {
    if (_elapsed.inSeconds > 0) {
      final prefs = await SharedPreferences.getInstance();
      final sessions = prefs.getStringList('sessions') ?? [];
      
      final sessionData = {
        'date': DateTime.now().toIso8601String(),
        'duration': _elapsed.inSeconds,
        'category': _selectedCategory ?? 'other',
      };
      
      sessions.insert(0, jsonEncode(sessionData));
      await prefs.setStringList('sessions', sessions);
      await _updateTotalHours(_elapsed.inSeconds);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${_formatDuration(_elapsed)} kaydedildi! +${(_elapsed.inMinutes * 10)} XP 🎉'),
            backgroundColor: const Color(0xFF00E676),
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
    
    _timer?.cancel();
    final prefsForReset = await SharedPreferences.getInstance();
    setState(() {
      _isRunning = false;
      _elapsed = Duration.zero;
      _startTime = null;
      if (_isPomodoroMode) {
        _pomodoroMinutes = prefsForReset.getInt('pomodoro_minutes') ?? 25;
        _pomodoroSeconds = 0;
        _isBreakTime = false;
      }
    });
  }

  String _formatDuration(Duration duration) {
    final hours = duration.inHours.toString().padLeft(2, '0');
    final minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$hours:$minutes:$seconds';
  }

  String _formatPomodoroTime() {
    final minutes = _pomodoroMinutes.toString().padLeft(2, '0');
    final seconds = _pomodoroSeconds.toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  // SharedPreferences referansı için
  SharedPreferences? prefs;

  @override
  Widget build(BuildContext context) {
    final totalSeconds = _isPomodoroMode && _isRunning
        ? (_pomodoroMinutes * 60 + _pomodoroSeconds)
        : _elapsed.inSeconds;
    
    final maxSeconds = _isPomodoroMode 
        ? (_pomodoroMinutes * 60)
        : 3600;
    
    final progress = maxSeconds > 0 ? 1.0 - (totalSeconds / maxSeconds) : 0.0;
    final displayTime = _isPomodoroMode && _isRunning 
        ? _formatPomodoroTime()
        : _formatDuration(_elapsed);

    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          prefs = snapshot.data;
          if (_isPomodoroMode && _pomodoroMinutes == 25) {
            _pomodoroMinutes = prefs?.getInt('pomodoro_minutes') ?? 25;
          }
        }
        
        return Scaffold(
          appBar: AppBar(
            title: const Text('⏱️ Odaklan ve Çalış', style: TextStyle(color: Colors.white)),
            backgroundColor: const Color(0xFF1E1E1E),
            elevation: 0,
            centerTitle: true,
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(_getLevelIcon(), color: _getLevelColor(), size: 20),
                    const SizedBox(width: 4),
                    Text(
                      _getLevel(),
                      style: TextStyle(
                        color: _getLevelColor(),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Motivasyon Sözü
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFF2979FF).withOpacity(0.2),
                          const Color(0xFF00E676).withOpacity(0.2),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xFF2979FF).withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.format_quote, color: Color(0xFF00E676), size: 24),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            _motivationQuote,
                            style: TextStyle(
                              color: Colors.grey[200],
                              fontSize: 14,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // XP ve Streak Kartları
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1E1E1E),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: const Color(0xFF00E676).withOpacity(0.3),
                              width: 1,
                            ),
                          ),
                          child: Column(
                            children: [
                              const Icon(Icons.stars, color: Color(0xFF00E676), size: 24),
                              const SizedBox(height: 8),
                              Text(
                                '$_xp XP',
                                style: const TextStyle(
                                  color: Color(0xFF00E676),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Deneyim',
                                style: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1E1E1E),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: const Color(0xFFFF6B6B).withOpacity(0.3),
                              width: 1,
                            ),
                          ),
                          child: Column(
                            children: [
                              const Icon(Icons.local_fire_department, color: Color(0xFFFF6B6B), size: 24),
                              const SizedBox(height: 8),
                              Text(
                                '$_streak',
                                style: const TextStyle(
                                  color: Color(0xFFFF6B6B),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Gün Streak',
                                style: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  // Kategori Seçimi
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        final isSelected = _selectedCategory == category['id'];
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedCategory = category['id'] as String;
                            });
                          },
                          child: Container(
                            width: 80,
                            margin: const EdgeInsets.only(right: 12),
                            decoration: BoxDecoration(
                              color: isSelected 
                                  ? (category['color'] as Color).withOpacity(0.2)
                                  : const Color(0xFF1E1E1E),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isSelected 
                                    ? category['color'] as Color
                                    : Colors.grey.withOpacity(0.2),
                                width: isSelected ? 2 : 1,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  category['icon'] as IconData,
                                  color: isSelected ? category['color'] as Color : Colors.grey,
                                  size: 32,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  category['name'] as String,
                                  style: TextStyle(
                                    color: isSelected ? category['color'] as Color : Colors.grey,
                                    fontSize: 10,
                                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Pomodoro Toggle
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Serbest Timer', style: TextStyle(color: Colors.grey)),
                      Switch(
                        value: _isPomodoroMode,
                        onChanged: _isRunning ? null : (value) => _togglePomodoroMode(),
                        activeColor: const Color(0xFF00E676),
                      ),
                      const Text('Pomodoro', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                  const SizedBox(height: 24),
                  
                  // Toplam saat bilgisi
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E1E1E),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xFF2979FF).withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Toplam Çalışma',
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${_totalHours.toStringAsFixed(1)} Saat',
                          style: const TextStyle(
                            color: Color(0xFF2979FF),
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  
                  // Sayaç (Dairesel Progress kaldırıldı - dikkat dağıtıcıydı)
                  SizedBox(
                    width: 280,
                    height: 280,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          displayTime,
                          style: TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            color: _isPomodoroMode && _isBreakTime 
                                ? const Color(0xFF2979FF)
                                : const Color(0xFF00E676),
                            letterSpacing: 2,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _isPomodoroMode
                              ? (_isBreakTime ? 'Mola Zamanı 🎉' : 'Pomodoro')
                              : (_isRunning ? 'Çalışıyor...' : 'Hazır'),
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[400],
                          ),
                        ),
                          if (_isPomodoroMode && _isRunning)
                          Text(
                            '${(_isBreakTime ? _breakMinutes : _pomodoroMinutes)} dakika',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[500],
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  
                  // Butonlar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (!_isRunning && _elapsed.inSeconds == 0)
                        ElevatedButton.icon(
                          onPressed: () => _startTimer(),
                          icon: const Icon(Icons.play_arrow),
                          label: Text(_isPomodoroMode ? 'Pomodoro Başlat' : 'Başla'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF00E676),
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 16,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        )
                      else if (_isRunning)
                        ElevatedButton.icon(
                          onPressed: _pauseTimer,
                          icon: const Icon(Icons.pause),
                          label: const Text('Durdur'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2979FF),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 16,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        )
                      else
                        Row(
                          children: [
                            ElevatedButton.icon(
                              onPressed: () => _startTimer(),
                              icon: const Icon(Icons.play_arrow),
                              label: const Text('Devam'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF00E676),
                                foregroundColor: Colors.black,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            ElevatedButton.icon(
                              onPressed: _stopTimer,
                              icon: const Icon(Icons.stop),
                              label: const Text('Bitir'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red[700],
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// İstatistikler Ekranı
class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  double _totalHours = 0.0;
  List<Map<String, dynamic>> _sessions = [];
  Map<String, double> _categoryStats = {};
  List<double> _weeklyHours = List.filled(7, 0.0);

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    final totalSeconds = prefs.getInt('total_seconds') ?? 0;
    final sessionsJson = prefs.getStringList('sessions') ?? [];
    final sessions = sessionsJson
        .map((json) => jsonDecode(json) as Map<String, dynamic>)
        .toList();
    
    // Kategori istatistikleri
    final categoryStats = <String, double>{};
    for (final category in categories) {
      categoryStats[category['id']] = 0.0;
    }
    
    for (final session in sessions) {
      final category = session['category'] as String? ?? 'other';
      final duration = (session['duration'] as int) / 3600.0;
      categoryStats[category] = (categoryStats[category] ?? 0.0) + duration;
    }
    
    // Haftalık istatistikler
    final weeklyHours = List.filled(7, 0.0);
    final now = DateTime.now();
    for (int i = 0; i < 7; i++) {
      final date = now.subtract(Duration(days: 6 - i));
      final dateStr = DateFormat('yyyy-MM-dd').format(date);
      
      for (final session in sessions) {
        final sessionDate = DateTime.parse(session['date'] as String);
        final sessionDateStr = DateFormat('yyyy-MM-dd').format(sessionDate);
        
        if (sessionDateStr == dateStr) {
          weeklyHours[i] += (session['duration'] as int) / 3600.0;
        }
      }
    }
    
    setState(() {
      _totalHours = totalSeconds / 3600.0;
      _sessions = sessions;
      _categoryStats = categoryStats;
      _weeklyHours = weeklyHours;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('📊 Çalışma İstatistikleri', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF1E1E1E),
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadData,
            tooltip: 'Yenile',
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _loadData,
        color: const Color(0xFF00E676),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Haftalık Grafik
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1E1E),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xFF2979FF).withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Son 7 Gün',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 200,
                      child: BarChart(
                        BarChartData(
                          alignment: BarChartAlignment.spaceAround,
                          maxY: _weeklyHours.isEmpty 
                              ? 5.0 
                              : (_weeklyHours.reduce((a, b) => a > b ? a : b) * 1.2).ceilToDouble().clamp(1.0, 10.0),
                          barGroups: List.generate(7, (index) {
                            final days = ['Pzt', 'Sal', 'Çar', 'Per', 'Cum', 'Cmt', 'Paz'];
                            return BarChartGroupData(
                              x: index,
                              barRods: [
                                BarChartRodData(
                                  toY: _weeklyHours[index],
                                  color: const Color(0xFF00E676),
                                  width: 20,
                                  borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                                ),
                              ],
                            );
                          }),
                          titlesData: FlTitlesData(
                            leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (value, meta) {
                                  final days = ['Pzt', 'Sal', 'Çar', 'Per', 'Cum', 'Cmt', 'Paz'];
                                  if (value.toInt() >= 0 && value.toInt() < 7) {
                                    return Text(
                                      days[value.toInt()],
                                      style: TextStyle(
                                        color: Colors.grey[400],
                                        fontSize: 12,
                                      ),
                                    );
                                  }
                                  return const Text('');
                                },
                              ),
                            ),
                          ),
                          gridData: const FlGridData(show: false),
                          borderData: FlBorderData(show: false),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              
              // Kategori Dağılımı
              const Text(
                'Kategori Dağılımı',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              ...categories.map((category) {
                final hours = _categoryStats[category['id']] ?? 0.0;
                final percentage = _totalHours > 0 ? (hours / _totalHours * 100) : 0.0;
                
                if (hours == 0) return const SizedBox.shrink();
                
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E1E1E),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: (category['color'] as Color).withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(category['icon'] as IconData, color: category['color'] as Color, size: 20),
                              const SizedBox(width: 8),
                              Text(
                                category['name'] as String,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            '${hours.toStringAsFixed(1)}s (${percentage.toStringAsFixed(1)}%)',
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      LinearProgressIndicator(
                        value: percentage / 100,
                        backgroundColor: Colors.grey[800],
                        valueColor: AlwaysStoppedAnimation<Color>(category['color'] as Color),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

// Başarılar/Rozetler Ekranı
class AchievementsScreen extends StatefulWidget {
  const AchievementsScreen({super.key});

  @override
  State<AchievementsScreen> createState() => _AchievementsScreenState();
}

class _AchievementsScreenState extends State<AchievementsScreen> {
  double _totalHours = 0.0;
  List<Map<String, dynamic>> _sessions = [];
  List<String> _badges = [];
  int _xp = 0;
  int _streak = 0;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    final totalSeconds = prefs.getInt('total_seconds') ?? 0;
    final sessionsJson = prefs.getStringList('sessions') ?? [];
    final sessions = sessionsJson
        .map((json) => jsonDecode(json) as Map<String, dynamic>)
        .toList();
    final badges = prefs.getStringList('badges') ?? [];
    final xp = prefs.getInt('xp') ?? 0;
    final streak = prefs.getInt('streak') ?? 0;
    
    setState(() {
      _totalHours = totalSeconds / 3600.0;
      _sessions = sessions;
      _badges = badges;
      _xp = xp;
      _streak = streak;
    });
  }

  final Map<String, Map<String, dynamic>> badgeDefinitions = {
    'first_session': {
      'name': 'İlk Adım',
      'description': 'İlk çalışma oturumunu tamamladın',
      'icon': Icons.play_arrow,
      'color': Color(0xFF00E676),
    },
    'first_10_hours': {
      'name': 'İlk 10 Saat',
      'description': '10 saat çalışma tamamladın',
      'icon': Icons.star,
      'color': Color(0xFF2979FF),
    },
    'first_50_hours': {
      'name': '50 Saat Ustası',
      'description': '50 saat çalışma tamamladın',
      'icon': Icons.stars,
      'color': Color(0xFFFFD700),
    },
    'streak_7': {
      'name': '7 Gün Streak',
      'description': '7 gün üst üste çalıştın',
      'icon': Icons.local_fire_department,
      'color': Color(0xFFFF6B6B),
    },
    'streak_30': {
      'name': '30 Gün Maratoncu',
      'description': '30 gün üst üste çalıştın',
      'icon': Icons.auto_awesome,
      'color': Color(0xFFFFD700),
    },
    'early_bird': {
      'name': 'Erkenci Kuş',
      'description': 'Sabah erkenden çalıştın',
      'icon': Icons.wb_sunny,
      'color': Color(0xFFFFA726),
    },
    'night_owl': {
      'name': 'Gece Kuşu',
      'description': 'Gece geç saatlerde çalıştın',
      'icon': Icons.nightlight_round,
      'color': Color(0xFF6C5CE7),
    },
    'week_warrior': {
      'name': 'Haftalık Savaşçı',
      'description': 'Haftalık hedefini aştın',
      'icon': Icons.emoji_events,
      'color': Color(0xFF00E676),
    },
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🏆 Başarılarım ve Rozetler', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF1E1E1E),
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadData,
            tooltip: 'Yenile',
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _loadData,
        color: const Color(0xFF00E676),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Toplam İstatistikler Kartı
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF2979FF),
                      Color(0xFF00E676),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF00E676).withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Icon(
                      Icons.emoji_events,
                      color: Colors.white,
                      size: 48,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Toplam Çalışma Süresi',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${_totalHours.toStringAsFixed(2)} Saat',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text(
                              '$_xp',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text(
                              'XP',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              '$_streak',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text(
                              'Gün Streak',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              '${_badges.length}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text(
                              'Rozet',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              
              // Rozetler
              const Text(
                'Rozetler',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.2,
                ),
                itemCount: badgeDefinitions.length,
                itemBuilder: (context, index) {
                  final badgeId = badgeDefinitions.keys.elementAt(index);
                  final badge = badgeDefinitions[badgeId]!;
                  final isUnlocked = _badges.contains(badgeId);
                  
                  return Container(
                    decoration: BoxDecoration(
                      color: isUnlocked 
                          ? (badge['color'] as Color).withOpacity(0.2)
                          : const Color(0xFF1E1E1E),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isUnlocked 
                            ? badge['color'] as Color
                            : Colors.grey.withOpacity(0.2),
                        width: isUnlocked ? 2 : 1,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          badge['icon'] as IconData,
                          color: isUnlocked 
                              ? badge['color'] as Color
                              : Colors.grey,
                          size: 40,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          badge['name'] as String,
                          style: TextStyle(
                            color: isUnlocked 
                                ? Colors.white
                                : Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          badge['description'] as String,
                          style: TextStyle(
                            color: isUnlocked 
                                ? Colors.grey[300]
                                : Colors.grey[600],
                            fontSize: 10,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (!isUnlocked)
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Icon(
                              Icons.lock,
                              color: Colors.grey[700],
                              size: 16,
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),
              
              // Geçmiş Oturumlar
              const Text(
                'Son Oturumlar',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              
              if (_sessions.isEmpty)
                Container(
                  padding: const EdgeInsets.all(48),
                  child: Column(
                    children: [
                      Icon(
                        Icons.inbox_outlined,
                        size: 64,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Henüz oturum yok',
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                )
              else
                ..._sessions.take(10).map((session) {
                  final duration = session['duration'] as int;
                  final dateStr = session['date'] as String;
                  final category = categories.firstWhere(
                    (c) => c['id'] == (session['category'] as String? ?? 'other'),
                    orElse: () => categories.last,
                  );
                  
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E1E1E),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: (category['color'] as Color).withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: (category['color'] as Color).withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            category['icon'] as IconData,
                            color: category['color'] as Color,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _formatDate(dateStr),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Text(
                                    category['name'] as String,
                                    style: TextStyle(
                                      color: Colors.grey[400],
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    '• ${_formatDurationFromSeconds(duration)}',
                                    style: TextStyle(
                                      color: Colors.grey[400],
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Text(
                          '${(duration / 60).floor()}dk',
                          style: TextStyle(
                            color: (category['color'] as Color),
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(String isoDate) {
    try {
      final date = DateTime.parse(isoDate);
      final now = DateTime.now();
      final difference = now.difference(date);
      
      if (difference.inDays == 0) {
        return 'Bugün';
      } else if (difference.inDays == 1) {
        return 'Dün';
      } else if (difference.inDays < 7) {
        return '${difference.inDays} gün önce';
      } else {
        return DateFormat('d MMMM', 'tr_TR').format(date);
      }
    } catch (e) {
      return 'Bilinmeyen tarih';
    }
  }

  String _formatDurationFromSeconds(int seconds) {
    final hours = (seconds / 3600).floor();
    final minutes = ((seconds % 3600) / 60).floor();
    
    if (hours > 0) {
      return '${hours}s ${minutes}d';
    } else {
      return '${minutes}d';
    }
  }
}

// Hedefler Ekranı
class GoalsScreen extends StatefulWidget {
  const GoalsScreen({super.key});

  @override
  State<GoalsScreen> createState() => _GoalsScreenState();
}

class _GoalsScreenState extends State<GoalsScreen> {
  double _dailyGoal = 2.0; // Saat cinsinden
  double _weeklyGoal = 10.0;
  double _todayProgress = 0.0;
  double _weekProgress = 0.0;

  @override
  void initState() {
    super.initState();
    _loadGoals();
    _loadProgress();
  }

  Future<void> _loadGoals() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _dailyGoal = prefs.getDouble('daily_goal') ?? 2.0;
      _weeklyGoal = prefs.getDouble('weekly_goal') ?? 10.0;
    });
  }

  Future<void> _loadProgress() async {
    final prefs = await SharedPreferences.getInstance();
    final sessionsJson = prefs.getStringList('sessions') ?? [];
    final sessions = sessionsJson
        .map((json) => jsonDecode(json) as Map<String, dynamic>)
        .toList();
    
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    double todayHours = 0.0;
    double weekHours = 0.0;
    
    final now = DateTime.now();
    for (int i = 0; i < 7; i++) {
      final date = now.subtract(Duration(days: i));
      final dateStr = DateFormat('yyyy-MM-dd').format(date);
      
      for (final session in sessions) {
        final sessionDate = DateTime.parse(session['date'] as String);
        final sessionDateStr = DateFormat('yyyy-MM-dd').format(sessionDate);
        
        if (sessionDateStr == dateStr) {
          final hours = (session['duration'] as int) / 3600.0;
          weekHours += hours;
          if (sessionDateStr == today) {
            todayHours += hours;
          }
        }
      }
    }
    
    setState(() {
      _todayProgress = todayHours;
      _weekProgress = weekHours;
    });
  }

  Future<void> _saveGoals() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('daily_goal', _dailyGoal);
    await prefs.setDouble('weekly_goal', _weeklyGoal);
  }

  @override
  Widget build(BuildContext context) {
    final dailyPercentage = (_dailyGoal > 0) ? (_todayProgress / _dailyGoal * 100).clamp(0.0, 100.0) : 0.0;
    final weeklyPercentage = (_weeklyGoal > 0) ? (_weekProgress / _weeklyGoal * 100).clamp(0.0, 100.0) : 0.0;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('🎯 Günlük ve Haftalık Hedefler', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF1E1E1E),
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Günlük Hedef
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E1E),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xFF00E676).withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Günlük Hedef',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.edit, color: Color(0xFF00E676)),
                        onPressed: () {
                          _showGoalDialog(true);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${_todayProgress.toStringAsFixed(1)} / ${_dailyGoal.toStringAsFixed(1)} Saat',
                            style: const TextStyle(
                              color: Color(0xFF00E676),
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${dailyPercentage.toStringAsFixed(0)}% Tamamlandı',
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 80,
                        height: 80,
                        child: CircularProgressIndicator(
                          value: dailyPercentage / 100,
                          strokeWidth: 8,
                          backgroundColor: Colors.grey[800],
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            Color(0xFF00E676),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  LinearProgressIndicator(
                    value: dailyPercentage / 100,
                    backgroundColor: Colors.grey[800],
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Color(0xFF00E676),
                    ),
                    minHeight: 8,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            
            // Haftalık Hedef
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E1E),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xFF2979FF).withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Haftalık Hedef',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.edit, color: Color(0xFF2979FF)),
                        onPressed: () {
                          _showGoalDialog(false);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${_weekProgress.toStringAsFixed(1)} / ${_weeklyGoal.toStringAsFixed(1)} Saat',
                            style: const TextStyle(
                              color: Color(0xFF2979FF),
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${weeklyPercentage.toStringAsFixed(0)}% Tamamlandı',
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 80,
                        height: 80,
                        child: CircularProgressIndicator(
                          value: weeklyPercentage / 100,
                          strokeWidth: 8,
                          backgroundColor: Colors.grey[800],
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            Color(0xFF2979FF),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  LinearProgressIndicator(
                    value: weeklyPercentage / 100,
                    backgroundColor: Colors.grey[800],
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Color(0xFF2979FF),
                    ),
                    minHeight: 8,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            
            // Motivasyon Mesajı
            if (dailyPercentage >= 100 || weeklyPercentage >= 100)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF00E676),
                      Color(0xFF2979FF),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    const Icon(
                      Icons.celebration,
                      color: Colors.white,
                      size: 48,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      '🎉 Tebrikler! 🎉',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      dailyPercentage >= 100
                          ? 'Günlük hedefini tamamladın!'
                          : 'Haftalık hedefini tamamladın!',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _showGoalDialog(bool isDaily) {
    final controller = TextEditingController(
      text: (isDaily ? _dailyGoal : _weeklyGoal).toStringAsFixed(1),
    );
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E1E),
        title: Text(
          isDaily ? 'Günlük Hedef' : 'Haftalık Hedef',
          style: const TextStyle(color: Colors.white),
        ),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            labelText: 'Hedef (Saat)',
            labelStyle: TextStyle(color: Colors.grey[400]),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[600]!),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF00E676)),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('İptal', style: TextStyle(color: Colors.grey[400])),
          ),
          TextButton(
            onPressed: () {
              final value = double.tryParse(controller.text);
              if (value != null && value > 0) {
                setState(() {
                  if (isDaily) {
                    _dailyGoal = value;
                  } else {
                    _weeklyGoal = value;
                  }
                });
                _saveGoals();
                _loadProgress();
                Navigator.pop(context);
              }
            },
            child: const Text(
              'Kaydet',
              style: TextStyle(color: Color(0xFF00E676)),
            ),
          ),
        ],
      ),
    );
  }
}

// Görevler Ekranı
class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  List<Map<String, dynamic>> _tasks = [];
  final TextEditingController _taskController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  String _filterCategory = 'all';
  String _sortBy = 'date'; // date, priority, category
  String _filterPriority = 'all';
  bool _showCompleted = true;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadTasks();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.toLowerCase();
      });
    });
  }

  Future<void> _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final tasksJson = prefs.getStringList('tasks') ?? [];
    final tasks = tasksJson
        .map((json) => jsonDecode(json) as Map<String, dynamic>)
        .toList();
    
    setState(() {
      _tasks = tasks;
    });
  }

  Future<void> _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final tasksJson = _tasks.map((task) => jsonEncode(task)).toList();
    await prefs.setStringList('tasks', tasksJson);
  }

  Future<void> _addTask() async {
    if (_taskController.text.trim().isEmpty) return;
    
    // Hızlı ekleme - direkt görev ekle
    final task = {
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'title': _taskController.text.trim(),
      'notes': '',
      'completed': false,
      'category': _filterCategory != 'all' ? _filterCategory : 'other',
      'priority': 'medium',
      'createdAt': DateTime.now().toIso8601String(),
    };
    
    setState(() {
      _tasks.insert(0, task);
    });
    
    await _saveTasks();
    _taskController.clear();
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Görev eklendi! ✅'),
          backgroundColor: Color(0xFF00E676),
          duration: Duration(seconds: 1),
        ),
      );
    }
  }

  Future<void> _addTaskDetailed() async {
    await _showAddTaskDialog();
  }

  Future<void> _showAddTaskDialog({Map<String, dynamic>? existingTask}) async {
    final titleController = TextEditingController(text: existingTask?['title'] ?? _taskController.text);
    final notesController = TextEditingController(text: existingTask?['notes'] ?? '');
    String selectedCategory = existingTask?['category'] ?? _filterCategory != 'all' ? _filterCategory : 'other';
    String selectedPriority = existingTask?['priority'] ?? 'medium';
    DateTime? dueDate = existingTask?['dueDate'] != null 
        ? DateTime.parse(existingTask!['dueDate'] as String)
        : null;
    
    await showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          backgroundColor: const Color(0xFF1E1E1E),
                  title: Text(
            existingTask != null ? 'Görevi Düzenle' : 'Yeni Çalışma Görevi Ekle',
            style: const TextStyle(color: Colors.white),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: titleController,
                  style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Çalışma Konusu / Görev Başlığı',
                      labelStyle: TextStyle(color: Colors.grey[400]),
                      hintText: 'Örn: TYT Matematik Deneme Çöz, AYT Fizik Konu Tekrarı...',
                      hintStyle: TextStyle(color: Colors.grey[600], fontSize: 12),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[600]!),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF00E676)),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: notesController,
                  maxLines: 3,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      labelText: 'Notlar / Hatırlatıcılar',
                      labelStyle: TextStyle(color: Colors.grey[400]),
                      hintText: 'Önemli noktalar, hatırlatmalar...',
                      hintStyle: TextStyle(color: Colors.grey[600], fontSize: 12),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[600]!),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF00E676)),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text('Kategori', style: TextStyle(color: Colors.white, fontSize: 14)),
                const SizedBox(height: 8),
                SizedBox(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      final isSelected = selectedCategory == category['id'];
                      return GestureDetector(
                        onTap: () {
                          setDialogState(() {
                            selectedCategory = category['id'] as String;
                          });
                        },
                        child: Container(
                          width: 70,
                          margin: const EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            color: isSelected 
                                ? (category['color'] as Color).withOpacity(0.2)
                                : const Color(0xFF1E1E1E),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: isSelected 
                                  ? category['color'] as Color
                                  : Colors.grey.withOpacity(0.2),
                              width: isSelected ? 2 : 1,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                category['icon'] as IconData,
                                color: isSelected ? category['color'] as Color : Colors.grey,
                                size: 24,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                category['name'] as String,
                                style: TextStyle(
                                  color: isSelected ? category['color'] as Color : Colors.grey,
                                  fontSize: 10,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                const Text('Öncelik', style: TextStyle(color: Colors.white, fontSize: 14)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _buildPriorityChip('high', 'Yüksek', Colors.red, selectedPriority, (value) {
                      setDialogState(() => selectedPriority = value);
                    }),
                    const SizedBox(width: 8),
                    _buildPriorityChip('medium', 'Orta', Colors.orange, selectedPriority, (value) {
                      setDialogState(() => selectedPriority = value);
                    }),
                    const SizedBox(width: 8),
                    _buildPriorityChip('low', 'Düşük', Colors.grey, selectedPriority, (value) {
                      setDialogState(() => selectedPriority = value);
                    }),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('İptal', style: TextStyle(color: Colors.grey[400])),
            ),
            TextButton(
              onPressed: () async {
                if (titleController.text.trim().isEmpty) return;
                
                final task = {
                  'id': existingTask?['id'] ?? DateTime.now().millisecondsSinceEpoch.toString(),
                  'title': titleController.text.trim(),
                  'notes': notesController.text.trim(),
                  'category': selectedCategory,
                  'priority': selectedPriority,
                  'completed': existingTask?['completed'] ?? false,
                  'createdAt': existingTask?['createdAt'] ?? DateTime.now().toIso8601String(),
                  'dueDate': dueDate?.toIso8601String(),
                };
                
                if (existingTask != null) {
                  setState(() {
                    final index = _tasks.indexWhere((t) => t['id'] == existingTask['id']);
                    if (index != -1) {
                      _tasks[index] = task;
                    }
                  });
                } else {
                  setState(() {
                    _tasks.insert(0, task);
                  });
                }
                
                await _saveTasks();
                _taskController.clear();
                Navigator.pop(context);
                
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(existingTask != null ? 'Görev güncellendi! ✅' : 'Görev eklendi! ✅'),
                      backgroundColor: const Color(0xFF00E676),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                }
              },
              child: const Text('Kaydet', style: TextStyle(color: Color(0xFF00E676))),
            ),
          ],
        ),
      ),
    );
    
    titleController.dispose();
    notesController.dispose();
  }

  Widget _buildPriorityChip(String value, String label, Color color, String selected, ValueChanged<String> onTap) {
    final isSelected = selected == value;
    return GestureDetector(
      onTap: () => onTap(value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? color : Colors.grey.withOpacity(0.3),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? color : Colors.grey,
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Future<void> _toggleTask(String id) async {
    setState(() {
      final index = _tasks.indexWhere((task) => task['id'] == id);
      if (index != -1) {
        _tasks[index]['completed'] = !(_tasks[index]['completed'] as bool);
      }
    });
    await _saveTasks();
  }

  Future<void> _editTask(Map<String, dynamic> task) async {
    await _showAddTaskDialog(existingTask: task);
  }

  Future<void> _deleteTask(String id) async {
    setState(() {
      _tasks.removeWhere((task) => task['id'] == id);
    });
    await _saveTasks();
  }

  List<Map<String, dynamic>> _getFilteredTasks() {
    var filtered = _tasks.where((task) {
      // Tamamlananları filtrele
      if (!_showCompleted && task['completed'] as bool) return false;
      
      // Kategori filtresi
      if (_filterCategory != 'all' && task['category'] != _filterCategory) return false;
      
      // Öncelik filtresi
      if (_filterPriority != 'all' && task['priority'] != _filterPriority) return false;
      
      // Arama filtresi
      if (_searchQuery.isNotEmpty) {
        final title = (task['title'] as String).toLowerCase();
        final notes = (task['notes'] as String? ?? '').toLowerCase();
        if (!title.contains(_searchQuery) && !notes.contains(_searchQuery)) {
          return false;
        }
      }
      
      return true;
    }).toList();
    
    // Sıralama
    filtered.sort((a, b) {
      switch (_sortBy) {
        case 'priority':
          final priorityOrder = {'high': 3, 'medium': 2, 'low': 1};
          final aPriority = priorityOrder[a['priority']] ?? 1;
          final bPriority = priorityOrder[b['priority']] ?? 1;
          return bPriority.compareTo(aPriority);
        case 'category':
          return (a['category'] as String).compareTo(b['category'] as String);
        case 'date':
        default:
          final aDate = DateTime.parse(a['createdAt'] as String);
          final bDate = DateTime.parse(b['createdAt'] as String);
          return bDate.compareTo(aDate);
      }
    });
    
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    final filteredTasks = _getFilteredTasks();
    final pendingTasks = filteredTasks.where((task) => !(task['completed'] as bool)).toList();
    final completedTasks = filteredTasks.where((task) => task['completed'] as bool).toList();
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('📋 Çalışma Planım', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF1E1E1E),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.auto_awesome, color: Color(0xFF00E676)),
            onPressed: _showTaskTemplates,
            tooltip: 'Hazır Şablonlar',
          ),
          IconButton(
            icon: Icon(_showCompleted ? Icons.visibility : Icons.visibility_off, color: Colors.white),
            onPressed: () {
              setState(() {
                _showCompleted = !_showCompleted;
              });
            },
            tooltip: 'Tamamlananları göster/gizle',
          ),
        ],
      ),
      body: Column(
        children: [
          // Arama ve Filtreler
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF1E1E1E),
              border: Border(bottom: BorderSide(color: Colors.grey[800]!, width: 1)),
            ),
            child: Column(
              children: [
                // Arama
                TextField(
                  controller: _searchController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Görev ara...',
                    hintStyle: TextStyle(color: Colors.grey[500]),
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear, color: Colors.grey),
                            onPressed: () {
                              _searchController.clear();
                            },
                          )
                        : null,
                    filled: true,
                    fillColor: Colors.grey[900],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                // Filtreler
                Row(
                  children: [
                    Expanded(
                      child: _buildFilterChip('Kategori', _filterCategory, [
                        {'value': 'all', 'label': 'Tümü'},
                        ...categories.map((c) => {'value': c['id'], 'label': c['name']}),
                      ], (value) {
                        setState(() {
                          _filterCategory = value as String;
                        });
                      }),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _buildFilterChip('Öncelik', _filterPriority, [
                        {'value': 'all', 'label': 'Tümü'},
                        {'value': 'high', 'label': 'Yüksek'},
                        {'value': 'medium', 'label': 'Orta'},
                        {'value': 'low', 'label': 'Düşük'},
                      ], (value) {
                        setState(() {
                          _filterPriority = value as String;
                        });
                      }),
                    ),
                    const SizedBox(width: 8),
                    PopupMenuButton<String>(
                      icon: const Icon(Icons.sort, color: Colors.white),
                      color: const Color(0xFF1E1E1E),
                      onSelected: (value) {
                        setState(() {
                          _sortBy = value;
                        });
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 'date',
                          child: Row(
                            children: [
                              Icon(_sortBy == 'date' ? Icons.check : null, color: const Color(0xFF00E676)),
                              const SizedBox(width: 8),
                              const Text('Tarihe Göre', style: TextStyle(color: Colors.white)),
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          value: 'priority',
                          child: Row(
                            children: [
                              Icon(_sortBy == 'priority' ? Icons.check : null, color: const Color(0xFF00E676)),
                              const SizedBox(width: 8),
                              const Text('Önceliğe Göre', style: TextStyle(color: Colors.white)),
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          value: 'category',
                          child: Row(
                            children: [
                              Icon(_sortBy == 'category' ? Icons.check : null, color: const Color(0xFF00E676)),
                              const SizedBox(width: 8),
                              const Text('Kategoriye Göre', style: TextStyle(color: Colors.white)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Hızlı Ekleme
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF1E1E1E),
              border: Border(bottom: BorderSide(color: Colors.grey[800]!, width: 1)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _taskController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Hızlı çalışma görevi ekle (Örn: TYT Mat Deneme)...',
                      hintStyle: TextStyle(color: Colors.grey[500]),
                      filled: true,
                      fillColor: Colors.grey[900],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                    onSubmitted: (value) => _addTask(),
                  ),
                ),
                const SizedBox(width: 12),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.add_circle, color: Color(0xFF00E676), size: 36),
                      onPressed: _addTask,
                      tooltip: 'Hızlı Ekle',
                    ),
                    IconButton(
                      icon: const Icon(Icons.add_circle_outline, color: Color(0xFF2979FF), size: 28),
                      onPressed: _addTaskDetailed,
                      tooltip: 'Detaylı Ekle',
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                if (pendingTasks.isNotEmpty) ...[
                  Row(
                    children: [
                      const Text('📚 Yapılacaklar', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFF00E676).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '${pendingTasks.length} Görev',
                          style: const TextStyle(color: Color(0xFF00E676), fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ...pendingTasks.map((task) => _buildTaskCard(task)),
                  const SizedBox(height: 24),
                ],
                if (completedTasks.isNotEmpty) ...[
                  Row(
                    children: [
                      Text('✅ Tamamlananlar', style: TextStyle(color: Colors.grey[400], fontSize: 18, fontWeight: FontWeight.bold)),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '${completedTasks.length} Görev',
                          style: TextStyle(color: Colors.grey[400], fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ...completedTasks.map((task) => _buildTaskCard(task)),
                ],
                if (_tasks.isEmpty)
                  Container(
                    padding: const EdgeInsets.all(48),
                    child: Column(
                      children: [
                        Icon(Icons.school, size: 64, color: Colors.grey[600]),
                        const SizedBox(height: 16),
                        Text(
                          'Henüz çalışma görevi yok',
                          style: TextStyle(color: Colors.grey[500], fontSize: 16),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Hızlı ekleme ile görev ekleyin\nveya hazır şablonları kullanın!',
                          style: TextStyle(color: Colors.grey[600], fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton.icon(
                          onPressed: _showTaskTemplates,
                          icon: const Icon(Icons.auto_awesome),
                          label: const Text('Hazır Şablonlar'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2979FF),
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, String selected, List<Map<String, dynamic>> options, ValueChanged<dynamic> onSelected) {
    return PopupMenuButton<dynamic>(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey[700]!),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              options.firstWhere((o) => o['value'] == selected)['label'] as String,
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
            const SizedBox(width: 4),
            const Icon(Icons.arrow_drop_down, color: Colors.grey, size: 20),
          ],
        ),
      ),
      color: const Color(0xFF1E1E1E),
      onSelected: onSelected,
      itemBuilder: (context) => options.map((option) {
        final isSelected = option['value'] == selected;
        return PopupMenuItem(
          value: option['value'],
          child: Row(
            children: [
              Icon(isSelected ? Icons.check : null, color: const Color(0xFF00E676), size: 20),
              const SizedBox(width: 8),
              Text(option['label'] as String, style: const TextStyle(color: Colors.white)),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildTaskCard(Map<String, dynamic> task) {
    final isCompleted = task['completed'] as bool;
    final category = categories.firstWhere(
      (c) => c['id'] == (task['category'] as String? ?? 'other'),
      orElse: () => categories.last,
    );
    final priority = task['priority'] as String? ?? 'medium';
    final notes = task['notes'] as String? ?? '';
    final hasNotes = notes.isNotEmpty;
    
    Color priorityColor;
    String priorityLabel;
    switch (priority) {
      case 'high':
        priorityColor = Colors.red;
        priorityLabel = 'Yüksek';
        break;
      case 'medium':
        priorityColor = Colors.orange;
        priorityLabel = 'Orta';
        break;
      default:
        priorityColor = Colors.grey;
        priorityLabel = 'Düşük';
    }
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: (category['color'] as Color).withOpacity(0.3),
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: () => _showAddTaskDialog(existingTask: task),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Checkbox(
                  value: isCompleted,
                  onChanged: (value) => _toggleTask(task['id'] as String),
                  activeColor: const Color(0xFF00E676),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task['title'] as String,
                        style: TextStyle(
                          color: isCompleted ? Colors.grey[500] : Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          decoration: isCompleted ? TextDecoration.lineThrough : null,
                        ),
                      ),
                      if (hasNotes) ...[
                        const SizedBox(height: 4),
                        Text(
                          notes,
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 12,
                            fontStyle: FontStyle.italic,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.edit_outlined, color: Color(0xFF2979FF), size: 20),
                  onPressed: () => _showAddTaskDialog(existingTask: task),
                  tooltip: 'Düzenle',
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.red, size: 20),
                  onPressed: () => _deleteTask(task['id'] as String),
                  tooltip: 'Sil',
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: priorityColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    priorityLabel,
                    style: TextStyle(color: priorityColor, fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 8),
                Icon(category['icon'] as IconData, size: 16, color: category['color'] as Color),
                const SizedBox(width: 4),
                Text(
                  category['name'] as String,
                  style: TextStyle(color: Colors.grey[400], fontSize: 11),
                ),
                const Spacer(),
                if (hasNotes)
                  const Icon(Icons.note, size: 16, color: Colors.grey),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showTaskTemplates() async {
    final templates = [
      {'title': 'TYT Matematik Deneme', 'category': 'tyt', 'notes': '40 soru, 75 dakika'},
      {'title': 'AYT Fizik Konu Tekrarı', 'category': 'ayt', 'notes': 'Hareket ve Kuvvet konusu'},
      {'title': 'YDS Kelime Çalışması', 'category': 'yds', 'notes': '100 kelime ezberleme'},
      {'title': 'KPSS Genel Kültür Tekrar', 'category': 'kpss', 'notes': 'Tarih ve Coğrafya'},
      {'title': 'TYT Türkçe Paragraf', 'category': 'tyt', 'notes': '20 paragraf sorusu'},
      {'title': 'AYT Kimya Organik Kimya', 'category': 'ayt', 'notes': 'Karbon bileşikleri'},
      {'title': 'YDS Reading Practice', 'category': 'yds', 'notes': '5 okuma parçası'},
      {'title': 'KPSS Vatandaşlık', 'category': 'kpss', 'notes': 'Anayasa tekrarı'},
    ];

    if (mounted) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: const Color(0xFF1E1E1E),
          title: const Text('Hazır Çalışma Şablonları', style: TextStyle(color: Colors.white)),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: templates.length,
              itemBuilder: (context, index) {
                final template = templates[index];
                final category = categories.firstWhere(
                  (c) => c['id'] == template['category'],
                  orElse: () => categories.last,
                );
                return ListTile(
                  leading: Icon(category['icon'] as IconData, color: category['color'] as Color),
                  title: Text(template['title'] as String, style: const TextStyle(color: Colors.white)),
                  subtitle: Text(template['notes'] as String, style: TextStyle(color: Colors.grey[400], fontSize: 12)),
                  onTap: () {
                    final task = {
                      'id': DateTime.now().millisecondsSinceEpoch.toString(),
                      'title': template['title'] as String,
                      'notes': template['notes'] as String,
                      'category': template['category'] as String,
                      'priority': 'medium',
                      'completed': false,
                      'createdAt': DateTime.now().toIso8601String(),
                    };
                    
                    setState(() {
                      _tasks.insert(0, task);
                    });
                    
                    _saveTasks();
                    Navigator.pop(context);
                    
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Şablon görevi eklendi! ✅'),
                          backgroundColor: Color(0xFF00E676),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    }
                  },
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Kapat', style: TextStyle(color: Color(0xFF00E676))),
            ),
          ],
        ),
      );
    }
  }

  @override
  void dispose() {
    _taskController.dispose();
    _searchController.dispose();
    super.dispose();
  }
}

// Ayarlar Ekranı - Basitleştirilmiş versiyon
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  int _pomodoroMinutes = 25;
  int _breakMinutes = 5;
  bool _enableSounds = true;
  bool _enableNotifications = true;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _pomodoroMinutes = prefs.getInt('pomodoro_minutes') ?? 25;
      _breakMinutes = prefs.getInt('break_minutes') ?? 5;
      _enableSounds = prefs.getBool('enable_sounds') ?? true;
      _enableNotifications = prefs.getBool('enable_notifications') ?? true;
    });
  }

  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('pomodoro_minutes', _pomodoroMinutes);
    await prefs.setInt('break_minutes', _breakMinutes);
    await prefs.setBool('enable_sounds', _enableSounds);
    await prefs.setBool('enable_notifications', _enableNotifications);
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Ayarlar kaydedildi! ✅'),
          backgroundColor: Color(0xFF00E676),
          duration: Duration(seconds: 1),
        ),
      );
    }
  }

  Future<void> _exportData() async {
    final prefs = await SharedPreferences.getInstance();
    final data = {
      'sessions': prefs.getStringList('sessions') ?? [],
      'tasks': prefs.getStringList('tasks') ?? [],
      'badges': prefs.getStringList('badges') ?? [],
      'total_seconds': prefs.getInt('total_seconds') ?? 0,
      'xp': prefs.getInt('xp') ?? 0,
      'streak': prefs.getInt('streak') ?? 0,
    };
    
    final jsonString = jsonEncode(data);
    
    if (mounted) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: const Color(0xFF1E1E1E),
          title: const Text('Verileri Dışa Aktar', style: TextStyle(color: Colors.white)),
          content: SingleChildScrollView(
            child: SelectableText(jsonString, style: const TextStyle(color: Colors.white, fontSize: 12)),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Kapat', style: TextStyle(color: Color(0xFF00E676))),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ayarlar', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF1E1E1E),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('Pomodoro Ayarları', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          ListTile(
            title: const Text('Çalışma Süresi (dakika)', style: TextStyle(color: Colors.white)),
            subtitle: Text('$_pomodoroMinutes', style: TextStyle(color: Colors.grey[400])),
            trailing: const Icon(Icons.chevron_right, color: Colors.grey),
            onTap: () async {
              final result = await _showNumberPicker(context, _pomodoroMinutes, 5, 60);
              if (result != null) {
                setState(() => _pomodoroMinutes = result);
                await _saveSettings();
              }
            },
          ),
          ListTile(
            title: const Text('Mola Süresi (dakika)', style: TextStyle(color: Colors.white)),
            subtitle: Text('$_breakMinutes', style: TextStyle(color: Colors.grey[400])),
            trailing: const Icon(Icons.chevron_right, color: Colors.grey),
            onTap: () async {
              final result = await _showNumberPicker(context, _breakMinutes, 1, 30);
              if (result != null) {
                setState(() => _breakMinutes = result);
                await _saveSettings();
              }
            },
          ),
          const SizedBox(height: 24),
          const Text('Bildirimler', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          SwitchListTile(
            title: const Text('Sesleri Aktif Et', style: TextStyle(color: Colors.white)),
            value: _enableSounds,
            onChanged: (value) {
              setState(() => _enableSounds = value);
              _saveSettings();
            },
            activeColor: const Color(0xFF00E676),
          ),
          SwitchListTile(
            title: const Text('Bildirimleri Aktif Et', style: TextStyle(color: Colors.white)),
            value: _enableNotifications,
            onChanged: (value) {
              setState(() => _enableNotifications = value);
              _saveSettings();
            },
            activeColor: const Color(0xFF00E676),
          ),
          const SizedBox(height: 24),
          const Text('Veri Yönetimi', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          ListTile(
            leading: const Icon(Icons.download, color: Color(0xFF2979FF)),
            title: const Text('Verileri Dışa Aktar', style: TextStyle(color: Colors.white)),
            subtitle: const Text('Tüm verilerinizi JSON formatında dışa aktar', style: TextStyle(color: Colors.grey)),
            onTap: _exportData,
          ),
        ],
      ),
    );
  }

  Future<int?> _showNumberPicker(BuildContext context, int initialValue, int min, int max) async {
    int? selectedValue;
    await showDialog(
      context: context,
      builder: (context) {
        int tempValue = initialValue;
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            backgroundColor: const Color(0xFF1E1E1E),
            title: const Text('Değer Seç', style: TextStyle(color: Colors.white)),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.remove_circle, color: Color(0xFF00E676)),
                  onPressed: tempValue > min ? () => setState(() => tempValue--) : null,
                ),
                SizedBox(
                  width: 80,
                  child: Text('$tempValue', style: const TextStyle(color: Colors.white, fontSize: 24), textAlign: TextAlign.center),
                ),
                IconButton(
                  icon: const Icon(Icons.add_circle, color: Color(0xFF00E676)),
                  onPressed: tempValue < max ? () => setState(() => tempValue++) : null,
                ),
              ],
            ),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context), child: Text('İptal', style: TextStyle(color: Colors.grey[400]))),
              TextButton(
                onPressed: () {
                  selectedValue = tempValue;
                  Navigator.pop(context);
                },
                child: const Text('Kaydet', style: TextStyle(color: Color(0xFF00E676))),
              ),
            ],
          ),
        );
      },
    );
    return selectedValue;
  }
}
